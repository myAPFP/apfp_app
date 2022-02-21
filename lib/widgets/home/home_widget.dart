import 'dart:io';
import 'package:apfp/firebase/firestore.dart';
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

  double _userProgressCalGoal = 0;
  double _userSetCalGoal = 0;
  double _userProgressStepGoal = 0;
  double _userSetStepGoal = 0;
  double _userProgressMileGoal = 0;
  double _userSetMileGoal = 0;
  double _userProgressExerciseTime = 0;
  double _userSetExerciseTimeGoal = 0;

  bool _isCalGoalSet = false;
  bool _isStepGoalSet = false;
  bool _isMileGoalSet = false;
  bool _isExerciseTimeGoalSet = false;
  bool _isHealthTrackerPermissionGranted = false;

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
      _userProgressExerciseTime = 0;
      setState(() {
        _userProgressExerciseTime =
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
        _isCalGoalSet = _healthSnapshotBackup['isCalGoalSet'];
        _isStepGoalSet = _healthSnapshotBackup['isStepGoalSet'];
        _isMileGoalSet = _healthSnapshotBackup['isMileGoalSet'];
        _isHealthTrackerPermissionGranted =
            _healthSnapshotBackup['isHealthTrackerPermissionGranted'];
        _isExerciseTimeGoalSet = _healthSnapshotBackup['isExerciseTimeGoalSet'];
        _userProgressCalGoal =
            _healthSnapshotBackup['userProgressCalGoal'].toDouble();
        _userSetCalGoal = _healthSnapshotBackup['userSetCalGoal'].toDouble();
        _userProgressStepGoal =
            _healthSnapshotBackup['userProgressStepGoal'].toDouble();
        _userSetStepGoal = _healthSnapshotBackup['userSetStepGoal'].toDouble();
        _userProgressMileGoal =
            _healthSnapshotBackup['userProgressMileGoal'].toDouble();
        _userSetMileGoal = _healthSnapshotBackup['userSetMileGoal'].toDouble();
        _userProgressExerciseTime =
            _healthSnapshotBackup['userProgressExerciseTime'].toDouble();
        _userSetExerciseTimeGoal =
            _healthSnapshotBackup['userSetExerciseTimeGoal'].toDouble();
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
              isGoalSet: _isExerciseTimeGoalSet,
              isHealthGranted: true,
              scrollController: _exerciseViewSC,
              onDoubleTap: () {
                _isExerciseTimeGoalSet = !_isExerciseTimeGoalSet;
                FireStore.updateHealthData(
                    FireStore.exerciseGoalBoolToMap(_isExerciseTimeGoalSet));
              },
              context: context,
              innerCircleText:
                  "${_userProgressExerciseTime.toStringAsFixed(2)} / ${_userSetExerciseTimeGoal.toStringAsFixed(2)}\nTotal Minutes",
              goalProgressStr: "You've completed " +
                  "${((_userProgressExerciseTime / _userSetExerciseTimeGoal) * 100) > 100 ? 100 : ((_userProgressExerciseTime / _userSetExerciseTimeGoal) * 100).toStringAsFixed(2)}" +
                  "% of your goal.",
              percent:
                  (_userProgressExerciseTime / _userSetExerciseTimeGoal) > 1.0
                      ? 1.0
                      : _userProgressExerciseTime / _userSetExerciseTimeGoal),
          HPGraphic.createView(
              isGoalSet: _isCalGoalSet,
              isHealthGranted: _isHealthTrackerPermissionGranted,
              scrollController: _calViewSC,
              onDoubleTap: () {
                _isCalGoalSet = !_isCalGoalSet;
                FireStore.updateHealthData(
                    FireStore.calGoalBoolToMap(_isCalGoalSet));
              },
              context: context,
              innerCircleText:
                  "${_userProgressCalGoal.toStringAsFixed(2)} / ${_userSetCalGoal.toStringAsFixed(2)}\nCals Burned",
              goalProgressStr:
                  "You've completed ${((_userProgressCalGoal / _userSetCalGoal) * 100).toStringAsFixed(2)} % of your goal.",
              percent: (_userProgressCalGoal / _userSetCalGoal) > 1.0
                  ? 1.0
                  : _userProgressCalGoal / _userSetCalGoal),
          HPGraphic.createView(
              isGoalSet: _isStepGoalSet,
              isHealthGranted: _isHealthTrackerPermissionGranted,
              scrollController: _stepsViewSC,
              onDoubleTap: () {
                _isStepGoalSet = !_isStepGoalSet;
                FireStore.updateHealthData(
                    FireStore.stepGoalBoolToMap(_isStepGoalSet));
              },
              context: context,
              innerCircleText:
                  "${_userProgressStepGoal.toStringAsFixed(2)} / ${_userSetStepGoal.toStringAsFixed(2)}\nSteps Taken",
              goalProgressStr:
                  "You've completed ${((_userProgressStepGoal / _userSetStepGoal) * 100).toStringAsFixed(2)} % of your goal.",
              percent: (_userProgressStepGoal / _userSetStepGoal) > 1.0
                  ? 1.0
                  : _userProgressStepGoal / _userSetStepGoal),
          HPGraphic.createView(
              isGoalSet: _isMileGoalSet,
              isHealthGranted: _isHealthTrackerPermissionGranted,
              scrollController: _milesViewSC,
              onDoubleTap: () {
                _isMileGoalSet = !_isMileGoalSet;
                FireStore.updateHealthData(
                    FireStore.mileGoalBoolToMap(_isMileGoalSet));
              },
              context: context,
              innerCircleText:
                  "${_userProgressMileGoal.toStringAsFixed(2)} of ${_userSetMileGoal.toStringAsFixed(2)}\nMi Walked / Ran",
              goalProgressStr:
                  "You've completed ${((_userProgressMileGoal / _userSetMileGoal) * 100).toStringAsFixed(2)} % of your goal.",
              percent: (_userProgressMileGoal / _userSetMileGoal) > 1.0
                  ? 1.0
                  : _userProgressMileGoal / _userSetMileGoal)
        ]),
      ),
    );
  }

  void _getPlatformHealthName() {
    if (Platform.isIOS) {
      _platformHealthName = "Apple Health / Google Fit";
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
          _isHealthTrackerPermissionGranted =
              !_isHealthTrackerPermissionGranted;
          if (!_isHealthTrackerPermissionGranted) {
            FireStore.updateHealthData(FireStore.calGoalBoolToMap(false));
            FireStore.updateHealthData(FireStore.stepGoalBoolToMap(false));
            FireStore.updateHealthData(FireStore.mileGoalBoolToMap(false));
            FireStore.updateHealthData(FireStore.exerciseGoalBoolToMap(false));
          }
          FireStore.updateHealthData(FireStore.healthPermissionToMap(
              _isHealthTrackerPermissionGranted));
          // ! -------------------
        },
        text: 'Sync $_platformHealthName',
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
