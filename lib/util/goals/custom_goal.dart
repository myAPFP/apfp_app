import 'goal.dart';

class CustomGoal {
  static Duration _cyclingDuration = Duration.zero;
  static Duration _rowingDuration = Duration.zero;
  static Duration _stepMillDuration = Duration.zero;
  static Duration _ellipticalDuration = Duration.zero;
  static Duration _resistanceStrengthDuration = Duration.zero;

  static double calcGoalProgress(Map activitySnapshot, {required String goalType}) {
    activitySnapshot.forEach((key, value) {
      _findGoalDuration(value);
    });
    return _durationInMinutes(goalType);
  }

  static void _findGoalDuration(List<String> activityInfo) {
    String exerciseName = activityInfo[0];
    String activityDurationStr = activityInfo[2];
    switch (exerciseName) {
      case "Cycling":
        _cyclingDuration += Goal.convertToDuration(activityDurationStr);
        break;
      case "Rowing":
        _rowingDuration += Goal.convertToDuration(activityDurationStr);
        break;
      case "Step-Mill":
        _stepMillDuration += Goal.convertToDuration(activityDurationStr);
        break;
      case "Elliptical":
        _ellipticalDuration += Goal.convertToDuration(activityDurationStr);
        break;
      case "ResStrength":
        _resistanceStrengthDuration +=
            Goal.convertToDuration(activityDurationStr);
        break;
    }
  }

  static double _durationInMinutes(String goalType) {
    double sum = 0.0;
    switch (goalType) {
      case "Cycling":
        sum = Goal.toMinutes(_cyclingDuration);
        break;
      case "Rowing":
        sum = Goal.toMinutes(_rowingDuration);
        break;
      case "Step-Mill":
        sum = Goal.toMinutes(_stepMillDuration);
        break;
      case "Elliptical":
        sum = Goal.toMinutes(_ellipticalDuration);
        break;
      case "ResStrength":
        sum = Goal.toMinutes(_resistanceStrengthDuration);
        break;
    }
    return sum;
  }
}
