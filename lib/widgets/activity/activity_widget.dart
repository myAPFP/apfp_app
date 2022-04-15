// Copyright 2022 The myAPFP Authors. All rights reserved.

import 'dart:io';

import '/util/goals/exercise_time_goal.dart';
import '/util/goals/goal.dart';
import '/util/health/healthUtil.dart';

import '/firebase/firestore.dart';

import '../activity_card/activity_card.dart';

import '/flutter_flow/flutter_flow_theme.dart';

import '../add_activity/add_activity_widget.dart';

import '../confimation_dialog/confirmation_dialog.dart';

import '/widgets/health_app_info/health_app_info.dart';

import 'package:health/health.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';

class ActivityWidget extends StatefulWidget {
  final Stream<DocumentSnapshot<Map<String, dynamic>>> activityStream;
  ActivityWidget({Key? key, required this.activityStream}) : super(key: key);

  @override
  _ActivityWidgetState createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<ActivityWidget> {
  /// The image a user captures after pressing "+ Image/Share" in an activity card's
  /// focused menu.
  ///
  /// If a user captures an image but declines to share it, this is reset to null.
  XFile? image;

  /// A list of the user's activity cards.
  List<Padding> cards = [];

  /// Serves as key for the [Scaffold] found in [build].
  final scaffoldKey = GlobalKey<ScaffoldState>();

  /// Stores a user's activity document snapshots.
  late Map<String, dynamic> currentSnapshotBackup;

  /// Special activity id reserved for an imported activity.
  ///
  /// Using this id ensures:
  /// - Only one imported activity card appears, and is updated as needed.
  /// - The imported activity card always appears at the top of the [cards]
  /// list.
  String importedActivityID = "3000-12-${DateTime.now().day}T00:00:00.000";

  @override
  void initState() {
    super.initState();
    _collectActivity();
  }

  /// Synchronizes iOS Health App data with myAPFP.
  void _syncIOSHealthData(HealthFactory health) async {
    await health
        .requestAuthorization([HealthDataType.WORKOUT]).then((value) async {
      if (value) {
        DateTime now = DateTime.now();
        final midnight = DateTime(now.year, now.month, now.day);
        await health.getHealthDataFromTypes(
            midnight, now, [HealthDataType.WORKOUT]).then((value) {
          for (HealthDataPoint dataPoint in value) {
            _addImportedCard(dataPoint.dateTo
                    .difference(dataPoint.dateFrom)
                    .inMinutes
                    .toString() +
                " Minutes");
          }
        });
      }
    });
  }

  /// Synchronizes Android Health App data with myAPFP.
  void _syncAndroidHealthData(HealthFactory health) async {
    bool requested;
    if (await Permission.activityRecognition.status.isGranted) {
      requested =
          await health.requestAuthorization([HealthDataType.MOVE_MINUTES]);
      if (requested) {
        try {
          DateTime now = DateTime.now();
          final midnight = DateTime(now.year, now.month, now.day);
          List<HealthDataPoint> healthData = await health
              .getHealthDataFromTypes(
                  midnight, now, [HealthDataType.MOVE_MINUTES]);
          var moveMinutes = HealthUtil.getHealthSums(healthData.toSet());
          _addImportedCard("${moveMinutes.round()} Minutes");
        } catch (error) {
          print("Activity data could not be retreived: $error ");
        }
      }
    }
  }

  /// Synchronizes Health App data with myAPFP based on current platform.
  void _syncHealthAppData() async {
    final health = HealthFactory();
    if (Platform.isIOS) {
      _syncIOSHealthData(health);
    } else if (Platform.isAndroid) {
      _syncAndroidHealthData(health);
    }
  }

  /// Fetches a user's activity data from Firestore and displays them.
  void _collectActivity() {
    widget.activityStream.forEach((element) {
      Map sortedMap = new Map();
      currentSnapshotBackup = new Map();
      if (element.data() != null) {
        currentSnapshotBackup = element.data()!;
        currentSnapshotBackup.forEach((key, value) {
          if (DateTime.parse(key).day != DateTime.now().day) {
            Map<String, dynamic> buffer = element.data()!;
            buffer.remove(key);
            FireStore.updateWorkoutData(buffer);
          }
        });
      }
      setState(() => cards.clear());
      sortedMap = Map.fromEntries(currentSnapshotBackup.entries.toList()
        ..sort((e1, e2) => e2.key.compareTo(e1.key)));
      sortedMap.forEach((key, value) => addCard(ActivityCard(
            icon: Icons.emoji_events_rounded,
            duration: value[2],
            name: value[0],
            type: value[1],
            timestamp: key != null
                ? DateTime.parse(key).toIso8601String()
                : DateTime.now().toIso8601String()
          ).paddedActivityCard(context)));
    });
  }

  /// Adds [ActivityCard]'s info to the user's activity document in Firestore.
  void _addActivityToCloud(ActivityCard activityCard) {
    currentSnapshotBackup.putIfAbsent(activityCard.timestamp.toString(),
        () => [activityCard.name, activityCard.type, activityCard.duration]);
    FireStore.updateWorkoutData(currentSnapshotBackup);
  }

  /// Adds an imported [ActivityCard]'s info to the user's activity document 
  /// in Firestore.
  void _addImportedCard(String duration) {
    var activityCard = ActivityCard(
      icon: Icons.emoji_events_rounded,
      duration: duration,
      name: "Imported Workout",
      type: "Exercise Minutes",
      timestamp: importedActivityID,
    );
    _removeActivityFromCloud(importedActivityID);
    _addActivityToCloud(activityCard);
    var activitySnapShot = {
      DateTime.now().toIso8601String(): ["", "", duration]
    };
    Goal.userProgressExerciseTimeWeekly +=
        ExerciseGoal.totalTimeInMinutes(activitySnapShot);
  }

  /// Removes an activity from Firestore.
  ///
  /// The [id] represents the activity's id, which is the timestamp in
  /// which it was created.
  void _removeActivityFromCloud(String id) {
    if (currentSnapshotBackup.isNotEmpty) {
      _updateCustomWeeklyGoalProgress();
      currentSnapshotBackup
          .removeWhere((key, durationInMinutes) => (key == id.split(' ')[0]));
    }
    if (id.split(' ')[0] == importedActivityID) {
      currentSnapshotBackup
          .removeWhere((key, durationInMinutes) => key == importedActivityID);
    }
    FireStore.updateWorkoutData(currentSnapshotBackup);
  }

  /// Updates a user's current weekly goal progess in Firestore.
  void _updateCustomWeeklyGoalProgress() {
    String exerciseType = currentSnapshotBackup.values.first[0];
    double durationInMinutes = _getDurationInMinutes();
    double exerciseTimeWeeklyProgress =
        Goal.userProgressExerciseTimeWeekly - durationInMinutes;
    FireStore.updateGoalData(
        {"exerciseTimeGoalProgressWeekly": exerciseTimeWeeklyProgress});
    switch (exerciseType) {
      case "Cycling":
        var cycling = Goal.userProgressCyclingGoalWeekly - durationInMinutes;
        FireStore.updateGoalData({"cyclingGoalProgressWeekly": cycling});
        break;
      case "Rowing":
        var rowing = Goal.userProgressRowingGoalWeekly - durationInMinutes;
        FireStore.updateGoalData({"rowingGoalProgressWeekly": rowing});
        break;
      case "Step-Mill":
        var stepMill = Goal.userProgressStepMillGoalWeekly - durationInMinutes;
        FireStore.updateGoalData({"stepMillGoalProgressWeekly": stepMill});
        break;
      case "Elliptical":
        var elliptical =
            Goal.userProgressEllipticalGoalWeekly - durationInMinutes;
        FireStore.updateGoalData({"ellipticalGoalProgressWeekly": elliptical});
        break;
      case "Resistance":
        var resistanceStrength =
            Goal.userProgressResistanceStrengthGoalWeekly - durationInMinutes;
        FireStore.updateGoalData(
            {"resistanceStrengthGoalProgressWeekly": resistanceStrength});
        break;
    }
  }

  /// Converts an activity duration string to a [double] representing
  /// the duration in minutes.
  ///
  /// Example:
  ///
  /// ```dart
  /// String activityDurationStr = "30 seconds";
  ///
  /// double d = _getDurationInMinutes();
  ///
  /// print(d); // 0.5
  /// ```
  double _getDurationInMinutes() {
    List<String> duration =
        currentSnapshotBackup.values.first[2].toString().split(" ");
    double durationInMinutes = 0.0;
    switch (duration[1].toUpperCase()) {
      case "SECONDS":
        durationInMinutes =
            double.parse((double.parse(duration[0]) / 60).toStringAsFixed(2));
        break;
      case 'MINUTE':
      case 'MINUTES':
        durationInMinutes =
            double.parse((double.parse(duration[0])).toStringAsFixed(2));
        break;
      case 'HOUR':
      case 'HOURS':
        durationInMinutes =
            double.parse((double.parse(duration[0]) * 60).toStringAsFixed(2));
        break;
    }
    return durationInMinutes;
  }

  /// Returns the header text which is displayed at the top of the
  /// Activity screen.
  Row _headerTextRow(String text) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 16, 30, 0),
            child: Text(
              text,
              style: FlutterFlowTheme.title1,
            ),
          )
        ]),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 16, 30, 0),
              child: InkWell(
                onTap: _syncHealthAppData,
                child: Icon(
                  Icons.refresh,
                  color: FlutterFlowTheme.secondaryColor,
                ),
              ),
            )
          ],
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 16, 20, 0),
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HealthAppInfo()));
                  },
                  child: Icon(
                    Icons.help,
                    color: FlutterFlowTheme.secondaryColor,
                  )),
            )
          ],
        )
      ],
    );
  }

  /// Adds [card] to the list of cards to be displayed.
  void addCard(Padding card) {
    setState(() => cards.add(card));
  }

  /// Allows a user to share activity info with others.
  share({String? body, String? subject}) async {
    final box = context.findRenderObject() as RenderBox?;
    image == null
        ? await Share.share(body!,
            subject: subject,
            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size)
        : await Share.shareFiles([image!.path],
            text: body,
            subject: subject,
            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  /// Displays the '+ Image/Share' dialog.
  void _showShareWithImageDialog(Padding paddedActivityCard) async {
    final cardInfo = paddedActivityCard.key.toString().split(' ');
    ConfirmationDialog.showConfirmationDialog(
        context: context,
        title: Text('Share Activity?'),
        content: Text(
            'The image you just added will be included with your ${cardInfo[1]} activity.' +
                '\n\nIf you chose no, the image will be deleted.',
            style: TextStyle(fontSize: 20)),
        onSubmitTap: () async {
          share(
              subject: "New Activity Completed!",
              body: 'I completed a new activity! \n\n' +
                  'Activity: ${cardInfo[1].replaceAll(RegExp('-'), ' ')}\n' +
                  'Exercise Type: ${cardInfo[2]}\n' +
                  'Duration: ${cardInfo[3]} ${cardInfo[4].substring(0, cardInfo[4].indexOf("'"))}\n' +
                  '\nSent from the myAPFP App.');
          image = null;
          Navigator.pop(context);
        },
        onCancelTap: () {
          image = null;
          Navigator.pop(context);
        },
        cancelText: 'No',
        submitText: 'Share');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: FloatingActionButton(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        child: Icon(Icons.add),
        onPressed: () async {
          var result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddActivityWidget()));
          if (result != null) {
            _addActivityToCloud(result);
          }
        },
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          key: Key("Activity.singleChildScrollView"),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _headerTextRow('Today\'s Activity'),
              cards.length > 0
                  ? Column(
                      children: cards
                          .map((e) => FocusedMenuHolder(
                              menuWidth:
                                  MediaQuery.of(context).size.width * 0.50,
                              blurSize: 5.0,
                              menuItemExtent: 45,
                              menuBoxDecoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              duration: Duration(milliseconds: 100),
                              animateMenuItems: true,
                              blurBackgroundColor: Colors.black54,
                              bottomOffsetHeight: 100,
                              openWithTap: true,
                              menuItems: <FocusedMenuItem>[
                                FocusedMenuItem(
                                    title: Text("+ Image/Share"),
                                    trailingIcon: Icon(Icons.image),
                                    onPressed: () async {
                                      image = null;
                                      image = await ImagePicker().pickImage(
                                          source: ImageSource.camera);
                                      if (image == null) {
                                        return;
                                      } else {
                                        _showShareWithImageDialog(e);
                                      }
                                    }),
                                FocusedMenuItem(
                                    title: Text("Share"),
                                    trailingIcon: Icon(Icons.share),
                                    onPressed: () {
                                      List<String> cardInfo =
                                          e.key.toString().split(' ');
                                      share(
                                          subject: "New Activity Completed!",
                                          body: 'I completed a new activity!\n\n' +
                                              'Activity: ${cardInfo[1].replaceAll(RegExp('-'), ' ')}\n' +
                                              'Exercise Type: ${cardInfo[2]}\n' +
                                              'Duration: ${cardInfo[3] + ' ' + cardInfo[4].substring(0, cardInfo[4].indexOf("'"))}\n' +
                                              '\nSent from the myAPFP App.');
                                    }),
                                FocusedMenuItem(
                                    title: Text("Delete",
                                        style:
                                            TextStyle(color: Colors.redAccent)),
                                    trailingIcon: Icon(Icons.delete,
                                        color: Colors.redAccent),
                                    onPressed: () {
                                      final cardInfo =
                                          e.key.toString().split(' ');
                                      ConfirmationDialog.showConfirmationDialog(
                                          title: Text("Remove Activity?"),
                                          context: context,
                                          content: Text(
                                              "Do you want to remove your ${cardInfo[1]} activity?" +
                                                  "\n\nThis can't be undone.",
                                              style: TextStyle(fontSize: 20)),
                                          cancelText: 'Back',
                                          submitText: "Remove",
                                          onCancelTap: () {
                                            Navigator.pop(context);
                                          },
                                          onSubmitTap: () {
                                            setState(() {
                                              _removeActivityFromCloud(e.key
                                                  .toString()
                                                  .substring(
                                                      e.key
                                                              .toString()
                                                              .indexOf("'") +
                                                          1,
                                                      e.key
                                                          .toString()
                                                          .lastIndexOf("'")));
                                              cards.remove(e);
                                            });
                                            Navigator.pop(context);
                                          });
                                    })
                              ],
                              onPressed: () {},
                              child: e))
                          .toList())
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 50),
                        Text(
                          'No Activities Recorded!',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontFamily: 'Open Sans',
                          ),
                        ),
                      ],
                    ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
