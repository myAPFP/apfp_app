import 'package:apfp/service/notification_service.dart';
import '../../firebase/firestore.dart';

class Goal {
  static final _now = DateTime.now();

  static int dayOfMonth = 0;

  static bool isDailyGoalsDisplayed = false;

  static bool isHealthAppSynced = false;

  static String exerciseWeekDeadline = "0/00/0000";
  static String calWeekDeadline = "0/00/0000";
  static String stepWeekDeadline = "0/00/0000";
  static String mileWeekDeadline = "0/00/0000";
  static String cyclingWeekDeadline = "0/00/0000";
  static String rowingWeekDeadline = "0/00/0000";
  static String stepMillWeekDeadline = "0/00/0000";
  static String ellipticalWeekDeadline = "0/00/0000";
  static String resistanceStrengthWeekDeadline = "0/00/0000";

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

  static double userProgressEllipticalGoal = 0;
  static double userProgressEllipticalGoalWeekly = 0;
  static double userEllipticalEndGoal = 0;
  static double userEllipticalWeeklyEndGoal = 0;
  static bool isEllipticalGoalSet = false;
  static bool isEllipticalWeeklyGoalSet = false;
  static bool isEllipticalGoalComplete = false;
  static bool isEllipticalWeeklyGoalComplete = false;

  static double userProgressResistanceStrengthGoal = 0;
  static double userProgressResistanceStrengthGoalWeekly = 0;
  static double userResistanceStrengthEndGoal = 0;
  static double userResistanceStrengthWeeklyEndGoal = 0;
  static bool isResistanceStrengthGoalSet = false;
  static bool isResistanceStrengthWeeklyGoalSet = false;
  static bool isResistanceStrengthGoalComplete = false;
  static bool isResistanceStrengthWeeklyGoalComplete = false;

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

  static double toMinutes(Duration goalSum) {
    String hhmmss = goalSum.toString().split('.').first.padLeft(8, "0");
    List<String> hhmmssSplit = hhmmss.split(':');
    return double.parse(hhmmssSplit[0]) * 60 +
        double.parse(hhmmssSplit[1]) +
        double.parse(hhmmssSplit[2]) / 60;
  }

  static double totalExerciseTimeInMinutes(Map activitySnapshot) {
    Duration sum = Duration.zero;
    activitySnapshot.forEach((key, value) {
      sum += convertToDuration(value[2]);
    });
    return toMinutes(sum);
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

    isCalWeeklyGoalComplete = isCalWeeklyGoalSet &&
        (userProgressCalGoalWeekly / userCalWeeklyEndGoal) * 100 >= 100;

    isStepGoalComplete =
        isStepGoalSet && (userProgressStepGoal / userStepEndGoal) * 100 >= 100;

    isStepWeeklyGoalComplete = isStepWeeklyGoalSet &&
        (userProgressStepGoalWeekly / userStepWeeklyEndGoal) * 100 >= 100;

    isMileGoalComplete =
        isMileGoalSet && (userProgressMileGoal / userMileEndGoal) * 100 >= 100;

    isMileWeeklyGoalComplete = isMileWeeklyGoalSet &&
        (userProgressMileGoalWeekly / userMileWeeklyEndGoal) * 100 >= 100;

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

    isEllipticalGoalComplete = isEllipticalGoalSet &&
        (userProgressEllipticalGoal / userEllipticalEndGoal) * 100 >= 100;

    isEllipticalWeeklyGoalComplete = isEllipticalWeeklyGoalSet &&
        (userProgressEllipticalGoalWeekly / userEllipticalWeeklyEndGoal) *
                100 >=
            100;

    isResistanceStrengthGoalComplete = isResistanceStrengthGoalSet &&
        (userProgressResistanceStrengthGoal / userResistanceStrengthEndGoal) *
                100 >=
            100;

    isResistanceStrengthWeeklyGoalComplete =
        isResistanceStrengthWeeklyGoalSet &&
            (userProgressResistanceStrengthGoalWeekly /
                        userResistanceStrengthWeeklyEndGoal) *
                    100 >=
                100;
  }

