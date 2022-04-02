import 'goal.dart';

class ExerciseGoal {
  static double totalTimeInMinutes(Map activitySnapshot) {
    Duration sum = Duration.zero;
    activitySnapshot.forEach((key, value) {
      sum += Goal.convertToDuration(value[2]);
    });
    String hhmmss= sum.toString().split('.').first.padLeft(8, "0");
    List<String> hhmmssSplit = hhmmss.split(':');
    return double.parse(hhmmssSplit[0]) * 60 +
        double.parse(hhmmssSplit[1]) +
        double.parse(hhmmssSplit[2]) / 60;
  }
}
