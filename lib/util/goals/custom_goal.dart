import 'goal.dart';

class CustomGoal {
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
        case "ResStrength":
          resistanceStrengthDuration += Goal.convertToDuration(value[2]);
          break;
      }
    });
    double sum = 0.0;
    switch (goalType) {
      case "Cycling":
        sum = _toMinutes(cyclingDuration);
        break;
      case "Rowing":
        sum = _toMinutes(rowingDuration);
        break;
      case "Step-Mill":
        sum = _toMinutes(stepMillDuration);
        break;
      case "Elliptical":
        sum = _toMinutes(ellipticalDuration);
        break;
      case "ResStrength":
        sum = _toMinutes(resistanceStrengthDuration);
        break;
    }
    return sum;
  }

  static double _toMinutes(Duration goalSum) {
    String hhmmss = goalSum.toString().split('.').first.padLeft(8, "0");
    List<String> hhmmssSplit = hhmmss.split(':');
    return double.parse(hhmmssSplit[0]) * 60 +
        double.parse(hhmmssSplit[1]) +
        double.parse(hhmmssSplit[2]) / 60;
  }
}
