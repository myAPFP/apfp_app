// Copyright 2022 The myAPFP Authors. All rights reserved.

import 'dart:io';

import '/util/health/healthUtil.dart';

import '/firebase/firestore.dart';

import '/flutter_flow/flutter_flow_theme.dart';

import '../activity_card/activity_card.dart';

import '../add_activity/add_activity_widget.dart';

import '../confirmation_dialog/confirmation_dialog.dart';

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
  List<ActivityCard> cards = [];

  /// Serves as key for the [Scaffold] found in [build].
  final scaffoldKey = GlobalKey<ScaffoldState>();

  /// Stores a user's activity document snapshots.
  late Map<String, dynamic> currentSnapshotBackup;

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
        _removeActivityFromCloud(ActivityCard.importedActivityID);
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
    if (await Permission.activityRecognition.request().isGranted) {
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
          if (moveMinutes != 0.0) {
            _removeActivityFromCloud(ActivityCard.importedActivityID);
            _addImportedCard("${moveMinutes.round()} Minutes");
          }
        } catch (error) {
          print("Activity data could not be retrieved: $error ");
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
              : DateTime.now().toIso8601String())));
    });
  }

  /// Adds [activityCard]'s info to the user's activity document in Firestore.
  void _addActivityToCloud(ActivityCard activityCard) {
    currentSnapshotBackup.putIfAbsent(activityCard.timestamp.toString(),
        () => [activityCard.name, activityCard.type, activityCard.duration]);
    FireStore.updateWorkoutData(currentSnapshotBackup);
  }

  /// Removes an activity from Firestore.
  ///
  /// The [timestamp] represents the activity's timestamp, which is the timestamp in
  /// which it was created.
  void _removeActivityFromCloud(String timestamp) {
    currentSnapshotBackup.removeWhere(
        (key, durationInMinutes) => (key == timestamp.split(' ')[0]));
    FireStore.updateWorkoutData(currentSnapshotBackup);
  }

  /// Adds an imported [ActivityCard]'s info to the user's activity document
  /// in Firestore.
  void _addImportedCard(String duration) {
    var activityCard = ActivityCard(
      icon: Icons.emoji_events_rounded,
      duration: duration,
      name: "Imported-Workout",
      type: "Exercise-Minutes",
      timestamp: ActivityCard.importedActivityID,
    );
    _addActivityToCloud(activityCard);
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

  void addCard(ActivityCard card) {
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
  void _showShareWithImageDialog(ActivityCard activityCard) async {
    final cardInfo = activityCard.toString().split(' ');
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
                  'Duration: ${cardInfo[3]} ${cardInfo[4]}\n' +
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
        key: Key("Activity.FAB"),
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
                                          e.toString().split(' ');
                                      print(cardInfo);
                                      share(
                                          subject: "New Activity Completed!",
                                          body: 'I completed a new activity!\n\n' +
                                              'Activity: ${cardInfo[1].replaceAll(RegExp('-'), ' ')}\n' +
                                              'Exercise Type: ${cardInfo[2]}\n' +
                                              'Duration: ${cardInfo[3] + ' ' + cardInfo[4]}\n' +
                                              '\nSent from the myAPFP App.');
                                    }),
                                FocusedMenuItem(
                                    title: Text("Delete",
                                        style:
                                            TextStyle(color: Colors.redAccent)),
                                    trailingIcon: Icon(Icons.delete,
                                        color: Colors.redAccent),
                                    onPressed: () {
                                      final cardInfo = e.toString().split(' ');
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
                                              _removeActivityFromCloud(
                                                  e.timestamp.toString());
                                              cards.remove(e);
                                            });
                                            Navigator.pop(context);
                                          });
                                    })
                              ],
                              onPressed: () {},
                              child: e.paddedActivityCard(context)))
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
