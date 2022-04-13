// Copyright 2022 The myAPFP Authors. All rights reserved.

import 'dart:io';

import '/firebase/firestore.dart';

import '/util/goals/goal.dart';
import '/util/toasted/toasted.dart';
import '/util/goals/other_goal.dart';
import '/util/goals/exercise_time_goal.dart';

import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_theme.dart';

import '../set_goals/set_goals_widget.dart';

import '../home_page_graphic/hp_graphic.dart';

import '../health_app_info/health_app_info.dart';

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeWidget extends StatefulWidget {
  /// The user's goal document stream.
  final Stream<DocumentSnapshot<Map<String, dynamic>>> goalStream;

  /// The user's activity document stream.
  final Stream<DocumentSnapshot<Map<String, dynamic>>> activityStream;

  /// The annoucements collection stream.
  late final Stream<QuerySnapshot<Map<String, dynamic>>> announcementsStream;

  HomeWidget(
      {Key? key,
      required this.goalStream,
      required this.announcementsStream,
      required this.activityStream})
      : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  /// Stores a user's activity document snapshots.
  late Map<String, dynamic> _activitySnapshotBackup;

  /// Stores a user's goal document snapshots.
  late Map<String, dynamic> _goalSnapshotBackup;

  /// [ScrollController] for [_otherGoalsView].
  final _otherSC = ScrollController();

  /// [ScrollController] for [_calsView].
  final _calViewSC = ScrollController();

  /// [ScrollController] for [_stepsView].
  final _stepsViewSC = ScrollController();

  /// [ScrollController] for [_milesView].
  final _milesViewSC = ScrollController();

  /// [ScrollController] for [_exerciseTimeView].
  final _exerciseTimeViewSC = ScrollController();

  /// Serves as key for the [Scaffold] found in [build].
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  /// Label displayed above the [_goalsTabbedContainer].
  ///
  /// This changes based on which type of goals the user is currently viewing.
  String _goalType = "Daily";

  /// If the app is being ran on Android, this is set to 'Google Fit'.
  /// Otherwise, this is set to 'Health App'.
  String _platformHealthName = Platform.isAndroid ? 'Google Fit' : 'Health App';

  @override
  void initState() {
    super.initState();
    _listenToGoalStream();
    _listenToActivityStream();
    _checkIfHealthAppSynced();
  }

  @override
  void dispose() {
    super.dispose();
    _otherSC.dispose();
    _calViewSC.dispose();
    _stepsViewSC.dispose();
    _milesViewSC.dispose();
    _exerciseTimeViewSC.dispose();
  }

  /// This listens to the user's activity document stream.
  ///
  /// Upon any changes to said document, goal progress and the
  /// app's UI is updated accordingly.
  void _listenToActivityStream() {
    widget.activityStream.forEach((element) {
      _activitySnapshotBackup = new Map();
      if (element.data() != null) {
        _activitySnapshotBackup = element.data()!;
      }
      setState(() {
        Goal.userProgressExerciseTime =
            ExerciseGoal.totalTimeInMinutes(_activitySnapshotBackup);

        // ! Update once health app is integrated

        // Goal.userProgressCalGoal =
        //     ExerciseGoal.totalTimeInMinutes(_activitySnapshotBackup);
        // Goal.userProgressCalGoalWeekly =
        //     ExerciseGoal.totalTimeInMinutes(_activitySnapshotBackup) +
        //         Goal.userProgressExerciseTimeWeekly;

        // Goal.userProgressMileGoal =
        //     ExerciseGoal.totalTimeInMinutes(_activitySnapshotBackup);
        // Goal.userProgressMileGoalWeekly =
        //     ExerciseGoal.totalTimeInMinutes(_activitySnapshotBackup) +
        //         Goal.userProgressExerciseTimeWeekly;

        // Goal.userProgressStepGoal =
        //     ExerciseGoal.totalTimeInMinutes(_activitySnapshotBackup);
        // Goal.userProgressStepGoalWeekly =
        //     ExerciseGoal.totalTimeInMinutes(_activitySnapshotBackup) +
        //         Goal.userProgressExerciseTimeWeekly;

        // ! Update once health app is integrated

        Goal.userProgressCyclingGoal = OtherGoal.calcGoalSums(
            _activitySnapshotBackup,
            goalType: "Cycling");

        Goal.userProgressRowingGoal =
            OtherGoal.calcGoalSums(_activitySnapshotBackup, goalType: "Rowing");

        Goal.userProgressStepMillGoal = OtherGoal.calcGoalSums(
            _activitySnapshotBackup,
            goalType: "Step-Mill");

        Goal.userProgressEllipticalGoal = OtherGoal.calcGoalSums(
            _activitySnapshotBackup,
            goalType: "Elliptical");

        Goal.userProgressResistanceStrengthGoal = OtherGoal.calcGoalSums(
            _activitySnapshotBackup,
            goalType: "Resistance");

        FireStore.updateGoalData({
          "exerciseTimeGoalProgress": Goal.userProgressExerciseTime,
          "exerciseTimeGoalProgressWeekly": Goal.userProgressExerciseTimeWeekly,
          "calGoalProgress": Goal.userProgressCalGoal,
          "calGoalProgressWeekly": Goal.userProgressCalGoalWeekly,
          "stepGoalProgress": Goal.userProgressStepGoal,
          "stepGoalProgressWeekly": Goal.userProgressStepGoalWeekly,
          "mileGoalProgress": Goal.userProgressMileGoal,
          "mileGoalProgressWeekly": Goal.userProgressMileGoalWeekly,
          "cyclingGoalProgress": Goal.userProgressCyclingGoal,
          "cyclingGoalProgressWeekly": Goal.userProgressCyclingGoalWeekly,
          "rowingGoalProgress": Goal.userProgressRowingGoal,
          "rowingGoalProgressWeekly": Goal.userProgressRowingGoalWeekly,
          "stepMillGoalProgress": Goal.userProgressStepMillGoal,
          "stepMillGoalProgressWeekly": Goal.userProgressStepMillGoalWeekly,
          "ellipticalGoalProgress": Goal.userProgressEllipticalGoal,
          "ellipticalGoalProgressWeekly": Goal.userProgressEllipticalGoalWeekly,
          "resistanceStrengthGoalProgress":
              Goal.userProgressResistanceStrengthGoal,
          "resistanceStrengthGoalProgressWeekly":
              Goal.userProgressResistanceStrengthGoalWeekly,
        });
      });
    });
  }

  /// This listens to the user's goal document stream.
  ///
  /// Upon any changes to said document, goal progress and the
  /// app's UI is updated accordingly.
  void _listenToGoalStream() {
    widget.goalStream.forEach((element) {
      _goalSnapshotBackup = new Map();
      if (element.data() != null) {
        _goalSnapshotBackup = element.data()!;
        setState(() {
          Goal.dayOfMonth = _goalSnapshotBackup['dayOfMonth'];
          Goal.isDailyGoalsDisplayed =
              _goalSnapshotBackup['isDailyGoalsDisplayed'];
          _goalType = Goal.isDailyGoalsDisplayed ? "Daily" : "Weekly";

          Goal.isCalGoalSet = _goalSnapshotBackup['isCalGoalSet'];
          Goal.isCalWeeklyGoalSet = _goalSnapshotBackup['isCalGoalSet_w'];

          Goal.isStepGoalSet = _goalSnapshotBackup['isStepGoalSet'];
          Goal.isStepWeeklyGoalSet = _goalSnapshotBackup['isStepGoalSet_w'];

          Goal.isMileGoalSet = _goalSnapshotBackup['isMileGoalSet'];
          Goal.isMileWeeklyGoalSet = _goalSnapshotBackup['isMileGoalSet_w'];

          Goal.isExerciseTimeGoalSet =
              _goalSnapshotBackup['isExerciseTimeGoalSet'];
          Goal.isExerciseTimeWeeklyGoalSet =
              _goalSnapshotBackup['isExerciseTimeGoalSet_w'];

          Goal.isCyclingGoalSet = _goalSnapshotBackup['isCyclingGoalSet'];
          Goal.isCyclingWeeklyGoalSet =
              _goalSnapshotBackup['isCyclingGoalSet_w'];

          Goal.isRowingGoalSet = _goalSnapshotBackup['isRowingGoalSet'];
          Goal.isRowingWeeklyGoalSet = _goalSnapshotBackup['isRowingGoalSet_w'];

          Goal.isStepMillGoalSet = _goalSnapshotBackup['isStepMillGoalSet'];
          Goal.isStepMillWeeklyGoalSet =
              _goalSnapshotBackup['isStepMillGoalSet_w'];

          Goal.isEllipticalGoalSet = _goalSnapshotBackup['isEllipticalGoalSet'];
          Goal.isEllipticalWeeklyGoalSet =
              _goalSnapshotBackup['isEllipticalGoalSet_w'];

          Goal.isResistanceStrengthGoalSet =
              _goalSnapshotBackup['isResistanceStrengthGoalSet'];
          Goal.isResistanceStrengthWeeklyGoalSet =
              _goalSnapshotBackup['isResistanceStrengthGoalSet_w'];

          Goal.isHealthAppSynced = _goalSnapshotBackup['isHealthAppSynced'];

          Goal.userCalEndGoal = _goalSnapshotBackup['calEndGoal'].toDouble();
          Goal.userProgressCalGoalWeekly =
              _goalSnapshotBackup['calGoalProgressWeekly'].toDouble();
          Goal.userCalWeeklyEndGoal =
              _goalSnapshotBackup['calEndGoal_w'].toDouble();

          Goal.userStepEndGoal = _goalSnapshotBackup['stepEndGoal'].toDouble();
          Goal.userProgressStepGoalWeekly =
              _goalSnapshotBackup['stepGoalProgressWeekly'].toDouble();
          Goal.userStepWeeklyEndGoal =
              _goalSnapshotBackup['stepEndGoal_w'].toDouble();

          Goal.userMileEndGoal = _goalSnapshotBackup['mileEndGoal'].toDouble();
          Goal.userProgressMileGoalWeekly =
              _goalSnapshotBackup['mileGoalProgressWeekly'].toDouble();
          Goal.userMileWeeklyEndGoal =
              _goalSnapshotBackup['mileEndGoal_w'].toDouble();

          Goal.userExerciseTimeEndGoal =
              _goalSnapshotBackup['exerciseTimeEndGoal'].toDouble();
          Goal.userProgressExerciseTimeWeekly =
              _goalSnapshotBackup['exerciseTimeGoalProgressWeekly'].toDouble();
          Goal.userExerciseTimeWeeklyEndGoal =
              _goalSnapshotBackup['exerciseTimeEndGoal_w'].toDouble();

          Goal.userCyclingEndGoal =
              _goalSnapshotBackup['cyclingEndGoal'].toDouble();
          Goal.userProgressCyclingGoalWeekly =
              _goalSnapshotBackup['cyclingGoalProgressWeekly'].toDouble();
          Goal.userCyclingWeeklyEndGoal =
              _goalSnapshotBackup['cyclingEndGoal_w'].toDouble();

          Goal.userRowingEndGoal =
              _goalSnapshotBackup['rowingEndGoal'].toDouble();
          Goal.userProgressRowingGoalWeekly =
              _goalSnapshotBackup['rowingGoalProgressWeekly'].toDouble();
          Goal.userRowingWeeklyEndGoal =
              _goalSnapshotBackup['rowingEndGoal_w'].toDouble();

          Goal.userStepMillEndGoal =
              _goalSnapshotBackup['stepMillEndGoal'].toDouble();
          Goal.userProgressStepMillGoalWeekly =
              _goalSnapshotBackup['stepMillGoalProgressWeekly'].toDouble();
          Goal.userStepMillWeeklyEndGoal =
              _goalSnapshotBackup['stepMillEndGoal_w'].toDouble();

          Goal.userEllipticalEndGoal =
              _goalSnapshotBackup['ellipticalEndGoal'].toDouble();
          Goal.userProgressEllipticalGoalWeekly =
              _goalSnapshotBackup['ellipticalGoalProgressWeekly'].toDouble();
          Goal.userEllipticalWeeklyEndGoal =
              _goalSnapshotBackup['ellipticalEndGoal_w'].toDouble();

          Goal.userResistanceStrengthEndGoal =
              _goalSnapshotBackup['resistanceStrengthEndGoal'].toDouble();
          Goal.userProgressResistanceStrengthGoalWeekly =
              _goalSnapshotBackup['resistanceStrengthGoalProgressWeekly']
                  .toDouble();
          Goal.userResistanceStrengthWeeklyEndGoal =
              _goalSnapshotBackup['resistanceStrengthEndGoal_w'].toDouble();

          Goal.exerciseWeekDeadline =
              _goalSnapshotBackup['exerciseWeekDeadline'];
          Goal.calWeekDeadline = _goalSnapshotBackup['calWeekDeadline'];
          Goal.stepWeekDeadline = _goalSnapshotBackup['stepWeekDeadline'];
          Goal.mileWeekDeadline = _goalSnapshotBackup['mileWeekDeadline'];
          Goal.cyclingWeekDeadline = _goalSnapshotBackup['cyclingWeekDeadline'];
          Goal.rowingWeekDeadline = _goalSnapshotBackup['rowingWeekDeadline'];
          Goal.stepMillWeekDeadline =
              _goalSnapshotBackup['stepMillWeekDeadline'];
          Goal.ellipticalWeekDeadline =
              _goalSnapshotBackup['ellipticalWeekDeadline'];
          Goal.resistanceStrengthWeekDeadline =
              _goalSnapshotBackup['resistanceStrengthWeekDeadline'];
        });
        Goal.uploadCompletedGoals();
      }
    });
  }

  /// Checks if a user has granted physical activity permissions to myAPFP and
  /// updates the Firestore database accordingly.
  void _checkIfHealthAppSynced() async {
    await Permission.activityRecognition.request().isGranted
        ? FireStore.updateGoalData({"isHealthAppSynced": true})
        : FireStore.updateGoalData({"isHealthAppSynced": false});
  }

  /// Label used above the [_recentAnnouncementGrid].
  Padding _recentAnnouncementsLabel() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 16, 0, 0),
      child: Row(
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
      ),
    );
  }

  /// Creates text to be displayed in the [_recentAnnouncementGrid].
  Column _announcementText(String text) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75),
            child: AutoSizeText(
              text,
              overflow: TextOverflow.ellipsis,
              style: FlutterFlowTheme.bodyText1,
            )),
      ],
    );
  }

  /// Creates a urgent info (!) icon to be displayed next to an [_announcementText].
  Column _infoIcon() {
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

  /// Creates a row that includes an [_infoIcon] and [_announcementText].
  Row _announcementRow(String text) {
    return Row(
      children: [_infoIcon(), _announcementText(text)],
    );
  }

  /// Creates GridView to display recent announcements.
  GridView _recentAnnouncementGrid(
      String alertOneText, String alertTwoText, String alertThreeText) {
    return GridView(
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
    );
  }

  /// Wraps the [_recentAnnouncementGrid], and provides border decoration.
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
      child:
          _recentAnnouncementGrid(alertOneText, alertTwoText, alertThreeText),
    );
  }

  /// Label used above [_goalsTabbedContainer].
  ///
  /// This will be set to either "Daily Goals" or "Weekly Goals".
  Padding _goalTypeLabel() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          MediaQuery.of(context).size.width * 0.04,
          MediaQuery.of(context).size.height * 0.03,
          0,
          0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          AutoSizeText('$_goalType Goals', style: FlutterFlowTheme.title1),
        ],
      ),
    );
  }

  /// The view displayed in the 'Time' tab of the [_goalsTabbedContainer].
  InkWell _exerciseTimeView() {
    return HPGraphic.createView(
        key: Key("Home.exerciseView"),
        isGoalSet:
            (Goal.isExerciseTimeGoalSet || Goal.isExerciseTimeWeeklyGoalSet),
        isHealthAppSynced: true,
        scrollController: _exerciseTimeViewSC,
        onDoubleTap: () {
          Goal.isDailyGoalsDisplayed = !Goal.isDailyGoalsDisplayed;
          FireStore.updateGoalData(
              {"isDailyGoalsDisplayed": Goal.isDailyGoalsDisplayed});
        },
        onLongPress: () {
          SetGoalsWidget.launch(context);
        },
        context: context,
        goalProgress: Goal.isDailyGoalsDisplayed
            ? "${Goal.isExerciseTimeGoalSet ? Goal.userProgressExerciseTime.toStringAsFixed(2) : 0.toStringAsFixed(2)} / ${Goal.userExerciseTimeEndGoal.toStringAsFixed(2)}\nTotal Minutes"
            : "${Goal.isExerciseTimeWeeklyGoalSet ? Goal.userProgressExerciseTimeWeekly.toStringAsFixed(2) : 0.toStringAsFixed(2)} / ${Goal.userExerciseTimeWeeklyEndGoal.toStringAsFixed(2)}\nTotal Minutes",
        goalProgressInfo: Goal.isDailyGoalsDisplayed
            ? Goal.isExerciseTimeGoalSet
                ? "Your goal is " +
                    "${((Goal.userProgressExerciseTime / Goal.userExerciseTimeEndGoal) * 100) > 100 ? 100 : ((Goal.userProgressExerciseTime / Goal.userExerciseTimeEndGoal) * 100).toStringAsFixed(2)}" +
                    "% complete."
                : "Goal not active."
            : Goal.isExerciseTimeWeeklyGoalSet
                ? "Your goal is " +
                    "${((Goal.userProgressExerciseTimeWeekly / Goal.userExerciseTimeWeeklyEndGoal) * 100) > 100 ? 100 : ((Goal.userProgressExerciseTimeWeekly / Goal.userExerciseTimeWeeklyEndGoal) * 100).toStringAsFixed(2)}" +
                    "% complete.\nYou have ${int.parse(Goal.exerciseWeekDeadline.split("/")[1]) - DateTime.now().day} day(s) left."
                : "Goal not active.",
        percent: Goal.isDailyGoalsDisplayed
            ? (Goal.userProgressExerciseTime / Goal.userExerciseTimeEndGoal) >
                    1.0
                ? 1.0
                : Goal.userProgressExerciseTime / Goal.userExerciseTimeEndGoal
            : (Goal.userProgressExerciseTimeWeekly /
                        Goal.userExerciseTimeWeeklyEndGoal) >
                    1.0
                ? 1.0
                : Goal.userProgressExerciseTimeWeekly /
                    Goal.userExerciseTimeWeeklyEndGoal);
  }

  /// The view displayed in the 'Calories' tab of the [_goalsTabbedContainer].
  InkWell _calsView() {
    return HPGraphic.createView(
        key: Key("Home.calView"),
        isGoalSet: (Goal.isCalGoalSet || Goal.isCalWeeklyGoalSet),
        isHealthAppSynced: Goal.isHealthAppSynced,
        scrollController: _calViewSC,
        onDoubleTap: () {
          Goal.isDailyGoalsDisplayed = !Goal.isDailyGoalsDisplayed;
          FireStore.updateGoalData(
              {"isDailyGoalsDisplayed": Goal.isDailyGoalsDisplayed});
        },
        onLongPress: () {
          if (Goal.isHealthAppSynced) {
            SetGoalsWidget.launch(context);
          } else
            Toasted.showToast(
                "Please sync your $_platformHealthName to continue.");
        },
        context: context,
        goalProgress: Goal.isDailyGoalsDisplayed
            ? "${Goal.isCalGoalSet ? Goal.userProgressCalGoal.toStringAsFixed(2) : 0.toStringAsFixed(2)} / ${Goal.userCalEndGoal.toStringAsFixed(2)}\nCals Burned"
            : "${Goal.isCalWeeklyGoalSet ? Goal.userProgressCalGoalWeekly.toStringAsFixed(2) : 0.toStringAsFixed(2)} / ${Goal.userCalWeeklyEndGoal.toStringAsFixed(2)}\nCals Burned",
        goalProgressInfo: Goal.isDailyGoalsDisplayed
            ? Goal.isCalGoalSet
                ? "Your goal is " +
                    "${((Goal.userProgressCalGoal / Goal.userCalEndGoal) * 100) > 100 ? 100 : ((Goal.userProgressCalGoal / Goal.userCalEndGoal) * 100).toStringAsFixed(2)}" +
                    "% complete."
                : "Goal not active."
            : Goal.isCalWeeklyGoalSet
                ? "Your goal is " +
                    "${((Goal.userProgressCalGoalWeekly / Goal.userCalWeeklyEndGoal) * 100) > 100 ? 100 : ((Goal.userProgressCalGoalWeekly / Goal.userCalWeeklyEndGoal) * 100).toStringAsFixed(2)}" +
                    "% complete.\nYou have ${int.parse(Goal.calWeekDeadline.split("/")[1]) - DateTime.now().day} day(s) left."
                : "Goal not active.",
        percent: Goal.isDailyGoalsDisplayed
            ? (Goal.userProgressCalGoal / Goal.userCalEndGoal) > 1.0
                ? 1.0
                : Goal.userProgressCalGoal / Goal.userCalEndGoal
            : (Goal.userProgressCalGoalWeekly / Goal.userCalWeeklyEndGoal) > 1.0
                ? 1.0
                : Goal.userProgressCalGoalWeekly / Goal.userCalWeeklyEndGoal);
  }

  /// The view displayed in the 'Steps' tab of the [_goalsTabbedContainer].
  InkWell _stepsView() {
    return HPGraphic.createView(
        key: Key("Home.stepsView"),
        isGoalSet: (Goal.isStepGoalSet || Goal.isStepWeeklyGoalSet),
        isHealthAppSynced: Goal.isHealthAppSynced,
        scrollController: _stepsViewSC,
        onDoubleTap: () {
          Goal.isDailyGoalsDisplayed = !Goal.isDailyGoalsDisplayed;
          FireStore.updateGoalData(
              {"isDailyGoalsDisplayed": Goal.isDailyGoalsDisplayed});
        },
        onLongPress: () {
          if (Goal.isHealthAppSynced) {
            SetGoalsWidget.launch(context);
          } else
            Toasted.showToast(
                "Please sync your $_platformHealthName to continue.");
        },
        context: context,
        goalProgress: Goal.isDailyGoalsDisplayed
            ? "${Goal.isStepGoalSet ? Goal.userProgressStepGoal.toStringAsFixed(2) : 0.toStringAsFixed(2)} / ${Goal.userStepEndGoal.toStringAsFixed(2)}\nSteps Taken"
            : "${Goal.isStepWeeklyGoalSet ? Goal.userProgressStepGoalWeekly.toStringAsFixed(2) : 0.toStringAsFixed(2)} / ${Goal.userStepWeeklyEndGoal.toStringAsFixed(2)}\nSteps Taken",
        goalProgressInfo: Goal.isDailyGoalsDisplayed
            ? Goal.isStepGoalSet
                ? "Your goal is " +
                    "${((Goal.userProgressStepGoal / Goal.userStepEndGoal) * 100) > 100 ? 100 : ((Goal.userProgressStepGoal / Goal.userStepEndGoal) * 100).toStringAsFixed(2)}" +
                    "% complete."
                : "Goal not active."
            : Goal.isStepWeeklyGoalSet
                ? "Your goal is " +
                    "${((Goal.userProgressStepGoalWeekly / Goal.userStepWeeklyEndGoal) * 100) > 100 ? 100 : ((Goal.userProgressStepGoalWeekly / Goal.userStepWeeklyEndGoal) * 100).toStringAsFixed(2)}" +
                    "% complete.\nYou have ${int.parse(Goal.stepWeekDeadline.split("/")[1]) - DateTime.now().day} day(s) left."
                : "Goal not active.",
        percent: Goal.isDailyGoalsDisplayed
            ? (Goal.userProgressStepGoal / Goal.userStepEndGoal) > 1.0
                ? 1.0
                : Goal.userProgressStepGoal / Goal.userStepEndGoal
            : (Goal.userProgressStepGoalWeekly / Goal.userStepWeeklyEndGoal) >
                    1.0
                ? 1.0
                : Goal.userProgressStepGoalWeekly / Goal.userStepWeeklyEndGoal);
  }

  /// The view displayed in the 'Miles' tab of the [_goalsTabbedContainer].
  InkWell _milesView() {
    return HPGraphic.createView(
        key: Key("Home.mileView"),
        isGoalSet: (Goal.isMileGoalSet || Goal.isMileWeeklyGoalSet),
        isHealthAppSynced: Goal.isHealthAppSynced,
        scrollController: _milesViewSC,
        onDoubleTap: () {
          Goal.isDailyGoalsDisplayed = !Goal.isDailyGoalsDisplayed;
          FireStore.updateGoalData(
              {"isDailyGoalsDisplayed": Goal.isDailyGoalsDisplayed});
        },
        onLongPress: () {
          if (Goal.isHealthAppSynced) {
            SetGoalsWidget.launch(context);
          } else
            Toasted.showToast(
                "Please sync your $_platformHealthName to continue.");
        },
        context: context,
        goalProgress: Goal.isDailyGoalsDisplayed
            ? "${Goal.isMileGoalSet ? Goal.userProgressMileGoal.toStringAsFixed(2) : 0.toStringAsFixed(2)} / ${Goal.userMileEndGoal.toStringAsFixed(2)}\nMi Traveled"
            : "${Goal.isMileWeeklyGoalSet ? Goal.userProgressMileGoalWeekly.toStringAsFixed(2) : 0.toStringAsFixed(2)} / ${Goal.userMileWeeklyEndGoal.toStringAsFixed(2)}\nMi Traveled",
        goalProgressInfo: Goal.isDailyGoalsDisplayed
            ? Goal.isMileGoalSet
                ? "Your goal is " +
                    "${((Goal.userProgressMileGoal / Goal.userMileEndGoal) * 100) > 100 ? 100 : ((Goal.userProgressMileGoal / Goal.userMileEndGoal) * 100).toStringAsFixed(2)}" +
                    "% complete."
                : "Goal not active."
            : Goal.isMileWeeklyGoalSet
                ? "Your goal is " +
                    "${((Goal.userProgressMileGoalWeekly / Goal.userMileWeeklyEndGoal) * 100) > 100 ? 100 : ((Goal.userProgressMileGoalWeekly / Goal.userMileWeeklyEndGoal) * 100).toStringAsFixed(2)}" +
                    "% complete.\nYou have ${int.parse(Goal.mileWeekDeadline.split("/")[1]) - DateTime.now().day} day(s) left."
                : "Goal not active.",
        percent: Goal.isDailyGoalsDisplayed
            ? (Goal.userProgressMileGoal / Goal.userMileEndGoal) > 1.0
                ? 1.0
                : Goal.userProgressMileGoal / Goal.userMileEndGoal
            : (Goal.userProgressMileGoalWeekly / Goal.userMileWeeklyEndGoal) >
                    1.0
                ? 1.0
                : Goal.userProgressMileGoalWeekly / Goal.userMileWeeklyEndGoal);
  }

  /// The view displayed in the 'Other' tab of the [_goalsTabbedContainer].
  InkWell _otherGoalsView() {
    return HPGraphic.createOtherView(
        key: Key("Home.otherGoalsView"),
        context: context,
        goal1ProgressInfo: Goal.isDailyGoalsDisplayed
            ? Goal.isCyclingGoalSet
                ? "Cycling - ${Goal.userProgressCyclingGoal.toStringAsFixed(2)} / ${Goal.userCyclingEndGoal.toStringAsFixed(2)} min"
                : "Cycling Goal Not Active"
            : Goal.isCyclingWeeklyGoalSet
                ? "Cycling - ${Goal.userProgressCyclingGoalWeekly.toStringAsFixed(2)} / ${Goal.userCyclingWeeklyEndGoal.toStringAsFixed(2)} min" +
                    "\n${int.parse(Goal.cyclingWeekDeadline.split("/")[1]) - DateTime.now().day} day(s) left"
                : "Cycling Goal Not Active",
        goal2ProgressInfo: Goal.isDailyGoalsDisplayed
            ? Goal.isRowingGoalSet
                ? "Rowing - ${Goal.userProgressRowingGoal.toStringAsFixed(2)} / ${Goal.userRowingEndGoal.toStringAsFixed(2)} min"
                : "Rowing Goal Not Active"
            : Goal.isRowingWeeklyGoalSet
                ? "Rowing - ${Goal.userProgressRowingGoalWeekly.toStringAsFixed(2)} / ${Goal.userRowingWeeklyEndGoal.toStringAsFixed(2)} min" +
                    "\n${int.parse(Goal.rowingWeekDeadline.split("/")[1]) - DateTime.now().day} day(s) left"
                : "Rowing Goal Not Active",
        goal3ProgressInfo: Goal.isDailyGoalsDisplayed
            ? Goal.isStepMillGoalSet
                ? "Step Mill - ${Goal.userProgressStepMillGoal.toStringAsFixed(2)} / ${Goal.userStepMillEndGoal.toStringAsFixed(2)} min"
                : "Step Mill Goal Not Active"
            : Goal.isStepMillWeeklyGoalSet
                ? "Step Mill - ${Goal.userProgressStepMillGoalWeekly.toStringAsFixed(2)} / ${Goal.userStepMillWeeklyEndGoal.toStringAsFixed(2)} min" +
                    "\n${int.parse(Goal.stepMillWeekDeadline.split("/")[1]) - DateTime.now().day} day(s) left"
                : "Step Mill Goal Not Active",
        goal4ProgressInfo: Goal.isDailyGoalsDisplayed
            ? Goal.isEllipticalGoalSet
                ? "Elliptical - ${Goal.userProgressEllipticalGoal.toStringAsFixed(2)} / ${Goal.userEllipticalEndGoal.toStringAsFixed(2)} min"
                : "Elliptical Goal Not Active"
            : Goal.isEllipticalWeeklyGoalSet
                ? "Elliptical - ${Goal.userProgressEllipticalGoalWeekly.toStringAsFixed(2)} / ${Goal.userEllipticalWeeklyEndGoal.toStringAsFixed(2)} min" +
                    "\n${int.parse(Goal.ellipticalWeekDeadline.split("/")[1]) - DateTime.now().day} day(s) left"
                : "Elliptical Goal Not Active",
        goal5ProgressInfo: Goal.isDailyGoalsDisplayed
            ? Goal.isResistanceStrengthGoalSet
                ? "Resistance - ${Goal.userProgressResistanceStrengthGoal.toStringAsFixed(2)} / ${Goal.userResistanceStrengthEndGoal.toStringAsFixed(2)} min"
                : "Resistance Goal Not Active"
            : Goal.isResistanceStrengthWeeklyGoalSet
                ? "Resistance - ${Goal.userProgressResistanceStrengthGoalWeekly.toStringAsFixed(2)} / ${Goal.userResistanceStrengthWeeklyEndGoal.toStringAsFixed(2)} min" +
                    "\n${int.parse(Goal.resistanceStrengthWeekDeadline.split("/")[1]) - DateTime.now().day} day(s) left"
                : "Resistance Goal Not Active",
        percent1: Goal.isDailyGoalsDisplayed
            ? Goal.isCyclingGoalSet
                ? (Goal.userProgressCyclingGoal / Goal.userCyclingEndGoal) > 1.0
                    ? 1.0
                    : Goal.userProgressCyclingGoal / Goal.userCyclingEndGoal
                : 0
            : Goal.isCyclingWeeklyGoalSet
                ? (Goal.userProgressCyclingGoalWeekly /
                            Goal.userCyclingWeeklyEndGoal) >
                        1.0
                    ? 1.0
                    : Goal.userProgressCyclingGoalWeekly /
                        Goal.userCyclingWeeklyEndGoal
                : 0,
        percent2: Goal.isDailyGoalsDisplayed
            ? Goal.isRowingGoalSet
                ? (Goal.userProgressRowingGoal / Goal.userRowingEndGoal) > 1.0
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
        percent3: Goal.isDailyGoalsDisplayed
            ? Goal.isStepMillGoalSet
                ? (Goal.userProgressStepMillGoal / Goal.userStepMillEndGoal) >
                        1.0
                    ? 1.0
                    : Goal.userProgressStepMillGoal / Goal.userStepMillEndGoal
                : 0
            : Goal.isStepMillWeeklyGoalSet
                ? (Goal.userProgressStepMillGoalWeekly /
                            Goal.userStepMillWeeklyEndGoal) >
                        1.0
                    ? 1.0
                    : Goal.userProgressStepMillGoalWeekly /
                        Goal.userStepMillWeeklyEndGoal
                : 0,
        percent4: Goal.isDailyGoalsDisplayed
            ? Goal.isEllipticalGoalSet
                ? (Goal.userProgressEllipticalGoal /
                            Goal.userEllipticalEndGoal) >
                        1.0
                    ? 1.0
                    : Goal.userProgressEllipticalGoal /
                        Goal.userEllipticalEndGoal
                : 0
            : Goal.isEllipticalWeeklyGoalSet
                ? (Goal.userProgressEllipticalGoalWeekly /
                            Goal.userEllipticalWeeklyEndGoal) >
                        1.0
                    ? 1.0
                    : Goal.userProgressEllipticalGoalWeekly /
                        Goal.userEllipticalWeeklyEndGoal
                : 0,
        percent5: Goal.isDailyGoalsDisplayed
            ? Goal.isResistanceStrengthGoalSet
                ? (Goal.userProgressResistanceStrengthGoal /
                            Goal.userResistanceStrengthEndGoal) >
                        1.0
                    ? 1.0
                    : Goal.userProgressResistanceStrengthGoal /
                        Goal.userResistanceStrengthEndGoal
                : 0
            : Goal.isResistanceStrengthWeeklyGoalSet
                ? (Goal.userProgressResistanceStrengthGoalWeekly /
                            Goal.userResistanceStrengthWeeklyEndGoal) >
                        1.0
                    ? 1.0
                    : Goal.userProgressResistanceStrengthGoalWeekly /
                        Goal.userResistanceStrengthWeeklyEndGoal
                : 0,
        onDoubleTap: () {
          Goal.isDailyGoalsDisplayed = !Goal.isDailyGoalsDisplayed;
          FireStore.updateGoalData(
              {"isDailyGoalsDisplayed": Goal.isDailyGoalsDisplayed});
        },
        onLongPress: () {
          SetGoalsWidget.launch(context);
        },
        scrollController: _otherSC,
        isGoal1Set: (Goal.isCyclingGoalSet || Goal.isCyclingWeeklyGoalSet),
        isGoal2Set: (Goal.isRowingGoalSet || Goal.isRowingWeeklyGoalSet),
        isGoal3Set: (Goal.isStepMillGoalSet || Goal.isStepMillWeeklyGoalSet),
        isGoal4Set:
            (Goal.isEllipticalGoalSet || Goal.isEllipticalWeeklyGoalSet),
        isGoal5Set: (Goal.isResistanceStrengthGoalSet ||
            Goal.isResistanceStrengthWeeklyGoalSet));
  }

  /// The tabbed container used with the goals system.
  Padding _goalsTabbedContainer() {
    return Padding(
      key: Key('Home.goalsTabbedContainer'),
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
          _exerciseTimeView(),
          _calsView(),
          _stepsView(),
          _milesView(),
          _otherGoalsView()
        ]),
      ),
    );
  }

  /// Creates button that allows user to sync a health app to myAPFP.
  Padding _syncHealthAppButton() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 40),
      child: FFButtonWidget(
        onPressed: () async {
          if (await Permission.activityRecognition.request().isGranted) {
            FireStore.updateGoalData({"isHealthAppSynced": true});
            Toasted.showToast("$_platformHealthName has been synchronized!");
          } else if (await Permission.activityRecognition
              .request()
              .isPermanentlyDenied) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HealthAppInfo()),
            );
          }
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
    return Scaffold(
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
                    List<String> alertTexts =
                        new List.filled(3, "No older announcements.");
                    if (snapshot.data!.docs.length > 0) {
                      alertTexts[0] = snapshot.data?.docs[0]['title'];
                    }
                    if (snapshot.data!.docs.length > 1) {
                      alertTexts[1] = snapshot.data?.docs[1]['title'];
                    }
                    if (snapshot.data!.docs.length > 2) {
                      alertTexts[2] = snapshot.data?.docs[2]['title'];
                    }
                    return _announcements(
                        alertTexts[0], alertTexts[1], alertTexts[2]);
                  } else {
                    return Text("No announcements available.");
                  }
                }),
            _goalTypeLabel(),
            _goalsTabbedContainer(),
            SizedBox(
              height: 5,
            ),
            _syncHealthAppButton(),
          ],
        ),
      )),
    );
  }
}
