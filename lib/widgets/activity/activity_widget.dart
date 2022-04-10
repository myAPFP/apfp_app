import 'dart:io';

import 'package:apfp/firebase/firestore.dart';
import 'package:apfp/widgets/confimation_dialog/confirmation_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:focused_menu/modals.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import '../../util/goals/goal.dart';
import '../../util/toasted/toasted.dart';
import '../add_activity/add_activity_widget.dart';
import '../activity_card/activity_card.dart';
import 'package:apfp/flutter_flow/flutter_flow_theme.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../confimation_dialog/confirmation_dialog.dart';

class ActivityWidget extends StatefulWidget {
  final Stream<DocumentSnapshot<Map<String, dynamic>>> activityStream;
  ActivityWidget({Key? key, required this.activityStream}) : super(key: key);

  @override
  _ActivityWidgetState createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<ActivityWidget> {
  List<Padding> cards = [];
  XFile? imagepick;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Map<String, dynamic> currentSnapshotBackup;

  @override
  void initState() {
    super.initState();
    _syncHealthAppData();
    _collectActivity();
  }

  void _syncIOSHealthData(HealthFactory health) async {
    await health
        .requestAuthorization([HealthDataType.WORKOUT]).then((value) async {
      if (value) {
        DateTime now = DateTime.now();
        await health.getHealthDataFromTypes(
            DateTime(now.year, now.month, now.day),
            now,
            [HealthDataType.WORKOUT]).then((value) {
          for (HealthDataPoint dataPoint in value) {
            _addActivityToCloud(
              ActivityCard(
                  icon: Icons.emoji_events_rounded,
                  duration: dataPoint.dateTo
                          .difference(dataPoint.dateFrom)
                          .inMinutes
                          .toString() +
                      " minutes",
                  name: "Imported Activity",
                  type: "Exercise",
                  timestamp: DateFormat.jm().format(dataPoint.dateTo)),
            );
          }
        });
      }
    });
  }

  void _syncAndroidHealthData(HealthFactory health) async {
    bool requested;
    List<HealthDataType> types = List.empty(growable: true);
    types.addAll([
      HealthDataType.MOVE_MINUTES,
      HealthDataType.ACTIVE_ENERGY_BURNED,
      HealthDataType.STEPS,
      HealthDataType.DISTANCE_DELTA
    ]);
    if (await Permission.activityRecognition.status.isGranted) {
      requested = await health.requestAuthorization(types);
      if (requested) {
        try {
          DateTime now = DateTime.now();
          List<HealthDataPoint> healthData =
              await health.getHealthDataFromTypes(
                  DateTime(now.year, now.month, now.day), now, types);
          for (HealthDataPoint dataPoint in healthData) {
            _addActivityToCloud(
              ActivityCard(
                  icon: Icons.emoji_events_rounded,
                  duration: dataPoint.value.toString() + " minutes",
                  name: "Imported Activity",
                  type: "Exercise",
                  timestamp: DateFormat.jm().format(dataPoint.dateTo)),
            );
          }
        } catch (error) {
          Toasted.showToast("Activity data could not be retreived: $error ");
        }
      }
    }
  }

  void _syncHealthAppData() async {
    if (Platform.isIOS) {
      _syncIOSHealthData(new HealthFactory());
    } else if (Platform.isAndroid) {
      _syncAndroidHealthData(new HealthFactory());
    }
  }

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
                  : DateTime.now().toIso8601String())
          .paddedActivityCard(context)));
    });
  }

  void _addActivityToCloud(ActivityCard activityCard) {
    currentSnapshotBackup.putIfAbsent(activityCard.timestamp.toString(),
        () => [activityCard.name, activityCard.type, activityCard.duration]);
    FireStore.updateWorkoutData(currentSnapshotBackup);
  }

  void _removeActivityFromCloud(String id) {
    _updateCustomWeeklyGoalProgress();
    currentSnapshotBackup
        .removeWhere((key, durationInMinutes) => (key == id.split(' ')[0]));
    FireStore.updateWorkoutData(currentSnapshotBackup);
  }

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

  Row _headerTextRow(String text) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 16, 24, 0),
          child: Text(
            text,
            style: FlutterFlowTheme.title1,
          ),
        ),
      ],
    );
  }

  void addCard(Padding card) {
    setState(() => cards.add(card));
  }

  share({String? body, String? subject}) async {
    final box = context.findRenderObject() as RenderBox?;
    imagepick == null
        ? await Share.share(body!,
            subject: subject,
            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size)
        : await Share.shareFiles([imagepick!.path],
            text: body,
            subject: subject,
            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

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
          imagepick = null;
          Navigator.pop(context);
        },
        onCancelTap: () {
          imagepick = null;
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
                                      imagepick = null;
                                      imagepick = await ImagePicker().pickImage(
                                          source: ImageSource.camera);
                                      if (imagepick == null) {
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
