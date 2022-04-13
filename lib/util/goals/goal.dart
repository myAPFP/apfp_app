// Copyright 2022 The myAPFP Authors. All rights reserved.

import '/firebase/firestore.dart';
import '/service/notification_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Goal {
  /// Stores a [DateTime] instance with current date and time in the local time zone.
  static final _now = DateTime.now();

  /// Stores current day number.
  ///
  /// Example:
  /// - Date: 3/23/2022
  /// - dayOfMonth = 23
  static int dayOfMonth = 0;

  /// Indicates if the user is displaying daily goals in Home.
  ///
  /// If this is false, weekly goals are being displayed.
  static bool isDailyGoalsDisplayed = false;

  /// Indicates if the user has synchronized a health app to myAPFP
  static bool isHealthAppSynced = false;

  /// Serves as a goal deadline. When a user sets a weekly exercise goal,
  /// this is updated to the week from the current date.
  ///
  /// When a user resets the weekly goal, this becomes its initial value.
  ///
  /// Example:
  /// - "0/00/0000" -> "3/23/2022"
  static String exerciseWeekDeadline = "0/00/0000";

  /// Serves as a goal deadline. When a user sets a weekly calories goal,
  /// this is updated to the week from the current date.
  ///
  /// When a user resets the weekly goal, this becomes its initial value.
  ///
  /// Example:
  /// - "0/00/0000" -> "3/23/2022"
  static String calWeekDeadline = "0/00/0000";

  /// Serves as a goal deadline. When a user sets a weekly steps goal,
  /// this is updated to the week from the current date.
  ///
  /// When a user resets the weekly goal, this becomes its initial value.
  ///
  /// Example:
  /// - "0/00/0000" -> "3/23/2022"
  static String stepWeekDeadline = "0/00/0000";

  /// Serves as a goal deadline. When a user sets a weekly miles goal,
  /// this is updated to the week from the current date.
  ///
  /// When a user resets the weekly goal, this becomes its initial value.
  ///
  /// Example:
  /// - "0/00/0000" -> "3/23/2022"
  static String mileWeekDeadline = "0/00/0000";

  /// Serves as a goal deadline. When a user sets a weekly cycling goal,
  /// this is updated to the week from the current date.
  ///
  /// When a user resets the weekly goal, this becomes its initial value.
  ///
  /// Example:
  /// - "0/00/0000" -> "3/23/2022"
  static String cyclingWeekDeadline = "0/00/0000";

  /// Serves as a goal deadline. When a user sets a weekly rowing goal,
  /// this is updated to the week from the current date.
  ///
  /// When a user resets the weekly goal, this becomes its initial value.
  ///
  /// Example:
  /// - "0/00/0000" -> "3/23/2022"
  static String rowingWeekDeadline = "0/00/0000";

  /// Serves as a goal deadline. When a user sets a weekly step mill goal,
  /// this is updated to the week from the current date.
  ///
  /// When a user resets the weekly goal, this becomes its initial value.
  ///
  /// Example:
  /// - "0/00/0000" -> "3/23/2022"
  static String stepMillWeekDeadline = "0/00/0000";

  /// Serves as a goal deadline. When a user sets a weekly elliptical goal,
  /// this is updated to the week from the current date.
  ///
  /// When a user resets the weekly goal, this becomes its initial value.
  ///
  /// Example:
  /// - "0/00/0000" -> "3/23/2022"
  static String ellipticalWeekDeadline = "0/00/0000";

  /// Serves as a goal deadline. When a user sets a weekly resistance/strength goal,
  /// this is updated to the week from the current date.
  ///
  /// When a user resets the weekly goal, this becomes its initial value.
  ///
  /// Example:
  /// - "0/00/0000" -> "3/23/2022"
  static String resistanceStrengthWeekDeadline = "0/00/0000";

  /// Stores a user's current daily goal progess for exercise time.
  static double userProgressExerciseTime = 0;

  /// Stores a user's current weekly goal progess for exercise time.
  static double userProgressExerciseTimeWeekly = 0;

  /// Stores a user's current daily end goal for exercise time.
  static double userExerciseTimeEndGoal = 0;

  /// Stores a user's current weekly end goal for exercise time.
  static double userExerciseTimeWeeklyEndGoal = 0;

  /// Indicates if the user has set an exercise time daily goal.
  static bool isExerciseTimeGoalSet = false;

  /// Indicates if the user has set an exercise time weekly goal.
  static bool isExerciseTimeWeeklyGoalSet = false;

  /// Indicates if the user has completed their daily exercise time goal.
  static bool isExerciseTimeGoalComplete = false;

  /// Indicates if the user has completed their weekly exercise time goal.
  static bool isExerciseTimeWeeklyGoalComplete = false;

  /// Stores a user's current daily goal progess for calories burned.
  static double userProgressCalGoal = 0;

  /// Stores a user's current weekly goal progess for calories burned.
  static double userProgressCalGoalWeekly = 0;

  /// Stores a user's current daily end goal for calories burned.
  static double userCalEndGoal = 0;

  /// Stores a user's current weekly end goal for calories burned.
  static double userCalWeeklyEndGoal = 0;

  /// Indicates if the user has set a calories daily goal.
  static bool isCalGoalSet = false;

  /// Indicates if the user has set a calories weekly goal.
  static bool isCalWeeklyGoalSet = false;

  /// Indicates if the user has completed their daily calories goal.
  static bool isCalGoalComplete = false;

  /// Indicates if the user has completed their weekly calories goal.
  static bool isCalWeeklyGoalComplete = false;

  /// Stores a user's current daily goal progess for steps taken.
  static double userProgressStepGoal = 0;

  /// Stores a user's current weekly goal progess for steps taken.
  static double userProgressStepGoalWeekly = 0;

  /// Stores a user's current daily end goal for steps taken.
  static double userStepEndGoal = 0;

  /// Stores a user's current weekly end goal for steps taken.
  static double userStepWeeklyEndGoal = 0;

  /// Indicates if the user has set a steps daily goal.
  static bool isStepGoalSet = false;

  /// Indicates if the user has set a steps weekly goal.
  static bool isStepWeeklyGoalSet = false;

  /// Indicates if the user has completed their daily steps goal.
  static bool isStepGoalComplete = false;

  /// Indicates if the user has completed their weekly steps goal.
  static bool isStepWeeklyGoalComplete = false;

  /// Stores a user's current daily goal progess for miles traveled.
  static double userProgressMileGoal = 0;

  /// Stores a user's current weekly goal progess for miles traveled.
  static double userProgressMileGoalWeekly = 0;

  /// Stores a user's current daily end goal for miles traveled.
  static double userMileEndGoal = 0;

  /// Stores a user's current weekly end goal for miles traveled.
  static double userMileWeeklyEndGoal = 0;

  /// Indicates if the user has set a miles daily goal.
  static bool isMileGoalSet = false;

  /// Indicates if the user has set a miles weekly goal.
  static bool isMileWeeklyGoalSet = false;

  /// Indicates if the user has completed their daily miles goal.
  static bool isMileGoalComplete = false;

  /// Indicates if the user has completed their weekly miles goal.
  static bool isMileWeeklyGoalComplete = false;

  /// Stores a user's current daily goal progess for minutes spent cycling.
  static double userProgressCyclingGoal = 0;

  /// Stores a user's current weekly goal progess for minutes spent cycling.
  static double userProgressCyclingGoalWeekly = 0;

  /// Stores a user's current daily end goal for minutes spent cycling.
  static double userCyclingEndGoal = 0;

  /// Stores a user's current weekly end goal for minutes spent cycling.
  static double userCyclingWeeklyEndGoal = 0;

  /// Indicates if the user has set a cycling daily goal.
  static bool isCyclingGoalSet = false;

  /// Indicates if the user has set a cycling weekly goal.
  static bool isCyclingWeeklyGoalSet = false;

  /// Indicates if the user has completed their daily cycling goal.
  static bool isCyclingGoalComplete = false;

  /// Indicates if the user has completed their weekly cycling goal.
  static bool isCyclingWeeklyGoalComplete = false;

  /// Stores a user's current daily goal progess for minutes spent rowing.
  static double userProgressRowingGoal = 0;

  /// Stores a user's current weekly goal progess for minutes spent rowing.
  static double userProgressRowingGoalWeekly = 0;

  /// Stores a user's current daily end goal for minutes spent rowing.
  static double userRowingEndGoal = 0;

  /// Stores a user's current weekly end goal for minutes spent rowing.
  static double userRowingWeeklyEndGoal = 0;

  /// Indicates if the user has set a rowing daily goal.
  static bool isRowingGoalSet = false;

  /// Indicates if the user has set a rowing weekly goal.
  static bool isRowingWeeklyGoalSet = false;

  /// Indicates if the user has completed their daily rowing goal.
  static bool isRowingGoalComplete = false;

  /// Indicates if the user has completed their weekly rowing goal.
  static bool isRowingWeeklyGoalComplete = false;

  /// Stores a user's current daily goal progess for minutes spent using a step mill.
  static double userProgressStepMillGoal = 0;

  /// Stores a user's current weekly goal progess for minutes spent using a step mill.
  static double userProgressStepMillGoalWeekly = 0;

  /// Stores a user's current daily end goal for minutes spent using a step mill.
  static double userStepMillEndGoal = 0;

  /// Stores a user's current weekly end goal for minutes spent using a step mill.
  static double userStepMillWeeklyEndGoal = 0;

  /// Indicates if the user has set a step mill daily goal.
  static bool isStepMillGoalSet = false;

  /// Indicates if the user has set a step mill weekly goal.
  static bool isStepMillWeeklyGoalSet = false;

  /// Indicates if the user has completed their daily step mill goal.
  static bool isStepMillGoalComplete = false;

  /// Indicates if the user has completed their weekly step mill goal.
  static bool isStepMillWeeklyGoalComplete = false;

  /// Stores a user's current daily goal progess for minutes spent using an elliptical.
  static double userProgressEllipticalGoal = 0;

  /// Stores a user's current weekly goal progess for minutes spent using an elliptical.
  static double userProgressEllipticalGoalWeekly = 0;

  /// Stores a user's current daily end goal for minutes spent using an elliptical.
  static double userEllipticalEndGoal = 0;

  /// Stores a user's current weekly end goal for minutes spent using an elliptical.
  static double userEllipticalWeeklyEndGoal = 0;

  /// Indicates if the user has set a elliptical daily goal.
  static bool isEllipticalGoalSet = false;

  /// Indicates if the user has set a elliptical weekly goal.
  static bool isEllipticalWeeklyGoalSet = false;

  /// Indicates if the user has completed their daily elliptical goal.
  static bool isEllipticalGoalComplete = false;

  /// Indicates if the user has completed their weekly elliptical goal.
  static bool isEllipticalWeeklyGoalComplete = false;

  /// Stores a user's current daily goal progess for minutes spent resistance/strength training.
  static double userProgressResistanceStrengthGoal = 0;

  /// Stores a user's current weekly goal progess for minutes spent resistance/strength training.
  static double userProgressResistanceStrengthGoalWeekly = 0;

  /// Stores a user's current daily end goal for minutes spent resistance/strength training.
  static double userResistanceStrengthEndGoal = 0;

  /// Stores a user's current weekly end goal for minutes spent resistance/strength training.
  static double userResistanceStrengthWeeklyEndGoal = 0;

  /// Indicates if the user has set a resistance/strength daily goal.
  static bool isResistanceStrengthGoalSet = false;

  /// Indicates if the user has set a resistance/strength weekly goal.
  static bool isResistanceStrengthWeeklyGoalSet = false;

  /// Indicates if the user has completed their daily resistance/strength goal.
  static bool isResistanceStrengthGoalComplete = false;

  /// Indicates if the user has completed their weekly resistance/strength goal.
  static bool isResistanceStrengthWeeklyGoalComplete = false;

  /// Converts an activity duration string to a [Duration] object.
  ///
  /// Example:
  ///
  /// ```dart
  /// String activityDurationStr = "4 minutes";
  ///
  /// Duration d = convertToDuration(activityDurationStr);
  ///
  /// print(d); // 0:04:00.000000
  /// ```
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

  /// Converts a [Duration] to minutes.
  ///
  /// Example:
  ///
  ///```dart
  /// Duration d = Duration(hours: 3);
  ///
  /// double minutes = toMinutes(d);
  ///
  /// print(d); // 180
  /// ```
  static double toMinutes(Duration goalSum) {
    String hhmmss = goalSum.toString().split('.').first.padLeft(8, "0");
    List<String> hhmmssSplit = hhmmss.split(':');
    return double.parse(hhmmssSplit[0]) * 60 +
        double.parse(hhmmssSplit[1]) +
        double.parse(hhmmssSplit[2]) / 60;
  }

  /// Sends a local goal completion notification to the user.
  ///
  /// The [type] indicates the payload. By default, if a goal is completed, it is
  /// assumed to be a daily goal. Passing in 'Weekly' as the [type] will indicate
  /// the completed goal to be a weekly goal.
  ///
  /// If the user clicks on a notification, they will be taken to the Completed
  /// Goals screen and the [type] will determine which set of completed goals are
  /// displayed: daily or weekly.
  /// 
  /// The [id] specifies how a notification is shown when there is already one present.
  /// 
  /// - All completed daily goals have an id of 0. 
  /// - All completed weekly goals have an id of 1. 
  /// 
  /// If a newer notification has the same id as an older one, the older one 
  /// disappears with the newer taking its place.
  /// 
  /// As a result, only the newest completed daily and weekly goal will appear in 
  /// a user's notification shade.
  static void notify(String title, String body,
      {int id = 0, String type = "Daily"}) {
    NotificationService.notifications.show(
        id,
        title,
        body,
        NotificationDetails(
            android: AndroidNotificationDetails(NotificationService.channel.id,
                NotificationService.channel.name,
                channelDescription: NotificationService.channel.description,
                importance: Importance.high,
                color: Colors.white,
                playSound: true)),
        payload: type);
  }

  /// Calculates a user's completed goals.
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

  /// Uploads a completed daily goal's stats to the user's goal log collection.
  ///
  /// Once a goal is completed, the associated goal values are reset.
  ///
  /// A user will also receive a local notification informing them of completion.
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
      notify("Daily Goal Completed!",
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
      notify("Daily Goal Completed!",
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
      notify("Daily Goal Completed!",
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
      notify("Daily Goal Completed!",
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
      notify(
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
      notify(
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
      notify(
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
      notify("Daily Goal Completed!",
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
      notify("Daily Goal Completed!",
          "Resistance-Strength - $userResistanceStrengthEndGoal min of activity");
    }
  }

  /// Uploads a completed weekly goal's stats to the user's goal log collection.
  ///
  /// Once a goal is completed, the associated goal values are reset.
  ///
  /// A user will also receive a local notification informing them of completion.
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
      notify("Weekly Goal Completed!",
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
      notify("Weekly Goal Completed!",
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
      notify("Weekly Goal Completed!",
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
      notify("Weekly Goal Completed!",
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
      notify("Weekly Goal Completed!",
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
      notify("Weekly Goal Completed!",
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
      notify("Weekly Goal Completed!",
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
      notify("Weekly Goal Completed!",
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
      notify("Weekly Goal Completed!",
          "Resistance-Strength - $userResistanceStrengthWeeklyEndGoal min of activity",
          id: 1, type: "Weekly");
    }
  }

  /// Checks if a user's weekly goal deadline has been reached.
  ///
  /// If so, the associated goal's values will be reset.
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

  /// Checks if [dayOfMonth] is equal to the current day.
  ///
  /// If not, the associated field in Firestore is updated.
  static void _updateDayOfMonth() {
    if (dayOfMonth != _now.day) {
      FireStore.updateGoalData({"dayOfMonth": _now.day});
    }
  }

  /// Upload's a user's completed goals to their goal-log Firestore collection.
  static void uploadCompletedGoals() {
    _calculateCompletedGoals();
    _uploadCompletedDailyGoals();
    _uploadCompletedWeeklyGoals();
    _checkWeeklyGoalDeadLines();
    _updateDayOfMonth();
  }
}
