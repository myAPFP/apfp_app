import 'dart:io';
import 'package:apfp/firebase/firestore.dart';
import 'package:apfp/util/goals/custom_goal.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../util/goals/exercise_time_goal.dart';
import '../../util/goals/goal.dart';
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

  String _goalTypeLabel = "Daily";
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
      Goal.userProgressExerciseTime = 0;
      Goal.userProgressExerciseTimeWeekly = 0;
      Goal.userProgressCyclingGoal = 0;
      Goal.userProgressRowingGoal = 0;
      Goal.userProgressStepMillGoal = 0;
      setState(() {
        Goal.userProgressExerciseTime =
            ExerciseGoal.totalTimeInMinutes(_activitySnapshotBackup);
        // ! Needs to read total exercise time for multiple days
        Goal.userProgressExerciseTimeWeekly =
            ExerciseGoal.totalTimeInMinutes(_activitySnapshotBackup);
        Goal.userProgressCyclingGoal =
            CustomGoal.calcGoalSums(_activitySnapshotBackup)[0];
        Goal.userProgressCyclingGoalWeekly =
            CustomGoal.calcGoalSums(_activitySnapshotBackup)[0];
        Goal.userProgressRowingGoal =
            CustomGoal.calcGoalSums(_activitySnapshotBackup)[1];
        Goal.userProgressRowingGoalWeekly =
            CustomGoal.calcGoalSums(_activitySnapshotBackup)[1];
        Goal.userProgressStepMillGoal =
            CustomGoal.calcGoalSums(_activitySnapshotBackup)[2];
        Goal.userProgressStepMillGoalWeekly =
            CustomGoal.calcGoalSums(_activitySnapshotBackup)[2];
        FireStore.updateHealthData({
          "exerciseTimeGoalProgress": Goal.userProgressExerciseTime,
          "exerciseTimeGoalProgressWeekly": Goal.userProgressExerciseTimeWeekly,
          "cyclingGoalProgress": Goal.userProgressCyclingGoal,
          "cyclingGoalProgressWeekly": Goal.userProgressCyclingGoalWeekly,
          "rowingGoalProgress": Goal.userProgressRowingGoal,
          "rowingGoalProgressWeekly": Goal.userProgressRowingGoalWeekly,
          "stepMillGoalProgress": Goal.userProgressStepMillGoal,
          "stepMillGoalProgressWeekly": Goal.userProgressStepMillGoalWeekly
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
          Goal.isCalGoalSet = _healthSnapshotBackup['isCalGoalSet'];
          Goal.isStepGoalSet = _healthSnapshotBackup['isStepGoalSet'];
          Goal.isMileGoalSet = _healthSnapshotBackup['isMileGoalSet'];

          Goal.isExerciseTimeGoalSet =
              _healthSnapshotBackup['isExerciseTimeGoalSet'];
          Goal.isExerciseTimeWeeklyGoalSet =
              _healthSnapshotBackup['isExerciseTimeGoalSet_w'];

          Goal.isCyclingGoalSet = _healthSnapshotBackup['isCyclingGoalSet'];
          Goal.isCyclingWeeklyGoalSet =
              _healthSnapshotBackup['isCyclingGoalSet_w'];

          Goal.isRowingGoalSet = _healthSnapshotBackup['isRowingGoalSet'];
          Goal.isRowingWeeklyGoalSet =
              _healthSnapshotBackup['isRowingGoalSet_w'];

          Goal.isStepMillGoalSet = _healthSnapshotBackup['isStepMillGoalSet'];
          Goal.isStepMillWeeklyGoalSet =
              _healthSnapshotBackup['isStepMillGoalSet_w'];

          Goal.isHealthTrackerPermissionGranted =
              _healthSnapshotBackup['isHealthTrackerPermissionGranted'];

          Goal.userProgressCalGoal =
              _healthSnapshotBackup['calGoalProgress'].toDouble();
          Goal.userCalEndGoal = _healthSnapshotBackup['calEndGoal'].toDouble();

          Goal.userProgressStepGoal =
              _healthSnapshotBackup['stepGoalProgress'].toDouble();
          Goal.userStepEndGoal =
              _healthSnapshotBackup['stepEndGoal'].toDouble();

          Goal.userProgressMileGoal =
              _healthSnapshotBackup['mileGoalProgress'].toDouble();
          Goal.userMileEndGoal =
              _healthSnapshotBackup['mileEndGoal'].toDouble();

          Goal.userExerciseTimeEndGoal =
              _healthSnapshotBackup['exerciseTimeEndGoal'].toDouble();
          Goal.userExerciseTimeWeeklyEndGoal =
              _healthSnapshotBackup['exerciseTimeEndGoal_w'].toDouble();

          Goal.userCyclingEndGoal =
              _healthSnapshotBackup['cyclingEndGoal'].toDouble();
          Goal.userCyclingWeeklyEndGoal =
              _healthSnapshotBackup['cyclingEndGoal_w'].toDouble();

          Goal.userRowingEndGoal =
              _healthSnapshotBackup['rowingEndGoal'].toDouble();
          Goal.userRowingWeeklyEndGoal =
              _healthSnapshotBackup['rowingEndGoal_w'].toDouble();

          Goal.userStepMillEndGoal =
              _healthSnapshotBackup['stepMillEndGoal'].toDouble();
          Goal.userStepMillWeeklyEndGoal =
              _healthSnapshotBackup['stepMillEndGoal_w'].toDouble();

          Goal.dayOfMonth = _healthSnapshotBackup['dayOfMonth'];
          Goal.isDailyDisplayed = _healthSnapshotBackup['isDailyDisplayed'];
          _goalTypeLabel = Goal.isDailyDisplayed ? "Daily" : "Weekly";
        });
        Goal.uploadCompletedGoals();
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
          AutoSizeText('$_goalTypeLabel Goals', style: FlutterFlowTheme.title1),
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
              isGoalSet: (Goal.isExerciseTimeGoalSet ||
                  Goal.isExerciseTimeWeeklyGoalSet),
              isHealthGranted: true,
              scrollController: _exerciseViewSC,
              onDoubleTap: () {
                Goal.isDailyDisplayed = !Goal.isDailyDisplayed;
                FireStore.updateHealthData(
                    {"isDailyDisplayed": Goal.isDailyDisplayed});
              },
              onLongPress: () {
                AddGoalWidget.launch(context);
              },
              context: context,
              innerCircleText: Goal.isDailyDisplayed
                  ? "${Goal.isExerciseTimeGoalSet ? Goal.userProgressExerciseTime.toStringAsFixed(2) : 0.toStringAsFixed(2)} / ${Goal.userExerciseTimeEndGoal.toStringAsFixed(2)}\nTotal Minutes"
                  : "${Goal.isExerciseTimeWeeklyGoalSet ? Goal.userProgressExerciseTimeWeekly.toStringAsFixed(2) : 0.toStringAsFixed(2)} / ${Goal.userExerciseTimeWeeklyEndGoal.toStringAsFixed(2)}\nTotal Minutes",
              goalProgressStr: Goal.isDailyDisplayed
                  ? Goal.isExerciseTimeGoalSet
                      ? "Your Daily goal is " +
                          "${((Goal.userProgressExerciseTime / Goal.userExerciseTimeEndGoal) * 100) > 100 ? 100 : ((Goal.userProgressExerciseTime / Goal.userExerciseTimeEndGoal) * 100).toStringAsFixed(2)}" +
                          "% complete."
                      : "Daily Goal not active."
                  : Goal.isExerciseTimeWeeklyGoalSet
                      ? "Your Weekly goal is " +
                          "${((Goal.userProgressExerciseTimeWeekly / Goal.userExerciseTimeWeeklyEndGoal) * 100) > 100 ? 100 : ((Goal.userProgressExerciseTimeWeekly / Goal.userExerciseTimeWeeklyEndGoal) * 100).toStringAsFixed(2)}" +
                          "% complete."
                      : "Weekly Goal not active.",
              percent: Goal.isDailyDisplayed
                  ? (Goal.userProgressExerciseTime /
                              Goal.userExerciseTimeEndGoal) >
                          1.0
                      ? 1.0
                      : Goal.userProgressExerciseTime /
                          Goal.userExerciseTimeEndGoal
                  : (Goal.userProgressExerciseTimeWeekly /
                              Goal.userExerciseTimeWeeklyEndGoal) >
                          1.0
                      ? 1.0
                      : Goal.userProgressExerciseTimeWeekly /
                          Goal.userExerciseTimeWeeklyEndGoal),
          // Calories Goal View
          HPGraphic.createView(
              isGoalSet: Goal.isCalGoalSet,
              isHealthGranted: Goal.isHealthTrackerPermissionGranted,
              scrollController: _calViewSC,
              onDoubleTap: () {
                Goal.isDailyDisplayed = !Goal.isDailyDisplayed;
                FireStore.updateHealthData(
                    {"isDailyDisplayed": Goal.isDailyDisplayed});
              },
              onLongPress: () {
                if (Goal.isHealthTrackerPermissionGranted) {
                  AddGoalWidget.launch(context);
                }
              },
              context: context,
              innerCircleText:
                  "${Goal.userProgressCalGoal.toStringAsFixed(2)} / ${Goal.userCalEndGoal.toStringAsFixed(2)}\nCals Burned",
              goalProgressStr:
                  "You've completed ${((Goal.userProgressCalGoal / Goal.userCalEndGoal) * 100).toStringAsFixed(2)} % of your goal.",
              percent: (Goal.userProgressCalGoal / Goal.userCalEndGoal) > 1.0
                  ? 1.0
                  : Goal.userProgressCalGoal / Goal.userCalEndGoal),
          // Step Goal View
          HPGraphic.createView(
              isGoalSet: Goal.isStepGoalSet,
              isHealthGranted: Goal.isHealthTrackerPermissionGranted,
              scrollController: _stepsViewSC,
              onDoubleTap: () {
                Goal.isDailyDisplayed = !Goal.isDailyDisplayed;
                FireStore.updateHealthData(
                    {"isDailyDisplayed": Goal.isDailyDisplayed});
              },
              onLongPress: () {
                if (Goal.isHealthTrackerPermissionGranted) {
                  AddGoalWidget.launch(context);
                }
              },
              context: context,
              innerCircleText:
                  "${Goal.userProgressStepGoal.toStringAsFixed(2)} / ${Goal.userStepEndGoal.toStringAsFixed(2)}\nSteps Taken",
              goalProgressStr:
                  "You've completed ${((Goal.userProgressStepGoal / Goal.userStepEndGoal) * 100).toStringAsFixed(2)} % of your goal.",
              percent: (Goal.userProgressStepGoal / Goal.userStepEndGoal) > 1.0
                  ? 1.0
                  : Goal.userProgressStepGoal / Goal.userStepEndGoal),
          // Mile Goal View
          HPGraphic.createView(
              isGoalSet: Goal.isMileGoalSet,
              isHealthGranted: Goal.isHealthTrackerPermissionGranted,
              scrollController: _milesViewSC,
              onDoubleTap: () {
                Goal.isDailyDisplayed = !Goal.isDailyDisplayed;
                FireStore.updateHealthData(
                    {"isDailyDisplayed": Goal.isDailyDisplayed});
              },
              onLongPress: () {
                if (Goal.isHealthTrackerPermissionGranted) {
                  AddGoalWidget.launch(context);
                }
              },
              context: context,
              innerCircleText:
                  "${Goal.userProgressMileGoal.toStringAsFixed(2)} of ${Goal.userMileEndGoal.toStringAsFixed(2)}\nMi Walked / Ran",
              goalProgressStr:
                  "You've completed ${((Goal.userProgressMileGoal / Goal.userMileEndGoal) * 100).toStringAsFixed(2)} % of your goal.",
              percent: (Goal.userProgressMileGoal / Goal.userMileEndGoal) > 1.0
                  ? 1.0
                  : Goal.userProgressMileGoal / Goal.userMileEndGoal),
          // 'Other' Goal View
          HPGraphic.createCustomView(
              context: context,
              goal1Title: Goal.isDailyDisplayed
                  ? Goal.isCyclingGoalSet
                      ? "Cycling - ${Goal.userProgressCyclingGoal.toStringAsFixed(2)} / ${Goal.userCyclingEndGoal.toStringAsFixed(2)} min"
                      : "Cycling Goal Not Active"
                  : Goal.isCyclingWeeklyGoalSet
                      ? "Cycling - ${Goal.userProgressCyclingGoalWeekly.toStringAsFixed(2)} / ${Goal.userCyclingWeeklyEndGoal.toStringAsFixed(2)} min"
                      : "Cycling Goal Not Active",
              goal2Title: Goal.isDailyDisplayed
                  ? Goal.isRowingGoalSet
                      ? "Rowing - ${Goal.userProgressRowingGoal.toStringAsFixed(2)} / ${Goal.userRowingEndGoal.toStringAsFixed(2)} min"
                      : "Rowing Goal Not Active"
                  : Goal.isRowingWeeklyGoalSet
                      ? "Rowing - ${Goal.userProgressRowingGoalWeekly.toStringAsFixed(2)} / ${Goal.userRowingWeeklyEndGoal.toStringAsFixed(2)} min"
                      : "Rowing Goal Not Active",
              goal3Title: Goal.isDailyDisplayed
                  ? Goal.isStepMillGoalSet
                      ? "Step Mill - ${Goal.userProgressStepMillGoal.toStringAsFixed(2)} / ${Goal.userStepMillEndGoal.toStringAsFixed(2)} min"
                      : "Step Mill Goal Not Active"
                  : Goal.isStepMillWeeklyGoalSet
                      ? "Step Mill - ${Goal.userProgressStepMillGoalWeekly.toStringAsFixed(2)} / ${Goal.userStepMillWeeklyEndGoal.toStringAsFixed(2)} min"
                      : "Step Mill Goal Not Active",
              percent1: Goal.isDailyDisplayed
                  ? Goal.isCyclingGoalSet
                      ? (Goal.userProgressCyclingGoal /
                                  Goal.userCyclingEndGoal) >
                              1.0
                          ? 1.0
                          : Goal.userProgressCyclingGoal /
                              Goal.userCyclingEndGoal
                      : 0
                  : Goal.isCyclingWeeklyGoalSet
                      ? (Goal.userProgressCyclingGoalWeekly /
                                  Goal.userCyclingWeeklyEndGoal) >
                              1.0
                          ? 1.0
                          : Goal.userProgressCyclingGoalWeekly /
                              Goal.userCyclingWeeklyEndGoal
                      : 0,
              percent2: Goal.isDailyDisplayed
                  ? Goal.isRowingGoalSet
                      ? (Goal.userProgressRowingGoal / Goal.userRowingEndGoal) >
                              1.0
                          ? 1.0
                          : Goal.userProgressRowingGoal / Goal.userRowingEndGoal
                      : 0
                  : Goal.isRowingWeeklyGoalSet
                      ? (Goal.userProgressRowingGoalWeekly /
                                  Goal.userRowingWeeklyEndGoal) >
                              1.0
                          ? 1.0
                          : Goal.userProgressRowingGoalWeekly /
                              Goal.userRowingWeeklyEndGoal
                      : 0,
              percent3: Goal.isDailyDisplayed
                  ? Goal.isStepMillGoalSet
                      ? (Goal.userProgressStepMillGoal /
                                  Goal.userStepMillEndGoal) >
                              1.0
                          ? 1.0
                          : Goal.userProgressStepMillGoal /
                              Goal.userStepMillEndGoal
                      : 0
                  : Goal.isStepMillWeeklyGoalSet
                      ? (Goal.userProgressStepMillGoalWeekly /
                                  Goal.userStepMillWeeklyEndGoal) >
                              1.0
                          ? 1.0
                          : Goal.userProgressStepMillGoalWeekly /
                              Goal.userStepMillWeeklyEndGoal
                      : 0,
              onDoubleTap: () {
                Goal.isDailyDisplayed = !Goal.isDailyDisplayed;
                FireStore.updateHealthData(
                    {"isDailyDisplayed": Goal.isDailyDisplayed});
              },
              onLongPress: () {
                AddGoalWidget.launch(context);
              },
              scrollController: _otherSC,
              isGoal1Set:
                  (Goal.isCyclingGoalSet || Goal.isCyclingWeeklyGoalSet),
              isGoal2Set: (Goal.isRowingGoalSet || Goal.isRowingWeeklyGoalSet),
              isGoal3Set:
                  (Goal.isStepMillGoalSet || Goal.isStepMillWeeklyGoalSet))
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
          Goal.isHealthTrackerPermissionGranted =
              !Goal.isHealthTrackerPermissionGranted;
          if (!Goal.isHealthTrackerPermissionGranted) {
            FireStore.updateHealthData({"isCalGoalSet": false});
            FireStore.updateHealthData({"isStepGoalSet": false});
            FireStore.updateHealthData({"isMileGoalSet": false});
          }
          FireStore.updateHealthData({
            "isHealthTrackerPermissionGranted":
                Goal.isHealthTrackerPermissionGranted
          });
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
