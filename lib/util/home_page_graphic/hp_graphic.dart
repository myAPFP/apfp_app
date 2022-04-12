import 'dart:io';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../flutter_flow/flutter_flow_theme.dart';

class HPGraphic {
  /// If the app is being ran on Android, this is set to 'Google Fit'.
  /// Otherwise, this is set to 'Health App'.
  static String _platformHealthName =
      Platform.isAndroid ? 'Google Fit' : 'Health App';

  static List<Widget> _goalViews = [];

  /// ContainedTabBarView displayed in Home.
  ///
  /// The length of tabs must be equivalent to the length of views.
  static ContainedTabBarView tabbedContainer(
      {required BuildContext context,
      required List<Widget> tabs,
      required List<Widget> views}) {
    return ContainedTabBarView(
      tabs: tabs,
      tabBarProperties: TabBarProperties(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 32,
        background: Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.secondaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                spreadRadius: 0.5,
                blurRadius: 2,
                offset: Offset(1, -1),
              ),
            ],
          ),
        ),
        position: TabBarPosition.top,
        alignment: TabBarAlignment.center,
        indicatorColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[400],
      ),
      views: views,
    );
  }

  static InkWell createGoalView(
      {required Key key,
      required BuildContext context,
      required String goalProgress,
      required String goalProgressInfo,
      required double percent,
      required Function onDoubleTap,
      required Function onLongPress,
      required ScrollController scrollController,
      required bool isHealthAppSynced,
      required bool isGoalSet}) {
    if (!isHealthAppSynced) {
      goalProgress = "$_platformHealthName\nNot Sync'd";
      goalProgressInfo = Platform.isIOS
          ? "Sync your myAPFP App with\na $_platformHealthName to set this goal."
          : "Sync your myAPFP App with\n$_platformHealthName to set this goal.";
      percent = 0;
    } else if (!isGoalSet && isHealthAppSynced) {
      goalProgress = "No\nActive\nGoal";
      goalProgressInfo = "Long Press here to set & edit goals.";
      percent = 0;
    }
    return InkWell(
      key: key,
      onDoubleTap: () => onDoubleTap(),
      onLongPress: () => onLongPress(),
      child: Container(
          child: Scrollbar(
        controller: scrollController,
        isAlwaysShown: true,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 25),
              CircularPercentIndicator(
                radius: MediaQuery.of(context).size.width / 2.0,
                animation: true,
                animationDuration: 1200,
                lineWidth: 15.0,
                percent: percent,
                center: new Text(
                  goalProgress,
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                circularStrokeCap: CircularStrokeCap.square,
                backgroundColor: FlutterFlowTheme.secondaryColor,
                progressColor: Colors.green,
              ),
              SizedBox(height: 25),
              Text(goalProgressInfo, style: TextStyle(fontSize: 20))
            ],
          ),
        ),
      )),
    );
  }

  static void initOtherGoalView(
    bool isCyclingSet,
    bool isRowingSet,
    bool isStepMillSet,
    bool isEllipicalSet,
    bool isResStrengthSet,
    String cyclingProgress,
    String rowingProgress,
    String stepMillProgress,
    String ellipticalProgress,
    String resStrengthProgress,
    double cyclingPercent,
    double rowingPercent,
    double stepMillPercent,
    double ellipticalPercent,
    double resStrengthPercent,
  ) {
    _otherGoal(isCyclingSet, "Cycling", cyclingProgress, cyclingPercent)
        .forEach((widget) {
      _goalViews.add(widget);
    });

    _otherGoal(isRowingSet, "Rowing", rowingProgress, rowingPercent)
        .forEach((widget) {
      _goalViews.add(widget);
    });

    _otherGoal(isStepMillSet, "Step Mill", stepMillProgress, stepMillPercent)
        .forEach((widget) {
      _goalViews.add(widget);
    });

    _otherGoal(
            isEllipicalSet, "Elliptical", ellipticalProgress, ellipticalPercent)
        .forEach((widget) {
      _goalViews.add(widget);
    });

    _otherGoal(isResStrengthSet, "Resistance", resStrengthProgress,
            resStrengthPercent)
        .forEach((widget) {
      _goalViews.add(widget);
    });
  }

  /// Creates a view to be used in [tabbedContainer] that contains
  /// all 'other' goals:
  ///
  /// Cycling, Rowing, Step Mill, Elliptical, and Resistance
  /// & Strength training.
  static InkWell createOtherGoalView({
    required Key key,
    required BuildContext context,
    required Function onDoubleTap,
    required Function onLongPress,
    required ScrollController scrollController,
  }) {
    return InkWell(
      key: key,
      onDoubleTap: () => onDoubleTap(),
      onLongPress: () => onLongPress(),
      child: Container(
          child: Scrollbar(
        controller: scrollController,
        isAlwaysShown: true,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _goalViews),
        ),
      )),
    );
  }

  static List<Widget> _otherGoal(
      bool isGoalSet, String goalName, String goalProgress, double percent) {
    return [
      SizedBox(height: 25),
      Text(isGoalSet ? goalProgress : '$goalName Goal Not Active',
          style: TextStyle(fontSize: 20)),
      SizedBox(height: 5),
      LinearPercentIndicator(
        linearStrokeCap: LinearStrokeCap.butt,
        lineHeight: 30,
        animation: true,
        animationDuration: 1200,
        center: isGoalSet
            ? Text("${(percent * 100).toStringAsFixed(2)} %",
                style: TextStyle(color: Colors.white))
            : Text('0.00 %', style: TextStyle(color: Colors.white)),
        percent: isGoalSet ? percent : 0.0,
        backgroundColor: FlutterFlowTheme.secondaryColor,
        progressColor: Colors.green,
      ),
    ];
  }
}
