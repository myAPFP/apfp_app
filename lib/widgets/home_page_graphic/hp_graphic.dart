// Copyright 2022 The myAPFP Authors. All rights reserved.

import 'dart:io';

import 'package:apfp/util/platform/device_platform.dart';

import '/flutter_flow/flutter_flow_theme.dart';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

class HPGraphic {
  /// Creates a container which holds different tabs & views.
  ///
  /// [tabs] are typically a list of two or more widgets which are used as tab buttons.
  ///
  /// [views] are typically a list of two or more widgets which are used as tab views.
  ///
  /// NOTE: The length of [tabs] must match the length of [views].
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

  /// Creates a view to display a default goal.
  ///
  /// [percent] must be between 0.0 and 1.0.
  ///
  /// If [isHealthAppSynced] is set to false, the goal within view
  /// cannot be set until a user synchronizes a health app to myAPFP.
  static InkWell createView(
      {required Key key,
      required BuildContext context,
      required String goalProgress,
      required String goalProgressInfo,
      required double percent,
      required Function onLongPress,
      required ScrollController scrollController,
      required bool isHealthAppSynced,
      required bool isGoalSet}) {
    var platformHealthName = DevicePlatform.platformHealthName;
    if (!isHealthAppSynced) {
      goalProgress = "$platformHealthName\nNot Sync'd";
      goalProgressInfo = Platform.isIOS
          ? "Sync your myAPFP App with\na $platformHealthName to set this goal."
          : "Sync your myAPFP App with\n$platformHealthName to set this goal.";
      percent = 0;
    } else if (!isGoalSet && isHealthAppSynced) {
      goalProgress = "No\nActive\nGoal";
      goalProgressInfo = "Long Press here to set & edit goals.";
      percent = 0;
    }
    return InkWell(
      key: key,
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

  /// Creates a view to display 'APFP' goals.
  /// This view should be used with the 'APFP' tab.
  ///
  /// Any value passed as a percent must be between 0.0 and 1.0.
  static InkWell createAPFPView({
    required Key key,
    required BuildContext context,
    required String goal1ProgressInfo,
    required String goal2ProgressInfo,
    required String goal3ProgressInfo,
    required String goal4ProgressInfo,
    required String goal5ProgressInfo,
    required double percent1,
    required double percent2,
    required double percent3,
    required double percent4,
    required double percent5,
    required Function onLongPress,
    required ScrollController scrollController,
    required bool isGoal1Set,
    required bool isGoal2Set,
    required bool isGoal3Set,
    required bool isGoal4Set,
    required bool isGoal5Set,
  }) {
    return InkWell(
      key: key,
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
                Text(isGoal1Set ? goal1ProgressInfo : 'Cycling Goal Not Active',
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 5),
                LinearPercentIndicator(
                  linearStrokeCap: LinearStrokeCap.butt,
                  lineHeight: 30,
                  animation: true,
                  animationDuration: 1200,
                  center: isGoal1Set
                      ? Text("${(percent1 * 100).toStringAsFixed(2)} %",
                          style: TextStyle(color: Colors.white))
                      : Text('0.00 %', style: TextStyle(color: Colors.white)),
                  percent: isGoal1Set ? percent1 : 0.0,
                  backgroundColor: FlutterFlowTheme.secondaryColor,
                  progressColor: Colors.green,
                ),
                SizedBox(height: 25),
                Text(isGoal2Set ? goal2ProgressInfo : 'Rowing Goal Not Active',
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 5),
                LinearPercentIndicator(
                  linearStrokeCap: LinearStrokeCap.butt,
                  lineHeight: 30,
                  animation: true,
                  animationDuration: 1200,
                  center: isGoal2Set
                      ? Text("${(percent2 * 100).toStringAsFixed(2)} %",
                          style: TextStyle(color: Colors.white))
                      : Text('0.00 %', style: TextStyle(color: Colors.white)),
                  percent: isGoal2Set ? percent2 : 0.0,
                  backgroundColor: FlutterFlowTheme.secondaryColor,
                  progressColor: Colors.green,
                ),
                SizedBox(height: 25),
                Text(
                    isGoal3Set
                        ? goal3ProgressInfo
                        : 'Step Mill Goal Not Active',
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 5),
                LinearPercentIndicator(
                  linearStrokeCap: LinearStrokeCap.butt,
                  lineHeight: 30,
                  animation: true,
                  animationDuration: 1200,
                  center: isGoal3Set
                      ? Text("${(percent3 * 100).toStringAsFixed(2)} %",
                          style: TextStyle(color: Colors.white))
                      : Text('0.00 %', style: TextStyle(color: Colors.white)),
                  percent: isGoal3Set ? percent3 : 0.0,
                  backgroundColor: FlutterFlowTheme.secondaryColor,
                  progressColor: Colors.green,
                ),
                SizedBox(height: 25),
                Text(
                    isGoal4Set
                        ? goal4ProgressInfo
                        : 'Elliptical Goal Not Active',
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 5),
                LinearPercentIndicator(
                  linearStrokeCap: LinearStrokeCap.butt,
                  lineHeight: 30,
                  animation: true,
                  animationDuration: 1200,
                  center: isGoal4Set
                      ? Text("${(percent4 * 100).toStringAsFixed(2)} %",
                          style: TextStyle(color: Colors.white))
                      : Text('0.00 %', style: TextStyle(color: Colors.white)),
                  percent: isGoal4Set ? percent4 : 0.0,
                  backgroundColor: FlutterFlowTheme.secondaryColor,
                  progressColor: Colors.green,
                ),
                SizedBox(height: 25),
                Text(
                    isGoal5Set
                        ? goal5ProgressInfo
                        : 'Resistance Goal Not Active',
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 5),
                LinearPercentIndicator(
                  linearStrokeCap: LinearStrokeCap.butt,
                  lineHeight: 30,
                  animation: true,
                  animationDuration: 1200,
                  center: isGoal5Set
                      ? Text("${(percent5 * 100).toStringAsFixed(2)} %",
                          style: TextStyle(color: Colors.white))
                      : Text('0.00 %', style: TextStyle(color: Colors.white)),
                  percent: isGoal5Set ? percent5 : 0.0,
                  backgroundColor: FlutterFlowTheme.secondaryColor,
                  progressColor: Colors.green,
                ),
                SizedBox(height: 10)
              ]),
        ),
      )),
    );
  }
}
