import 'package:apfp/service/notification_service.dart';
import '../../firebase/firestore.dart';

class Goal {
  static int dayOfMonth = 0;

  static bool isDailyDisplayed = false;

  static bool isHealthTrackerPermissionGranted = false;

  static String exerciseWeekDeadline = "0/00/0000";
  static String calWeekDeadline = "0/00/0000";
  static String stepWeekDeadline = "0/00/0000";
  static String mileWeekDeadline = "0/00/0000";
  static String cyclingWeekDeadline = "0/00/0000";
  static String rowingWeekDeadline = "0/00/0000";
  static String stepMillWeekDeadline = "0/00/0000";

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
    if (isExerciseTimeGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "daily").add({
        "Date": "${now.month}/${now.day}/${now.year}",
        "Completed Goal": 'Exercise Time',
        "Info": "$userExerciseTimeEndGoal min of activity",
        "Type": "Daily Goal"
      });
      FireStore.updateHealthData(
          {"exerciseTimeEndGoal": 0.0, "isExerciseTimeGoalSet": false});
      NotificationService.showGoalNotification("Daily Goal Completed!",
          "Exercise Time - $userExerciseTimeEndGoal min of activity");
    }
    if (isCyclingGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "daily").add({
        "Date": "${now.month}/${now.day}/${now.year}",
        "Completed Goal": 'Cycling',
        "Info": "$userCyclingEndGoal min of activity",
        "Type": "Daily Goal"
      });
      FireStore.updateHealthData({
        "cyclingGoalProgress": 0,
        "cyclingEndGoal": 0,
        "isCyclingGoalSet": false,
      });
      NotificationService.showGoalNotification("Daily Goal Completed!",
          "Cycling - $userCyclingEndGoal min of activity");
    }
    if (isRowingGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "daily").add({
        "Date": "${now.month}/${now.day}/${now.year}",
        "Completed Goal": 'Rowing',
        "Info": "$userRowingEndGoal min of activity",
        "Type": "Daily Goal"
      });
      FireStore.updateHealthData({
        "rowingGoalProgress": 0,
        "rowingEndGoal": 0,
        "isRowingGoalSet": false,
      });
      NotificationService.showGoalNotification("Daily Goal Completed!",
          "Rowing - $userRowingEndGoal min of activity");
    }
    if (isStepMillGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "daily").add({
        "Date": "${now.month}/${now.day}/${now.year}",
        "Completed Goal": 'Step Mill',
        "Info": "$userStepMillEndGoal min of activity",
        "Type": "Daily Goal"
      });
      FireStore.updateHealthData({
        "stepMillGoalProgress": 0,
        "stepMillEndGoal": 0,
        "isStepMillGoalSet": false,
      });
      NotificationService.showGoalNotification("Daily Goal Completed!",
          "Step Mill - $userStepMillEndGoal min of activity");
    }

    // if (isCalGoalComplete) {
    //   FireStore.getGoalLogCollection(goalType: "daily").add({
    //     "Date": "${now.month}/${now.day}/${now.year}",
    //     "Completed Goal": 'Calories Burned',
    //     "Info": "$userCalEndGoal calories burned",
    //     "Type": "Daily Goal"
    //   });
    // }

    // if (isStepGoalComplete) {
    //   FireStore.getGoalLogCollection(goalType: "daily").add({
    //     "Date": "${now.month}/${now.day}/${now.year}",
    //     "Completed Goal": 'Steps',
    //     "Info": "$userStepEndGoal steps taken",
    //     "Type": "Daily Goal"
    //   });
    // }
    // if (isMileGoalComplete) {
    //   FireStore.getGoalLogCollection(goalType: "daily").add({
    //     "Date": "${now.month}/${now.day}/${now.year}",
    //     "Completed Goal": 'Miles',
    //     "Info": "$userMileEndGoal miles traveled",
    //     "Type": "Daily Goal"
    //   });
    // }
  }

  static void _uploadCompletedWeeklyGoals() {
    DateTime now = DateTime.now();
    if (isExerciseTimeWeeklyGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "weekly").add({
        "Date": "${now.month}/${now.day}/${now.year}",
        "Completed Goal": 'Exercise Time',
        "Info": "$userExerciseTimeWeeklyEndGoal min of activity",
        "Type": "Weekly Goal"
      });
      FireStore.updateHealthData({
        "exerciseTimeGoalProgressWeekly": 0.0,
        "exerciseTimeEndGoal_w": 0.0,
        "isExerciseTimeGoalSet_w": false
      });
      NotificationService.showGoalNotification("Weekly Goal Completed!",
          "Exercise Time - $userExerciseTimeWeeklyEndGoal min of activity",
          id: 1, type: "Weekly");
    }
    if (isCyclingWeeklyGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "weekly").add({
        "Date": "${now.month}/${now.day}/${now.year}",
        "Completed Goal": 'Cycling',
        "Info": "$userCyclingWeeklyEndGoal min of activity",
        "Type": "Weekly Goal"
      });
      FireStore.updateHealthData({
        "cyclingWeekDeadline": "0/00/0000",
        "cyclingGoalProgressWeekly": 0,
        "cyclingEndGoal_w": 0,
        "isCyclingGoalSet_w": false,
      });
      NotificationService.showGoalNotification("Weekly Goal Completed!",
          "Cycling - $userCyclingWeeklyEndGoal min of activity",
          id: 1, type: "Weekly");
    }
    if (isRowingWeeklyGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "weekly").add({
        "Date": "${now.month}/${now.day}/${now.year}",
        "Completed Goal": 'Rowing',
        "Info": "$userRowingWeeklyEndGoal min of activity",
        "Type": "Weekly Goal"
      });
      FireStore.updateHealthData({
        "rowingWeekDeadline": "0/00/0000",
        "rowingGoalProgressWeekly": 0,
        "rowingEndGoal_w": 0,
        "isRowingGoalSet_w": false,
      });
      NotificationService.showGoalNotification("Weekly Goal Completed!",
          "Rowing - $userRowingWeeklyEndGoal min of activity",
          id: 1, type: "Weekly");
    }
    if (isStepMillWeeklyGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "weekly").add({
        "Date": "${now.month}/${now.day}/${now.year}",
        "Completed Goal": 'Step Mill',
        "Info": "$userStepMillWeeklyEndGoal min of activity",
        "Type": "Weekly Goal"
      });
      FireStore.updateHealthData({
        "stepMillWeekDeadline": "0/00/0000",
        "stepMillGoalProgressWeekly": 0,
        "stepMillEndGoal_w": 0,
        "isStepMillGoalSet_w": false,
      });
      NotificationService.showGoalNotification("Weekly Goal Completed!",
          "Step Mill - $userStepMillWeeklyEndGoal min of activity",
          id: 1, type: "Weekly");
    }
  }

  static void uploadCompletedGoals() {
    _calculateCompletedGoals();
    _uploadCompletedDailyGoals();
    _uploadCompletedWeeklyGoals();
    final now = DateTime.now();
    if (dayOfMonth != now.day) {
      FireStore.updateHealthData({"dayOfMonth": now.day});
    }
    if (exerciseWeekDeadline == "${now.month}/${now.day}/${now.year}") {
      FireStore.updateHealthData({
        "exerciseWeekDeadline": "0/00/0000",
        "exerciseTimeGoalProgressWeekly": 0,
        "exerciseTimeEndGoal_w": 0,
        "isExerciseTimeGoalSet_w": false,
      });
    }
    if (cyclingWeekDeadline == "${now.month}/${now.day}/${now.year}") {
      FireStore.updateHealthData({
        "cyclingWeekDeadline": "0/00/0000",
        "cyclingGoalProgressWeekly": 0,
        "cyclingEndGoal_w": 0,
        "isCyclingGoalSet_w": false,
      });
    }
    if (rowingWeekDeadline == "${now.month}/${now.day}/${now.year}") {
      FireStore.updateHealthData({
        "rowingWeekDeadline": "0/00/0000",
        "rowingGoalProgressWeekly": 0,
        "rowingEndGoal_w": 0,
        "isRowingGoalSet_w": false,
      });
    }
    if (stepMillWeekDeadline == "${now.month}/${now.day}/${now.year}") {
      FireStore.updateHealthData({
        "stepMillWeekDeadline": "0/00/0000",
        "stepMillGoalProgressWeekly": 0,
        "stepMillEndGoal_w": 0,
        "isStepMillGoalSet_w": false,
      });
    }
  }
}