import 'package:apfp/util/goals/goal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:apfp/util/goals/exercise_time_goal.dart';

void main() {
  group("Activity Duration String conversion tests", () {
    test('Convert an activity duration string (seconds) to a Duration object.',
        () {
      expect(Goal.convertToDuration("30 seconds").toString(), "0:00:30.000000");
    });
    test('Convert an activity duration string (minutes) to a Duration object.',
        () {
      expect(Goal.convertToDuration("4 minutes").toString(), "0:04:00.000000");
    });
    test('Convert an activity duration string (hours) to a Duration object.',
        () {
      expect(Goal.convertToDuration("2 hours").toString(), "2:00:00.000000");
    });
  });

  group('Goal progress sum conversion tests', () {
    test('Convert a Duration object (seconds) sum to minutes.', () {
      Duration d = Duration(seconds: 30);
      expect(Goal.toMinutes(d), 0.5);
    });
    test('Convert a Duration object (minutes) sum to minutes.', () {
      Duration d = Duration(minutes: 10);
      expect(Goal.toMinutes(d), 10);
    });
    test('Convert a Duration object (hours) sum to minutes.', () {
      Duration d = Duration(hours: 3);
      expect(Goal.toMinutes(d), 180);
    });
  });

  group('Total exercise time calculation tests', () {
    test('Calculate total minutes exercised from an activity snapshot (seconds).', () {
      var activitySnapShot = {
        DateTime.now().toIso8601String(): ["Cycling", "Aerobic", "30 seconds"]
      };
      expect(ExerciseGoal.totalTimeInMinutes(activitySnapShot), 0.5);
    });
    test('Calculate total minutes exercised from an activity snapshot (minutes).', () {
      var activitySnapShot = {
        DateTime.now().toIso8601String(): ["Cycling", "Aerobic", "35 minutes"]
      };
      expect(ExerciseGoal.totalTimeInMinutes(activitySnapShot), 35);
    });
    test('Calculate total minutes exercised from an activity snapshot (hours).', () {
      var activitySnapShot = {
        DateTime.now().toIso8601String(): ["Cycling", "Aerobic", "2 hours"]
      };
      expect(ExerciseGoal.totalTimeInMinutes(activitySnapShot), 120);
    });
  });
}
