import 'goal.dart';

class ExerciseGoal {
  static double totalTimeInMinutes(Map activitySnapshot) {
    Duration sum = Duration.zero;
    activitySnapshot.forEach((key, value) {
      sum += Goal.convertToDuration(value[2]);
    });
    String HHmmss = sum.toString().split('.').first.padLeft(8, "0");
    List<String> HHmmssSplit = HHmmss.split(':');
    return double.parse(HHmmssSplit[0]) * 60 +
        double.parse(HHmmssSplit[1]) +
        double.parse(HHmmssSplit[2]) / 60;
  }
}
