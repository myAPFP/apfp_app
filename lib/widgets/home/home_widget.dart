import 'dart:io';

import 'package:apfp/util/toasted/toasted.dart';

import '../../flutter_flow/flutter_flow_widgets.dart';
import '../home_page_graphic/hp_graphic.dart';
import 'package:apfp/widgets/confimation_dialog/confirmation_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  late final Stream<QuerySnapshot<Map<String, dynamic>>> announcementsStream;
  final Stream<DocumentSnapshot<Map<String, dynamic>>> activityStream;
  HomeWidget(
      {Key? key,
      required this.announcementsStream,
      required this.activityStream})
      : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late final String _platformHealthName;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late FirebaseMessaging messaging;

  final _calViewSC = ScrollController();
  final _stepsViewSC = ScrollController();
  final _milesViewSC = ScrollController();
  final _exerciseViewSC = ScrollController();

  double _totalExerciseTime = 0;
  double _exerciseTimeGoal = 1;
  late Map<String, dynamic> currentSnapshotBackup;

  @override
  void initState() {
    super.initState();
    _getPlatformHealthName();
    _collectActivityDuration();
  }

  @override
  void dispose() {
    super.dispose();
    _calViewSC.dispose();
    _stepsViewSC.dispose();
    _milesViewSC.dispose();
    _exerciseViewSC.dispose();
  }

  void _collectActivityDuration() {
    widget.activityStream.forEach((element) {
      Map sortedMap = new Map();
      if (element.data() == null) {
        currentSnapshotBackup = new Map();
      } else {
        currentSnapshotBackup = element.data()!;
      }
      sortedMap = Map.fromEntries(currentSnapshotBackup.entries.toList()
        ..sort((e1, e2) => e2.key.compareTo(e1.key)));
      sortedMap.forEach((key, value) {
        _totalExerciseTime = 0;
        findExcerciseTimeInHours(sortedMap);
      });
    });
  }

  void findExcerciseTimeInHours(Map<dynamic, dynamic> map) {
    Duration sum = Duration.zero;

    map.forEach((key, value) {
      sum += convertToDuration(value[2]);
    });

    String HHmmss = sum.toString().split('.').first.padLeft(8, "0");
    List<String> HHmmssSplit = HHmmss.split(':');

    setState(() {
      _totalExerciseTime = double.parse(HHmmssSplit[0]) +
          double.parse(HHmmssSplit[1]) / 60 +
          double.parse(HHmmssSplit[2]) / 3600;
    });
  }

  Duration convertToDuration(String activityDurationStr) {
    Duration duration = Duration.zero;
    String value = activityDurationStr.split(' ')[0];
    String unitOfTime = activityDurationStr.split(' ')[1];
    switch (unitOfTime) {
      case 'Min':
        duration = Duration(minutes: int.parse(value));
        break;
      case 'Sec':
        duration = Duration(seconds: int.parse(value));
        break;
      case 'Hr':
        duration = Duration(hours: int.parse(value));
        break;
    }
    return duration;
  }

  Row _recentAnnouncementsLabel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.92,
          height: MediaQuery.of(context).size.height * 0.06,
          child: AutoSizeText(
            'Recent Announcements',
            style: FlutterFlowTheme.title1,
            maxLines: 1,
            overflow: TextOverflow.fade,
          ),
        )
      ],
    );
  }

  Container _announcementText(String text) {
    return Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        child: AutoSizeText(
          text,
          overflow: TextOverflow.ellipsis,
          style: FlutterFlowTheme.bodyText1,
        ));
  }

  Column _announcementTextColumn(String text) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _announcementText(text),
      ],
    );
  }

  Column _errorIcon() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsetsDirectional.all(3),
              child: Icon(
                Icons.error_outline,
                color: FlutterFlowTheme.secondaryColor,
                size: 22,
              ))
        ]);
  }

  Row _announcementRow(String text) {
    return Row(
      children: [_errorIcon(), _announcementTextColumn(text)],
    );
  }

  IgnorePointer _announcementGrid(
      String alertOneText, String alertTwoText, String alertThreeText) {
    return IgnorePointer(
        child: GridView(
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        childAspectRatio: 10,
      ),
      shrinkWrap: true,
      children: [
        _announcementRow(alertOneText),
        _announcementRow(alertTwoText),
        _announcementRow(alertThreeText)
      ],
    ));
  }

  Container _announcements(
      String alertOneText, String alertTwoText, String alertThreeText) {
    return Container(
      key: Key('Home.announcements'),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color(0xFFBDBDBD),
          width: 2,
        ),
      ),
      child: _announcementGrid(alertOneText, alertTwoText, alertThreeText),
    );
  }

  Padding _activityLabel() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          MediaQuery.of(context).size.width * 0.04,
          MediaQuery.of(context).size.height * 0.03,
          0,
          0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          AutoSizeText('Today\'s Activity', style: FlutterFlowTheme.title1),
        ],
      ),
    );
  }

  Padding _activityGUI() {
    return Padding(
      key: Key('Home.activityGUI'),
      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Color(0xFFBDBDBD),
            width: 2,
          ),
        ),
        child: HPGraphic.tabbedContainer(context: context, tabs: [
          Text('Calories'),
          Text('Steps'),
          Text('Miles'),
          Text('Exercise Time')
        ], views: [
          HPGraphic.createView(
              scrollController: _calViewSC,
              onDoubleTap: () => Toasted.showToast("Cals"),
              context: context,
              innerCircleText: "146 of 225\nCals Burned",
              goalProgress: "You've completed 65% of your goal.",
              percent: 0.65),
          HPGraphic.createView(
              scrollController: _stepsViewSC,
              onDoubleTap: () => Toasted.showToast("Steps"),
              context: context,
              innerCircleText: "520 of 2000\nSteps Taken",
              goalProgress: "You've completed 26% of your goal.",
              percent: 0.26),
          HPGraphic.createView(
              scrollController: _milesViewSC,
              onDoubleTap: () => Toasted.showToast("Miles"),
              context: context,
              innerCircleText: "N/A",
              goalProgress:
                  "You do not have an active Miles goal.\nDouble tap here to set one.",
              percent: 0.0),
          HPGraphic.createView(
              scrollController: _exerciseViewSC,
              onDoubleTap: () => Toasted.showToast("Total Hours"),
              context: context,
              innerCircleText:
                  "${_totalExerciseTime.toStringAsFixed(2)} of $_exerciseTimeGoal\nTotal Hours\nof Exercise",
              goalProgress: "You've completed " +
                  "${((_totalExerciseTime / _exerciseTimeGoal) * 100) > 100 ? 100 : ((_totalExerciseTime / _exerciseTimeGoal) * 100).toStringAsFixed(2)}" +
                  "% of your goal.",
              percent: (_totalExerciseTime / _exerciseTimeGoal) > 1.0
                  ? 1.0
                  : _totalExerciseTime / _exerciseTimeGoal),
        ]),
      ),
    );
  }

  void _getPlatformHealthName() {
    if (Platform.isIOS) {
      _platformHealthName = "Apple Health";
    } else if (Platform.isAndroid) {
      _platformHealthName = "Google Fit";
    }
  }

  Padding _syncHealthDataButton() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 40),
      child: FFButtonWidget(
        onPressed: () {},
        text: 'Sync ${_platformHealthName} Data',
        options: FFButtonOptions(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50,
          color: FlutterFlowTheme.secondaryColor,
          textStyle: FlutterFlowTheme.title2,
          elevation: 2,
          borderSide: BorderSide(
            color: FlutterFlowTheme.secondaryColor,
          ),
          borderRadius: 8,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ConfirmationDialog.showExitAppDialog(context);
        return false;
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _recentAnnouncementsLabel(),
              StreamBuilder(
                  stream: widget.announcementsStream,
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.hasData) {
                      return _announcements(
                          snapshot.data?.docs[0]['title'],
                          snapshot.data?.docs[1]['title'],
                          snapshot.data?.docs[2]['title']);
                    } else {
                      return Text("No announcements available.");
                    }
                  }),
              _activityLabel(),
              _activityGUI(),
              SizedBox(
                height: 5,
              ),
              _syncHealthDataButton()
            ],
          ),
        )),
      ),
    );
  }
}
