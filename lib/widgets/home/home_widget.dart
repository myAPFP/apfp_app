import 'dart:io';
import 'package:apfp/firebase/firestore.dart';
import 'package:apfp/util/goals/custom_goal.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../util/goals/exercise_time_goal.dart';
import '../add_goal/add_goal_widget.dart';
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
  late Map<String, dynamic> _activitySnapshotBackup;
  static late Map<String, dynamic> _healthSnapshotBackup;

  final _otherSC = ScrollController();
  final _calViewSC = ScrollController();
  final _stepsViewSC = ScrollController();
  final _milesViewSC = ScrollController();
  final _exerciseViewSC = ScrollController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int _dayOfMonth = 0;
  double _userProgressCalGoal = 0;
  double _userCalEndGoal = 0;
  double _userProgressStepGoal = 0;
  double _userStepEndGoal = 0;
  double _userProgressMileGoal = 0;
  double _userMileEndGoal = 0;
  double _userProgressExerciseTime = 0;
  double _userExerciseTimeEndGoal = 0;
  double _userProgressCyclingGoal = 0;
  double _userCyclingEndGoal = 0;
  double _userProgressRowingGoal = 0;
  double _userRowingEndGoal = 0;
  double _userProgressStepMillGoal = 0;
  double _userStepMillEndGoal = 0;

  bool _isCalGoalSet = false;
  bool _isStepGoalSet = false;
  bool _isMileGoalSet = false;
  bool _isCyclingGoalSet = false;
  bool _isRowingGoalSet = false;
  bool _isStepMillGoalSet = false;
  bool _isExerciseTimeGoalSet = false;
  bool _isDailyDisplayed = false;
  bool _isHealthTrackerPermissionGranted = false;

  String _platformHealthName = Platform.isAndroid ? 'Google Fit' : 'Health App';

  @override
  void initState() {
    super.initState();
    widget.activityStream.first
        .then((firstElement) => _activitySnapshotBackup = firstElement.data()!);
    widget.healthStream.first
        .then((firstElement) => _healthSnapshotBackup = firstElement.data()!);
    _listenToActivityStream();
    _listenToHealthStream();
  }

  @override
  void dispose() {
    super.dispose();
    _otherSC.dispose();
    _calViewSC.dispose();
    _stepsViewSC.dispose();
    _milesViewSC.dispose();
    _exerciseViewSC.dispose();
  }

  void _listenToActivityStream() {
    widget.activityStream.forEach((element) {
      _activitySnapshotBackup = new Map();
      if (element.data() != null) {
        _activitySnapshotBackup = element.data()!;
      }
      _userProgressExerciseTime = 0;
      _userProgressCyclingGoal = 0;
      _userProgressRowingGoal = 0;
      _userProgressStepMillGoal = 0;
      setState(() {
        _userProgressExerciseTime =
            ExerciseGoal.totalTimeInMinutes(_activitySnapshotBackup);
        _userProgressCyclingGoal =
            CustomGoal.calcGoalSums(_activitySnapshotBackup)[0];
        _userProgressRowingGoal =
            CustomGoal.calcGoalSums(_activitySnapshotBackup)[1];
        _userProgressStepMillGoal =
            CustomGoal.calcGoalSums(_activitySnapshotBackup)[2];
        FireStore.updateHealthData({
          "exerciseTimeGoalProgress": _userProgressExerciseTime,
          "cyclingGoalProgress": _userProgressCyclingGoal,
          "rowingGoalProgress": _userProgressRowingGoal,
          "stepMillGoalProgress": _userProgressStepMillGoal
        });
      });
    });
  }

  void _listenToHealthStream() {
    widget.healthStream.forEach((element) {
      _healthSnapshotBackup = new Map();
      if (element.data() != null) {
        _healthSnapshotBackup = element.data()!;
        setState(() {
          _isCalGoalSet = _healthSnapshotBackup['isCalGoalSet'];
          _isStepGoalSet = _healthSnapshotBackup['isStepGoalSet'];
          _isMileGoalSet = _healthSnapshotBackup['isMileGoalSet'];
          _isCyclingGoalSet = _healthSnapshotBackup['isCyclingGoalSet'];
          _isRowingGoalSet = _healthSnapshotBackup['isRowingGoalSet'];
          _isStepMillGoalSet = _healthSnapshotBackup['isStepMillGoalSet'];
          _isHealthTrackerPermissionGranted =
              _healthSnapshotBackup['isHealthTrackerPermissionGranted'];
          _isExerciseTimeGoalSet =
              _healthSnapshotBackup['isExerciseTimeGoalSet'];
          _userProgressCalGoal =
              _healthSnapshotBackup['calGoalProgress'].toDouble();
          _userCalEndGoal = _healthSnapshotBackup['calEndGoal'].toDouble();
          _userProgressStepGoal =
              _healthSnapshotBackup['stepGoalProgress'].toDouble();
          _userStepEndGoal = _healthSnapshotBackup['stepEndGoal'].toDouble();
          _userProgressMileGoal =
              _healthSnapshotBackup['mileGoalProgress'].toDouble();
          _userMileEndGoal = _healthSnapshotBackup['mileEndGoal'].toDouble();
          _userExerciseTimeEndGoal =
              _healthSnapshotBackup['exerciseTimeEndGoal'].toDouble();
          _userProgressCyclingGoal =
              _healthSnapshotBackup['cyclingGoalProgress'].toDouble();
          _userCyclingEndGoal =
              _healthSnapshotBackup['cyclingEndGoal'].toDouble();
          _userProgressRowingGoal =
              _healthSnapshotBackup['rowingGoalProgress'].toDouble();
          _userRowingEndGoal =
              _healthSnapshotBackup['rowingEndGoal'].toDouble();
          _userProgressStepMillGoal =
              _healthSnapshotBackup['stepMillGoalProgress'].toDouble();
          _userStepMillEndGoal =
              _healthSnapshotBackup['stepMillEndGoal'].toDouble();
          _dayOfMonth = _healthSnapshotBackup['dayOfMonth'];
        });
        if (_dayOfMonth != DateTime.now().day) {
          FireStore.resetHealthDoc(
              _isHealthTrackerPermissionGranted, _isDailyDisplayed);
        }
      }
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
          AutoSizeText('Daily Goals', style: FlutterFlowTheme.title1),
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
          Text('Time'),
          Text('Calories'),
          Text('Steps'),
          Text('Miles'),
          Text('Other'),
        ], views: [
          // Exercise Time Goal View
          HPGraphic.createView(
              isGoalSet: _isExerciseTimeGoalSet,
              isHealthGranted: true,
              scrollController: _exerciseViewSC,
              onLongPress: () {
                AddGoalWidget.launch(context);
              },
              context: context,
              innerCircleText:
                  "${_userProgressExerciseTime.toStringAsFixed(2)} / ${_userExerciseTimeEndGoal.toStringAsFixed(2)}\nTotal Minutes",
              goalProgressStr: "You've completed " +
                  "${((_userProgressExerciseTime / _userExerciseTimeEndGoal) * 100) > 100 ? 100 : ((_userProgressExerciseTime / _userExerciseTimeEndGoal) * 100).toStringAsFixed(2)}" +
                  "% of your goal.\nLong Press here to edit.",
              percent:
                  (_userProgressExerciseTime / _userExerciseTimeEndGoal) > 1.0
                      ? 1.0
                      : _userProgressExerciseTime / _userExerciseTimeEndGoal),
          // Calories Goal View
          HPGraphic.createView(
              isGoalSet: _isCalGoalSet,
              isHealthGranted: _isHealthTrackerPermissionGranted,
              scrollController: _calViewSC,
              onLongPress: () {
                if (_isHealthTrackerPermissionGranted) {
                  AddGoalWidget.launch(context);
                }
              },
              context: context,
              innerCircleText:
                  "${_userProgressCalGoal.toStringAsFixed(2)} / ${_userCalEndGoal.toStringAsFixed(2)}\nCals Burned",
              goalProgressStr:
                  "You've completed ${((_userProgressCalGoal / _userCalEndGoal) * 100).toStringAsFixed(2)} % of your goal.",
              percent: (_userProgressCalGoal / _userCalEndGoal) > 1.0
                  ? 1.0
                  : _userProgressCalGoal / _userCalEndGoal),
          // Step Goal View
          HPGraphic.createView(
              isGoalSet: _isStepGoalSet,
              isHealthGranted: _isHealthTrackerPermissionGranted,
              scrollController: _stepsViewSC,
              onLongPress: () {
                if (_isHealthTrackerPermissionGranted) {
                  AddGoalWidget.launch(context);
                }
              },
              context: context,
              innerCircleText:
                  "${_userProgressStepGoal.toStringAsFixed(2)} / ${_userStepEndGoal.toStringAsFixed(2)}\nSteps Taken",
              goalProgressStr:
                  "You've completed ${((_userProgressStepGoal / _userStepEndGoal) * 100).toStringAsFixed(2)} % of your goal.",
              percent: (_userProgressStepGoal / _userStepEndGoal) > 1.0
                  ? 1.0
                  : _userProgressStepGoal / _userStepEndGoal),
          // Mile Goal View
          HPGraphic.createView(
              isGoalSet: _isMileGoalSet,
              isHealthGranted: _isHealthTrackerPermissionGranted,
              scrollController: _milesViewSC,
              onLongPress: () {
                if (_isHealthTrackerPermissionGranted) {
                  AddGoalWidget.launch(context);
                }
              },
              context: context,
              innerCircleText:
                  "${_userProgressMileGoal.toStringAsFixed(2)} of ${_userMileEndGoal.toStringAsFixed(2)}\nMi Walked / Ran",
              goalProgressStr:
                  "You've completed ${((_userProgressMileGoal / _userMileEndGoal) * 100).toStringAsFixed(2)} % of your goal.",
              percent: (_userProgressMileGoal / _userMileEndGoal) > 1.0
                  ? 1.0
                  : _userProgressMileGoal / _userMileEndGoal),
          // 'Other' Goal View        
          HPGraphic.createCustomView(
              context: context,
              goal1Title:
                  "Cycling - ${_userProgressCyclingGoal.toStringAsFixed(2)} / ${_userCyclingEndGoal.toStringAsFixed(2)} min",
              goal2Title:
                  "Rowing - ${_userProgressRowingGoal.toStringAsFixed(2)} / ${_userRowingEndGoal.toStringAsFixed(2)} min",
              goal3Title:
                  "Step Mill - ${_userProgressStepMillGoal.toStringAsFixed(2)} / ${_userStepMillEndGoal.toStringAsFixed(2)} min",
              percent1: (_userProgressCyclingGoal / _userCyclingEndGoal) > 1.0
                  ? 1.0
                  : _userProgressCyclingGoal / _userCyclingEndGoal,
              percent2: (_userProgressRowingGoal / _userRowingEndGoal) > 1.0
                  ? 1.0
                  : _userProgressRowingGoal / _userRowingEndGoal,
              percent3: (_userProgressStepMillGoal / _userStepMillEndGoal) > 1.0
                  ? 1.0
                  : _userProgressStepMillGoal / _userStepMillEndGoal,
              onLongPress: () {
                AddGoalWidget.launch(context);
              },
              scrollController: _otherSC,
              isGoal1Set: _isCyclingGoalSet,
              isGoal2Set: _isRowingGoalSet,
              isGoal3Set: _isStepMillGoalSet)
        ]),
      ),
    );
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
