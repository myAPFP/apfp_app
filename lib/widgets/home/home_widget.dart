import 'dart:io';
import 'package:apfp/firebase/firestore.dart';
import 'package:apfp/util/toasted/toasted.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../util/goals/exercise_time_goal.dart';
import '../home_page_graphic/hp_graphic.dart';
import 'package:apfp/widgets/confimation_dialog/confirmation_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  late final Stream<QuerySnapshot<Map<String, dynamic>>> announcementsStream;
  final Stream<DocumentSnapshot<Map<String, dynamic>>> activityStream;
  final Stream<DocumentSnapshot<Map<String, dynamic>>> healthStream;
  HomeWidget(
      {Key? key,
      required this.healthStream,
      required this.announcementsStream,
      required this.activityStream})
      : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late String _platformHealthName;
  late Map<String, dynamic> _currentSnapshotBackup;
  late Map<String, dynamic> _healthSnapshotBackup;
  final _calViewSC = ScrollController();
  final _stepsViewSC = ScrollController();
  final _milesViewSC = ScrollController();
  final _exerciseViewSC = ScrollController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double _totalExerciseTimeInMinutes = 0;
  double _exerciseTimeGoalInMinutes = 150;

  late bool isCalGoalSet = false;
  late bool isStepGoalSet = false;
  late bool isMileGoalSet = false;
  late bool isHealthTrackerPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    _getPlatformHealthName();
    widget.activityStream.first
        .then((firstElement) => _currentSnapshotBackup = firstElement.data()!);
    widget.healthStream.first
        .then((firstElement) => _healthSnapshotBackup = firstElement.data()!);
    _listenToActivityStream();
    _listenToHealthTrackerStream();
  }

  @override
  void dispose() {
    super.dispose();
    _calViewSC.dispose();
    _stepsViewSC.dispose();
    _milesViewSC.dispose();
    _exerciseViewSC.dispose();
  }

  void _listenToActivityStream() {
    widget.activityStream.forEach((element) {
      _currentSnapshotBackup = new Map();
      if (element.data() != null) {
        _currentSnapshotBackup = element.data()!;
      }
      _totalExerciseTimeInMinutes = 0;
      setState(() {
        _totalExerciseTimeInMinutes =
            ExerciseGoal.totalTimeInMinutes(_currentSnapshotBackup);
      });
    });
  }

  void _listenToHealthTrackerStream() {
    widget.healthStream.forEach((element) {
      _healthSnapshotBackup = new Map();
      if (element.data() != null) {
        _healthSnapshotBackup = element.data()!;
      }
      setState(() {
        isHealthTrackerPermissionGranted =
            _healthSnapshotBackup['isHealthTrackerPermissionGranted'];
        isCalGoalSet = _healthSnapshotBackup['isCalGoalSet'];
        isStepGoalSet = _healthSnapshotBackup['isStepGoalSet'];
        isMileGoalSet = _healthSnapshotBackup['isMileGoalSet'];
      });
    });
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
          Text('Exercise Time'),
          Text('Calories'),
          Text('Steps'),
          Text('Miles'),
        ], views: [

          HPGraphic.createView(
              isGoalSet: false,
              isHealthGranted: true,
              scrollController: _exerciseViewSC,
              onDoubleTap: () => Toasted.showToast("Total Hours"),
              context: context,
              innerCircleText:
                  "${_totalExerciseTimeInMinutes.toStringAsFixed(2)} / ${_exerciseTimeGoalInMinutes.toStringAsFixed(2)}\nTotal Minutes",
              goalProgress: "You've completed " +
                  "${((_totalExerciseTimeInMinutes / _exerciseTimeGoalInMinutes) * 100) > 100 ? 100 : ((_totalExerciseTimeInMinutes / _exerciseTimeGoalInMinutes) * 100).toStringAsFixed(2)}" +
                  "% of your goal.",
              percent: (_totalExerciseTimeInMinutes /
                          _exerciseTimeGoalInMinutes) >
                      1.0
                  ? 1.0
                  : _totalExerciseTimeInMinutes / _exerciseTimeGoalInMinutes),

          HPGraphic.createView(
              isGoalSet: isCalGoalSet,
              isHealthGranted: isHealthTrackerPermissionGranted,
              scrollController: _calViewSC,
              onDoubleTap: () {
                isCalGoalSet = !isCalGoalSet;
                FireStore.updateHealthData(
                FireStore.calGoalToMap(isCalGoalSet));
              },
              context: context,
              innerCircleText: "146 / 225\nCals Burned",
              goalProgress: "You've completed 65% of your goal.",
              percent: 0.65),

          HPGraphic.createView(
              isGoalSet: isStepGoalSet,
              isHealthGranted: isHealthTrackerPermissionGranted,
              scrollController: _stepsViewSC,
              onDoubleTap: () {
                isStepGoalSet = !isStepGoalSet;
                FireStore.updateHealthData(
                FireStore.stepGoalToMap(isStepGoalSet));
              },
              context: context,
              innerCircleText: "520 / 2000\nSteps Taken",
              goalProgress: "You've completed 26% of your goal.",
              percent: 0.26),

          HPGraphic.createView(
              isGoalSet: isMileGoalSet,
              isHealthGranted: isHealthTrackerPermissionGranted,
              scrollController: _milesViewSC,
              onDoubleTap: () {
                isMileGoalSet = !isMileGoalSet;
                FireStore.updateHealthData(
                FireStore.mileGoalToMap(isMileGoalSet));
              },
              context: context,
              innerCircleText: "3 of 5 Miles\nWalked / Ran",
              goalProgress: "You've completed 60% of your goal.",
              percent: 0.60)
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
        onPressed: () {
          // ! -- Demo Purposes --
          isHealthTrackerPermissionGranted = !isHealthTrackerPermissionGranted;
          if (!isHealthTrackerPermissionGranted) {
            FireStore.updateHealthData(FireStore.calGoalToMap(false));
            FireStore.updateHealthData(FireStore.stepGoalToMap(false));
            FireStore.updateHealthData(FireStore.mileGoalToMap(false));
          }
          FireStore.updateHealthData(FireStore.healthPermissionToMap(
              isHealthTrackerPermissionGranted));
          // ! -------------------
        },
        text: 'Sync $_platformHealthName Data',
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
        key: _scaffoldKey,
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
              _syncHealthDataButton(),
            ],
          ),
        )),
      ),
    );
  }
}
