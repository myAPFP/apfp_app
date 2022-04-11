import 'goal.dart';

class ExerciseGoal {

  /// Loops through each activity in [activitySnapshot] and calculates the 
  /// total amount of exercise minutes. 
  /// 
  /// Returns the minute count as a double.
  static double totalTimeInMinutes(Map activitySnapshot) {
    Duration sum = Duration.zero;
    activitySnapshot.forEach((key, value) {
      sum += Goal.convertToDuration(value[2]);
    });
    return Goal.toMinutes(sum);
  }
}
