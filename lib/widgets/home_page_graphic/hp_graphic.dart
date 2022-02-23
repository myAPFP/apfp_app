import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../flutter_flow/flutter_flow_theme.dart';

class HPGraphic {
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

  static InkWell createView(
      {required BuildContext context,
      required String innerCircleText,
      required String goalProgressStr,
      required double percent,
      required Function onDoubleTap,
      required ScrollController scrollController,
      required bool isHealthGranted,
      required bool isGoalSet}) {
    if (!isHealthGranted) {
      innerCircleText = "Health App\nNot Sync'd";
      goalProgressStr =
          "Sync your myAPFP App with\na Health App to set this goal.";
      percent = 0;
    } else if (!isGoalSet && isHealthGranted) {
      innerCircleText = "N/A";
      goalProgressStr =
          "You don't have an active goal.\nDouble tap here to set one.";
      percent = 0;
    }
    return InkWell(
      onDoubleTap: () => onDoubleTap(),
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
                  innerCircleText,
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                circularStrokeCap: CircularStrokeCap.square,
                backgroundColor: FlutterFlowTheme.secondaryColor,
                progressColor: Colors.green,
              ),
              SizedBox(height: 25),
              Text(goalProgressStr, style: TextStyle(fontSize: 20))
            ],
          ),
        ),
      )),
    );
  }
}
