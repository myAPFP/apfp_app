import '../../firebase/firestore.dart';

class Goal {
  static int dayOfMonth = 0;

  static bool isDailyDisplayed = false;

  static bool isHealthTrackerPermissionGranted = false;

  static double userProgressExerciseTime = 0;
  static double userProgressExerciseTimeWeekly = 0;
  static double userExerciseTimeEndGoal = 0;
  static double userExerciseTimeWeeklyEndGoal = 0;
  static bool isExerciseTimeGoalSet = false;
  static bool isExerciseTimeWeeklyGoalSet = false;
  static bool isExerciseTimeGoalComplete = false;
  static bool isExerciseTimeWeeklyGoalComplete = false;

  static double userProgressCalGoal = 0;
  static double userProgressCalGoalWeekly = 0;
  static double userCalEndGoal = 0;
  static double userCalWeeklyEndGoal = 0;
  static bool isCalGoalSet = false;
  static bool isCalWeeklyGoalSet = false;
  static bool isCalGoalComplete = false;
  static bool isCalWeeklyGoalComplete = false;

  static double userProgressStepGoal = 0;
  static double userProgressStepGoalWeekly = 0;
  static double userStepEndGoal = 0;
  static double userStepWeeklyEndGoal = 0;
  static bool isStepGoalSet = false;
  static bool isStepWeeklyGoalSet = false;
  static bool isStepGoalComplete = false;
  static bool isStepWeeklyGoalComplete = false;

  static double userProgressMileGoal = 0;
  static double userProgressMileGoalWeekly = 0;
  static double userMileEndGoal = 0;
  static double userMileWeeklyEndGoal = 0;
  static bool isMileGoalSet = false;
  static bool isMileWeeklyGoalSet = false;
  static bool isMileGoalComplete = false;
  static bool isMileWeeklyGoalComplete = false;

  static double userProgressCyclingGoal = 0;
  static double userProgressCyclingGoalWeekly = 0;
  static double userCyclingEndGoal = 0;
  static double userCyclingWeeklyEndGoal = 0;
  static bool isCyclingGoalSet = false;
  static bool isCyclingWeeklyGoalSet = false;
  static bool isCyclingGoalComplete = false;
  static bool isCyclingWeeklyGoalComplete = false;

  static double userProgressRowingGoal = 0;
  static double userProgressRowingGoalWeekly = 0;
  static double userRowingEndGoal = 0;
  static double userRowingWeeklyEndGoal = 0;
  static bool isRowingGoalSet = false;
  static bool isRowingWeeklyGoalSet = false;
  static bool isRowingGoalComplete = false;
  static bool isRowingWeeklyGoalComplete = false;

  static double userProgressStepMillGoal = 0;
  static double userProgressStepMillGoalWeekly = 0;
  static double userStepMillEndGoal = 0;
  static double userStepMillWeeklyEndGoal = 0;
  static bool isStepMillGoalSet = false;
  static bool isStepMillWeeklyGoalSet = false;
  static bool isStepMillGoalComplete = false;
  static bool isStepMillWeeklyGoalComplete = false;

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
        (userProgressExerciseTimeWeekly / userExerciseTimeWeeklyEndGoal) *
                100 >=
            100;

    isCalGoalComplete =
        isCalGoalSet && (userProgressCalGoal / userCalEndGoal) * 100 >= 100;

    isStepGoalComplete =
        isStepGoalSet && (userProgressStepGoal / userStepEndGoal) * 100 >= 100;

    isMileGoalComplete =
        isMileGoalSet && (userProgressMileGoal / userMileEndGoal) * 100 >= 100;

    isCyclingGoalComplete = isCyclingGoalSet &&
        (userProgressCyclingGoal / userCyclingEndGoal) * 100 >= 100;

    isCyclingWeeklyGoalComplete = isCyclingWeeklyGoalSet &&
        (userProgressCyclingGoalWeekly / userCyclingWeeklyEndGoal) * 100 >= 100;

    isRowingGoalComplete = isRowingGoalSet &&
        (userProgressRowingGoal / userRowingEndGoal) * 100 >= 100;

    isRowingWeeklyGoalComplete = isRowingWeeklyGoalSet &&
        (userProgressRowingGoalWeekly / userRowingWeeklyEndGoal) * 100 >= 100;

    isStepMillGoalComplete = isStepMillGoalSet &&
        (userProgressStepMillGoal / userStepMillEndGoal) * 100 >= 100;

    isStepMillWeeklyGoalComplete = isStepMillWeeklyGoalSet &&
        (userProgressStepMillGoalWeekly / userStepMillWeeklyEndGoal) * 100 >=
            100;
  }

  static void _uploadCompletedDailyGoals() {
    DateTime now = DateTime.now();
    DateTime yester = now.subtract(Duration(days: 1));
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
    // ! Add code to preserve weekly progress
    FireStore.resetHealthDoc(
        isHealthTrackerPermissionGranted, isDailyDisplayed);
  }

  static void _uploadCompletedWeeklyGoals() {
    DateTime now = DateTime.now();
    DateTime yester = now.subtract(Duration(days: 1));
    if (isExerciseTimeWeeklyGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "weekly").add({
        "Date": "${yester.month}/${yester.day}/${yester.year}",
        "Completed Goal": 'Exercise Time',
        "Info": "$userExerciseTimeEndGoal min exercised",
        "Type": "Weekly Goal"
      });
    }
    if (isCyclingWeeklyGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "weekly").add({
        "Date": "${yester.month}/${yester.day}/${yester.year}",
        "Completed Goal": 'Cycling',
        "Info": "$userCyclingWeeklyEndGoal min of cycling",
        "Type": "Weekly Goal"
      });
    }
    if (isRowingWeeklyGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "weekly").add({
        "Date": "${yester.month}/${yester.day}/${yester.year}",
        "Completed Goal": 'Rowing',
        "Info": "$userRowingWeeklyEndGoal min of rowing",
        "Type": "Weekly Goal"
      });
    }
    if (isStepMillWeeklyGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "weekly").add({
        "Date": "${yester.month}/${yester.day}/${yester.year}",
        "Completed Goal": 'Step Mill',
        "Info": "$userStepMillWeeklyEndGoal min of step mill use",
        "Type": "Weekly Goal"
      });
    }
    // Resets Goals
    FireStore.resetHealthDoc(
        isHealthTrackerPermissionGranted, isDailyDisplayed);
  }

  static void uploadCompletedGoals() {
    _calculateCompletedGoals();
    final now = DateTime.now();
    final weekFromNow = now.add(const Duration(days: 7));
    if (dayOfMonth != now.day) {
      _uploadCompletedDailyGoals();
    }
    if (now == weekFromNow) {
      _uploadCompletedWeeklyGoals();
    }
  }
}
