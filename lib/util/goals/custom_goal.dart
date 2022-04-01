import 'goal.dart';

class CustomGoal {
  static List<double> calcGoalSums(Map activitySnapshot) {
    Duration cyclingSum = Duration.zero;
    Duration rowingSum = Duration.zero;
    Duration stepMillSum = Duration.zero;
    activitySnapshot.forEach((key, value) {
      switch (value[0]) {
        case "Cycling":
          cyclingSum += Goal.convertToDuration(value[2]);
          break;
        case "Rowing":
          rowingSum += Goal.convertToDuration(value[2]);
          break;
        case "Step-Mill":
          stepMillSum += Goal.convertToDuration(value[2]);
          break;
      }
    });
    return [
      _toMinutes(cyclingSum),
      _toMinutes(rowingSum),
      _toMinutes(stepMillSum)
    ];
  }

  static double _toMinutes(Duration goalSum) {
    String hhmmss = goalSum.toString().split('.').first.padLeft(8, "0");
    List<String> hhmmssSplit = hhmmss.split(':');
    return double.parse(hhmmssSplit[0]) * 60 +
        double.parse(hhmmssSplit[1]) +
        double.parse(hhmmssSplit[2]) / 60;
  }
}