  static void _uploadCompletedDailyGoals() {
    if (isExerciseTimeGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "daily").add({
        "Date": "${_now.month}/${_now.day}/${_now.year}",
        "Completed Goal": 'Exercise Time',
        "Info": "$userExerciseTimeEndGoal min of activity",
        "Type": "Daily Goal"
      });
      FireStore.updateGoalData(
          {"exerciseTimeEndGoal": 0.0, "isExerciseTimeGoalSet": false});
      NotificationService.showGoalNotification("Daily Goal Completed!",
          "Exercise Time - $userExerciseTimeEndGoal min of activity");
    }
    if (isCyclingGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "daily").add({
        "Date": "${_now.month}/${_now.day}/${_now.year}",
        "Completed Goal": 'Cycling',
        "Info": "$userCyclingEndGoal min of activity",
        "Type": "Daily Goal"
      });
      FireStore.updateGoalData({
        "cyclingGoalProgress": 0,
        "cyclingEndGoal": 0,
        "isCyclingGoalSet": false,
      });
      NotificationService.showGoalNotification("Daily Goal Completed!",
          "Cycling - $userCyclingEndGoal min of activity");
    }
    if (isRowingGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "daily").add({
        "Date": "${_now.month}/${_now.day}/${_now.year}",
        "Completed Goal": 'Rowing',
        "Info": "$userRowingEndGoal min of activity",
        "Type": "Daily Goal"
      });
      FireStore.updateGoalData({
        "rowingGoalProgress": 0,
        "rowingEndGoal": 0,
        "isRowingGoalSet": false,
      });
      NotificationService.showGoalNotification("Daily Goal Completed!",
          "Rowing - $userRowingEndGoal min of activity");
    }
    if (isStepMillGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "daily").add({
        "Date": "${_now.month}/${_now.day}/${_now.year}",
        "Completed Goal": 'Step Mill',
        "Info": "$userStepMillEndGoal min of activity",
        "Type": "Daily Goal"
      });
      FireStore.updateGoalData({
        "stepMillGoalProgress": 0,
        "stepMillEndGoal": 0,
        "isStepMillGoalSet": false,
      });
      NotificationService.showGoalNotification("Daily Goal Completed!",
          "Step Mill - $userStepMillEndGoal min of activity");
    }
    if (isCalGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "daily").add({
        "Date": "${_now.month}/${_now.day}/${_now.year}",
        "Completed Goal": 'Calories Burned',
        "Info": "$userCalEndGoal calories burned",
        "Type": "Daily Goal"
      });
      FireStore.updateGoalData({
        "calGoalProgress": 0,
        "calEndGoal": 0,
        "isCalGoalSet": false,
      });
      NotificationService.showGoalNotification(
          "Daily Goal Completed!", "Calories - $userCalEndGoal cals burned");
    }
    if (isStepGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "daily").add({
        "Date": "${_now.month}/${_now.day}/${_now.year}",
        "Completed Goal": 'Steps',
        "Info": "$userStepEndGoal steps taken",
        "Type": "Daily Goal"
      });
      FireStore.updateGoalData({
        "stepGoalProgress": 0,
        "stepEndGoal": 0,
        "isStepGoalSet": false,
      });
      NotificationService.showGoalNotification(
          "Daily Goal Completed!", "Steps - $userStepEndGoal steps taken");
    }
    if (isMileGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "daily").add({
        "Date": "${_now.month}/${_now.day}/${_now.year}",
        "Completed Goal": 'Miles',
        "Info": "$userMileEndGoal miles traveled",
        "Type": "Daily Goal"
      });
      FireStore.updateGoalData({
        "mileGoalProgress": 0,
        "mileEndGoal": 0,
        "isMileGoalSet": false,
      });
      NotificationService.showGoalNotification(
          "Daily Goal Completed!", "Miles - $userMileEndGoal miles traveled");
    }
    if (isEllipticalGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "daily").add({
        "Date": "${_now.month}/${_now.day}/${_now.year}",
        "Completed Goal": 'Elliptical',
        "Info": "$userEllipticalEndGoal min of activity",
        "Type": "Daily Goal"
      });
      FireStore.updateGoalData({
        "ellipticalGoalProgress": 0,
        "ellipticalEndGoal": 0,
        "isEllipticalGoalSet": false,
      });
      NotificationService.showGoalNotification("Daily Goal Completed!",
          "Elliptical - $userEllipticalEndGoal min of activity");
    }
    if (isResistanceStrengthGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "daily").add({
        "Date": "${_now.month}/${_now.day}/${_now.year}",
        "Completed Goal": 'Resistance-Strength',
        "Info": "$userResistanceStrengthEndGoal min of activity",
        "Type": "Daily Goal"
      });
      FireStore.updateGoalData({
        "resistanceStrengthGoalProgress": 0,
        "resistanceStrengthEndGoal": 0,
        "isResistanceStrengthGoalSet": false,
      });
      NotificationService.showGoalNotification("Daily Goal Completed!",
          "Resistance-Strength - $userResistanceStrengthEndGoal min of activity");
    }
  }

  static void _uploadCompletedWeeklyGoals() {
    if (isExerciseTimeWeeklyGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "weekly").add({
        "Date": "${_now.month}/${_now.day}/${_now.year}",
        "Completed Goal": 'Exercise Time',
        "Info": "$userExerciseTimeWeeklyEndGoal min of activity",
        "Type": "Weekly Goal"
      });
      FireStore.updateGoalData({
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
        "Date": "${_now.month}/${_now.day}/${_now.year}",
        "Completed Goal": 'Cycling',
        "Info": "$userCyclingWeeklyEndGoal min of activity",
        "Type": "Weekly Goal"
      });
      FireStore.updateGoalData({
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
        "Date": "${_now.month}/${_now.day}/${_now.year}",
        "Completed Goal": 'Rowing',
        "Info": "$userRowingWeeklyEndGoal min of activity",
        "Type": "Weekly Goal"
      });
      FireStore.updateGoalData({
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
        "Date": "${_now.month}/${_now.day}/${_now.year}",
        "Completed Goal": 'Step Mill',
        "Info": "$userStepMillWeeklyEndGoal min of activity",
        "Type": "Weekly Goal"
      });
      FireStore.updateGoalData({
        "stepMillWeekDeadline": "0/00/0000",
        "stepMillGoalProgressWeekly": 0,
        "stepMillEndGoal_w": 0,
        "isStepMillGoalSet_w": false,
      });
      NotificationService.showGoalNotification("Weekly Goal Completed!",
          "Step Mill - $userStepMillWeeklyEndGoal min of activity",
          id: 1, type: "Weekly");
    }
    if (isCalWeeklyGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "weekly").add({
        "Date": "${_now.month}/${_now.day}/${_now.year}",
        "Completed Goal": 'Calories',
        "Info": "$userCalWeeklyEndGoal cals burned",
        "Type": "Weekly Goal"
      });
      FireStore.updateGoalData({
        "calWeekDeadline": "0/00/0000",
        "calGoalProgressWeekly": 0,
        "calEndGoal_w": 0,
        "isCalGoalSet_w": false,
      });
      NotificationService.showGoalNotification("Weekly Goal Completed!",
          "Calories - $userCalWeeklyEndGoal cals burned",
          id: 1, type: "Weekly");
    }
    if (isStepWeeklyGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "weekly").add({
        "Date": "${_now.month}/${_now.day}/${_now.year}",
        "Completed Goal": 'Steps',
        "Info": "$userStepWeeklyEndGoal steps taken",
        "Type": "Weekly Goal"
      });
      FireStore.updateGoalData({
        "stepWeekDeadline": "0/00/0000",
        "stepGoalProgressWeekly": 0,
        "stepEndGoal_w": 0,
        "isStepGoalSet_w": false,
      });
      NotificationService.showGoalNotification("Weekly Goal Completed!",
          "Steps - $userStepWeeklyEndGoal steps taken",
          id: 1, type: "Weekly");
    }
    if (isMileWeeklyGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "weekly").add({
        "Date": "${_now.month}/${_now.day}/${_now.year}",
        "Completed Goal": 'Miles',
        "Info": "$userMileWeeklyEndGoal miles traveled",
        "Type": "Weekly Goal"
      });
      FireStore.updateGoalData({
        "mileWeekDeadline": "0/00/0000",
        "mileGoalProgressWeekly": 0,
        "mileEndGoal_w": 0,
        "isMileGoalSet_w": false,
      });
      NotificationService.showGoalNotification("Weekly Goal Completed!",
          "Miles - $userMileWeeklyEndGoal miles traveled",
          id: 1, type: "Weekly");
    }
    if (isEllipticalWeeklyGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "weekly").add({
        "Date": "${_now.month}/${_now.day}/${_now.year}",
        "Completed Goal": 'Elliptical',
        "Info": "$userEllipticalWeeklyEndGoal min of activity",
        "Type": "Weekly Goal"
      });
      FireStore.updateGoalData({
        "ellipticalWeekDeadline": "0/00/0000",
        "ellipticalGoalProgressWeekly": 0,
        "ellipticalEndGoal_w": 0,
        "isEllipticalGoalSet_w": false,
      });
      NotificationService.showGoalNotification("Weekly Goal Completed!",
          "Elliptical - $userEllipticalWeeklyEndGoal min of activity",
          id: 1, type: "Weekly");
    }
    if (isResistanceStrengthWeeklyGoalComplete) {
      FireStore.getGoalLogCollection(goalType: "weekly").add({
        "Date": "${_now.month}/${_now.day}/${_now.year}",
        "Completed Goal": 'Resistance-Strength',
        "Info": "$userResistanceStrengthWeeklyEndGoal min of activity",
        "Type": "Weekly Goal"
      });
      FireStore.updateGoalData({
        "resistanceStrengthWeekDeadline": "0/00/0000",
        "resistanceStrengthGoalProgressWeekly": 0,
        "resistanceStrengthEndGoal_w": 0,
        "isResistanceStrengthGoalSet_w": false,
      });
      NotificationService.showGoalNotification("Weekly Goal Completed!",
          "Resistance-Strength - $userResistanceStrengthWeeklyEndGoal min of activity",
          id: 1, type: "Weekly");
    }
  }

  static void _checkWeeklyGoalDeadLines() {
    if (exerciseWeekDeadline == "${_now.month}/${_now.day}/${_now.year}") {
      FireStore.updateGoalData({
        "exerciseWeekDeadline": "0/00/0000",
        "exerciseTimeGoalProgressWeekly": 0,
        "exerciseTimeEndGoal_w": 0,
        "isExerciseTimeGoalSet_w": false,
      });
    }
    if (cyclingWeekDeadline == "${_now.month}/${_now.day}/${_now.year}") {
      FireStore.updateGoalData({
        "cyclingWeekDeadline": "0/00/0000",
        "cyclingGoalProgressWeekly": 0,
        "cyclingEndGoal_w": 0,
        "isCyclingGoalSet_w": false,
      });
    }
    if (rowingWeekDeadline == "${_now.month}/${_now.day}/${_now.year}") {
      FireStore.updateGoalData({
        "rowingWeekDeadline": "0/00/0000",
        "rowingGoalProgressWeekly": 0,
        "rowingEndGoal_w": 0,
        "isRowingGoalSet_w": false,
      });
    }
    if (stepMillWeekDeadline == "${_now.month}/${_now.day}/${_now.year}") {
      FireStore.updateGoalData({
        "stepMillWeekDeadline": "0/00/0000",
        "stepMillGoalProgressWeekly": 0,
        "stepMillEndGoal_w": 0,
        "isStepMillGoalSet_w": false,
      });
    }
    if (calWeekDeadline == "${_now.month}/${_now.day}/${_now.year}") {
      FireStore.updateGoalData({
        "calWeekDeadline": "0/00/0000",
        "calGoalProgressWeekly": 0,
        "calEndGoal_w": 0,
        "isCalGoalSet_w": false,
      });
    }
    if (mileWeekDeadline == "${_now.month}/${_now.day}/${_now.year}") {
      FireStore.updateGoalData({
        "mileWeekDeadline": "0/00/0000",
        "mileGoalProgressWeekly": 0,
        "mileEndGoal_w": 0,
        "isMileGoalSet_w": false,
      });
    }
    if (stepWeekDeadline == "${_now.month}/${_now.day}/${_now.year}") {
      FireStore.updateGoalData({
        "stepWeekDeadline": "0/00/0000",
        "stepGoalProgressWeekly": 0,
        "stepEndGoal_w": 0,
        "isStepGoalSet_w": false,
      });
    }
    if (ellipticalWeekDeadline == "${_now.month}/${_now.day}/${_now.year}") {
      FireStore.updateGoalData({
        "ellipticalWeekDeadline": "0/00/0000",
        "ellipticalGoalProgressWeekly": 0,
        "ellipticalEndGoal_w": 0,
        "isEllipticalGoalSet_w": false,
      });
    }
    if (resistanceStrengthWeekDeadline ==
        "${_now.month}/${_now.day}/${_now.year}") {
      FireStore.updateGoalData({
        "resistanceStrengthWeekDeadline": "0/00/0000",
        "resistanceStrengthGoalProgressWeekly": 0,
        "resistanceStrengthEndGoal_w": 0,
        "isResistanceStrengthGoalSet_w": false,
      });
    }
  }

  static void _updateDayOfMonth() {
    if (dayOfMonth != _now.day) {
      FireStore.updateGoalData({"dayOfMonth": _now.day});
    }
  }

  static void uploadCompletedGoals() {
    _calculateCompletedGoals();
    _uploadCompletedDailyGoals();
    _uploadCompletedWeeklyGoals();
    _checkWeeklyGoalDeadLines();
    _updateDayOfMonth();
  }
}
