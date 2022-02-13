import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../flutter_flow/flutter_flow_theme.dart';

class HPGraphic {
  static ContainedTabBarView tabbedContainer(BuildContext context) {
    return ContainedTabBarView(
      tabs: [
        Text('Calories'),
        Text('Steps'),
        Text('Miles'),
        Text('Exercise Time')
      ],
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
      views: [
        _createView(
            context: context,
            innerCircleText: "146 of 225\nCals Burned",
            goalProgress: "You've completed 65% of your goal.",
            percent: 0.65),
        _createView(
            context: context,
            innerCircleText: "520 of 2000\nSteps Taken",
            goalProgress: "You've completed 26% of your goal.",
            percent: 0.26),
        _createView(
            context: context,
            innerCircleText: "3 of 6 Miles\nWalked / Ran",
            goalProgress: "You've completed 50% of your goal.",
            percent: 0.50),
        _createView(
            context: context,
            innerCircleText: "3 of 3\nTotal Hours\nof Exercise",
            goalProgress: "You've completed 100% of your goal.\nGreat Job!",
            percent: 1.0),
      ],
    );
  }

  static Container _createView(
      {required BuildContext context,
      required String innerCircleText,
      required String goalProgress,
      required double percent}) {
    return Container(
        child: SingleChildScrollView(
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
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            circularStrokeCap: CircularStrokeCap.square,
            backgroundColor: FlutterFlowTheme.secondaryColor,
            progressColor: Colors.green,
          ),
          SizedBox(height: 25),
          Text(goalProgress, style: TextStyle(fontSize: 20))
        ],
      ),
    ));
  }
}
