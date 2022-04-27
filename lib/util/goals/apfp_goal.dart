// Copyright 2022 The myAPFP Authors. All rights reserved.

import 'goal.dart';

class APFPGoal {
  /// Loops through each activity in [activitySnapshot] and calculates the
  /// total amount of minutes spent doing each 'APFP' activity.
  ///
  /// Returns the minute count as a double.
  static double calcGoalSums(Map activitySnapshot, {required String goalType}) {
    Duration cyclingDuration = Duration.zero;
    Duration rowingDuration = Duration.zero;
    Duration stepMillDuration = Duration.zero;
    Duration ellipticalDuration = Duration.zero;
    Duration resistanceStrengthDuration = Duration.zero;
    activitySnapshot.forEach((key, value) {
      switch (value[0]) {
        case "Cycling":
          cyclingDuration += Goal.convertToDuration(value[2]);
          break;
        case "Rowing":
          rowingDuration += Goal.convertToDuration(value[2]);
          break;
        case "Step-Mill":
          stepMillDuration += Goal.convertToDuration(value[2]);
          break;
        case "Elliptical":
          ellipticalDuration += Goal.convertToDuration(value[2]);
          break;
        case "Resistance":
          resistanceStrengthDuration += Goal.convertToDuration(value[2]);
          break;
      }
    });
    double sum = 0.0;
    switch (goalType) {
      case "Cycling":
        sum = Goal.toMinutes(cyclingDuration);
        break;
      case "Rowing":
        sum = Goal.toMinutes(rowingDuration);
        break;
      case "Step-Mill":
        sum = Goal.toMinutes(stepMillDuration);
        break;
      case "Elliptical":
        sum = Goal.toMinutes(ellipticalDuration);
        break;
      case "Resistance":
        sum = Goal.toMinutes(resistanceStrengthDuration);
        break;
    }
    return sum;
  }
}
