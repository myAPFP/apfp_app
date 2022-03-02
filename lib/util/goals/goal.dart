import '../../firebase/firestore.dart';

class Goal {
  static int dayOfMonth = 0;

  static double userProgressExerciseTime = 0;
  static double userExerciseTimeEndGoal = 0;
  static double userExerciseTimeWeeklyEndGoal = 0;
  
  static double userProgressCalGoal = 0;
  static double userCalEndGoal = 0;

  static double userProgressStepGoal = 0;
  static double userStepEndGoal = 0;

  static double userProgressMileGoal = 0;
  static double userMileEndGoal = 0;

  static double userProgressCyclingGoal = 0;
  static double userCyclingEndGoal = 0;

  static double userProgressRowingGoal = 0;
  static double userRowingEndGoal = 0;

  static double userProgressStepMillGoal = 0;
  static double userStepMillEndGoal = 0;

  static bool isCalGoalSet = false;
  static bool isCalGoalComplete = false;

  static bool isStepGoalSet = false;
  static bool isStepGoalComplete = false;

  static bool isMileGoalSet = false;
  static bool isMileGoalComplete = false;

  static bool isCyclingGoalSet = false;
  static bool isCyclingGoalComplete = false;

  static bool isRowingGoalSet = false;
  static bool isRowingGoalComplete = false;

  static bool isStepMillGoalSet = false;
  static bool isStepMillGoalComplete = false;
  
  static bool isExerciseTimeGoalSet = false;
  static bool isExerciseTimeWeeklyGoalSet = false;

  static bool isExerciseTimeGoalComplete = false;
  static bool isExerciseTimeWeeklyGoalComplete = false;

  static bool isHealthTrackerPermissionGranted = false;

  static bool isDailyDisplayed = false;

  static Duration convertToDuration(String activityDurationStr) {
    Duration duration = Duration.zero;
    String value = activityDurationStr.split(' ')[0];
    String unitOfTime = activityDurationStr.split(' ')[1];
    switch (unitOfTime.toUpperCase()) {
      case 'SECONDS':
        duration = Duration(seconds: int.parse(value));
        break;
      case 'MINUTE':
      case 'MINUTES':
        duration = Duration(minutes: int.parse(value));
        break;
      case 'HOUR':
      case 'HOURS':
        duration = Duration(hours: int.parse(value));
        break;
    }
    return duration;
  }

  static void _calculateCompletedGoals() {
    isExerciseTimeGoalComplete = isExerciseTimeGoalSet &&
        (userProgressExerciseTime / userExerciseTimeEndGoal) * 100 >= 100;
    isExerciseTimeWeeklyGoalComplete = isExerciseTimeWeeklyGoalSet &&
        (userProgressExerciseTime / userExerciseTimeWeeklyEndGoal) * 100 >= 100;
    isCalGoalComplete =
        isCalGoalSet && (userProgressCalGoal / userCalEndGoal) * 100 >= 100;
    isStepGoalComplete =
        isStepGoalSet && (userProgressStepGoal / userStepEndGoal) * 100 >= 100;
    isMileGoalComplete =
        isMileGoalSet && (userProgressMileGoal / userMileEndGoal) * 100 >= 100;
    isCyclingGoalComplete = isCyclingGoalSet &&
        (userProgressCyclingGoal / userCyclingEndGoal) * 100 >= 100;
    isRowingGoalComplete = isRowingGoalSet &&
        (userProgressRowingGoal / userRowingEndGoal) * 100 >= 100;
    isStepMillGoalComplete = isStepMillGoalSet &&
        (userProgressStepMillGoal / userStepMillEndGoal) * 100 >= 100;
  }

  static void uploadCompletedGoals() {
    _calculateCompletedGoals();
    DateTime now = DateTime.now();
    DateTime yester = now.subtract(Duration(days: 1));
    // final weekFromNow = now.add(const Duration(days: 7));
    if (dayOfMonth != now.day) {
      if (isExerciseTimeGoalComplete) {
        FireStore.getGoalLogCollection(goalType: "daily").add({
          "Date": "${yester.month}/${yester.day}/${yester.year}",
          "Completed Goal": 'Exercise Time',
          "Info": "$userExerciseTimeEndGoal min exercised",
          "Type": "Daily Goal"
        });
      }
      if (isCalGoalComplete) {
        FireStore.getGoalLogCollection(goalType: "daily").add({
          "Date": "${yester.month}/${yester.day}/${yester.year}",
          "Completed Goal": 'Calories Burned',
          "Info": "$userCalEndGoal calories burned",
          "Type": "Daily Goal"
        });
      }
      if (isStepGoalComplete) {
        FireStore.getGoalLogCollection(goalType: "daily").add({
          "Date": "${yester.month}/${yester.day}/${yester.year}",
          "Completed Goal": 'Steps',
          "Info": "$userStepEndGoal steps taken",
          "Type": "Daily Goal"
        });
      }
      if (isMileGoalComplete) {
        FireStore.getGoalLogCollection(goalType: "daily").add({
          "Date": "${yester.month}/${yester.day}/${yester.year}",
          "Completed Goal": 'Miles',
          "Info": "$userMileEndGoal miles traveled",
          "Type": "Daily Goal"
        });
      }
      if (isCyclingGoalComplete) {
        FireStore.getGoalLogCollection(goalType: "daily").add({
          "Date": "${yester.month}/${yester.day}/${yester.year}",
          "Completed Goal": 'Cycling',
          "Info": "$userCyclingEndGoal min of cycling",
          "Type": "Daily Goal"
        });
      }
      if (isRowingGoalComplete) {
        FireStore.getGoalLogCollection(goalType: "daily").add({
          "Date": "${yester.month}/${yester.day}/${yester.year}",
          "Completed Goal": 'Rowing',
          "Info": "$userRowingEndGoal min of rowing",
          "Type": "Daily Goal"
        });
      }
      if (isStepMillGoalComplete) {
        FireStore.getGoalLogCollection(goalType: "daily").add({
          "Date": "${yester.month}/${yester.day}/${yester.year}",
          "Completed Goal": 'Step Mill',
          "Info": "$userStepMillEndGoal min of step mill use",
          "Type": "Daily Goal"
        });
      }
      // Resets Goals
      FireStore.resetHealthDoc(
          isHealthTrackerPermissionGranted, isDailyDisplayed);
    }
  }
}
