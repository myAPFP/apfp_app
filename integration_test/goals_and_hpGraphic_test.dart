import 'package:apfp/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:apfp/util/goals/goal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // You must be logged into the app before running these tests.
  // These tests ensure the goals system and the associated tabbed container
  // in Home are functional.

  // It is best if these tests are ran when there are no goals currently set and
  // no activities are logged. This is to prevent any goal completions.

  group('Goal Tests', () {
    testWidgets(
        'US: I can set an exercise goal and I am reminded of that goal on the Homepage.' +
            'US: I am able to monitor the progress of my active exercise goal.' +
            'US: I am able to change my goal at any time.',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Reach Set Goal Page
      await tester.longPress(find.byKey(Key('Home.exerciseView')));
      await tester.pumpAndSettle();

      // Enters '15' into daily exercise goal textField
      await tester.enterText(
          find.byKey(Key("SetGoal.exerciseGoalTextField_daily")), '15');
      await tester.pumpAndSettle();

      // Sets 15 minutes as daily exercise goal
      await tester.tap(find.byKey(Key("SetGoal.setExerciseGoalBTN_daily")));
      await tester.pumpAndSettle();

      // Goes back to Home
      await tester.tap(find.byKey(Key("SetGoal.goBackBTN")));
      await tester.pumpAndSettle();

      // Ensure exercise goal progress is displayed in Home
      expect(
          find.text("Your goal is " +
              "${((Goal.userProgressExerciseTime / Goal.userExerciseTimeEndGoal) * 100) > 100 ? 100 : ((Goal.userProgressExerciseTime / Goal.userExerciseTimeEndGoal) * 100).toStringAsFixed(0)}" +
              "% complete."),
          findsOneWidget);
    });

    testWidgets(
        'US: I can set a calories goal and I am reminded of that goal on the Homepage.' +
            'US: I am able to monitor the progress of my active calories goal.' +
            'US: I am able to change my goal at any time.',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Taps Calories tab
      await tester.tap(find.byKey(Key("Home.calsTab")));
      await tester.pumpAndSettle();

      // Reach Set Goal Page
      await tester.longPress(find.byKey(Key('Home.calView')));
      await tester.pumpAndSettle();

      // Enters '1800' into daily calories goal textField
      await tester.enterText(
          find.byKey(Key("SetGoal.calGoalTextField_daily")), '1800');
      await tester.pumpAndSettle();

      // Sets 1800 minutes as daily calories goal
      await tester.tap(find.byKey(Key("SetGoal.setCalGoalBTN_daily")));
      await tester.pumpAndSettle();

      // Goes back to Home
      await tester.tap(find.byKey(Key("SetGoal.goBackBTN")));
      await tester.pumpAndSettle();

      // Ensure calories goal progress is displayed in Home
      expect(
          find.text("Your goal is " +
              "${((Goal.userProgressCalGoal / Goal.userCalEndGoal) * 100) > 100 ? 100 : ((Goal.userProgressCalGoal / Goal.userCalEndGoal) * 100).toStringAsFixed(0)}" +
              "% complete."),
          findsOneWidget);
    });

    testWidgets(
        'US: I can set a steps goal and I am reminded of that goal on the Homepage.' +
            'US: I am able to monitor the progress of my active steps goal.' +
            'US: I am able to change my goal at any time.',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Taps Steps tab
      await tester.tap(find.byKey(Key("Home.stepsTab")));
      await tester.pumpAndSettle();

      // Reach Set Goal Page
      await tester.longPress(find.byKey(Key('Home.stepsView')));
      await tester.pumpAndSettle();

      // Enters '5000' into daily steps goal textField
      await tester.enterText(
          find.byKey(Key("SetGoal.stepGoalTextField_daily")), '5000');
      await tester.pumpAndSettle();

      // Sets 5000 minutes as daily steps goal
      await tester.tap(find.byKey(Key("SetGoal.setStepGoalBTN_daily")));
      await tester.pumpAndSettle();

      // Goes back to Home
      await tester.tap(find.byKey(Key("SetGoal.goBackBTN")));
      await tester.pumpAndSettle();

      // Ensure steps goal progress is displayed in Home
      expect(
          find.text("Your goal is " +
              "${((Goal.userProgressStepGoal / Goal.userStepEndGoal) * 100) > 100 ? 100 : ((Goal.userProgressStepGoal / Goal.userStepEndGoal) * 100).toStringAsFixed(0)}" +
              "% complete."),
          findsOneWidget);
    });

    testWidgets(
        'US: I can set an miles goal and I am reminded of that goal on the Homepage.' +
            'US: I am able to monitor the progress of my active miles goal.' +
            'US: I am able to change my goal at any time.',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Taps Miles tab
      await tester.tap(find.byKey(Key("Home.milesTab")));
      await tester.pumpAndSettle();

      // Reach Set Goal Page
      await tester.longPress(find.byKey(Key('Home.mileView')));
      await tester.pumpAndSettle();

      // Enters '15' into daily miles goal textField
      await tester.enterText(
          find.byKey(Key("SetGoal.mileGoalTextField_daily")), '15');
      await tester.pumpAndSettle();

      // Sets 15 minutes as daily mile goal
      await tester.tap(find.byKey(Key("SetGoal.setMileGoalBTN_daily")));
      await tester.pumpAndSettle();

      // Goes back to Home
      await tester.tap(find.byKey(Key("SetGoal.goBackBTN")));
      await tester.pumpAndSettle();

      // Ensure mile goal progress is displayed in Home
      expect(
          find.text("Your goal is " +
              "${((Goal.userProgressMileGoal / Goal.userMileEndGoal) * 100) > 100 ? 100 : ((Goal.userProgressMileGoal / Goal.userMileEndGoal) * 100).toStringAsFixed(0)}" +
              "% complete."),
          findsOneWidget);
    });

      testWidgets(
        'US: I can set an "APFP" goal and I am reminded of that goal on the Homepage.' +
            'US: I am able to monitor the progress of my active "APFP" goals.' +
            'US: I am able to change my goal at any time.',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Taps "APFP" tab
      await tester.tap(find.byKey(Key("Home.apfpTab")));
      await tester.pumpAndSettle();

      // Reach Set Goal Page
      await tester.longPress(find.byKey(Key('Home.apfpView')));
      await tester.pumpAndSettle();

      // Displays "APFP" goals
      await tester.tap(find.byKey(Key("SetGoal.switchGoalViewBTN")));
      await tester.pumpAndSettle();

      // Enters '15' into daily cycling goal textField
      await tester.enterText(
          find.byKey(Key("SetGoal.cyclingGoalTextField_daily")), '15');
      await tester.pumpAndSettle();

      // Sets 15 minutes as daily cycling goal
      await tester.tap(find.byKey(Key("SetGoal.setCyclingGoalBTN_daily")));
      await tester.pumpAndSettle();

      // Enters '15' into daily rowing goal textField
      await tester.enterText(
          find.byKey(Key("SetGoal.rowingGoalTextField_daily")), '15');
      await tester.pumpAndSettle();

      // Sets 15 minutes as daily rowing goal
      await tester.tap(find.byKey(Key("SetGoal.setRowingGoalBTN_daily")));
      await tester.pumpAndSettle();

      // Enters '15' into daily step mill goal textField
      await tester.enterText(
          find.byKey(Key("SetGoal.stepMillGoalTextField_daily")), '15');
      await tester.pumpAndSettle();

      // Sets 15 minutes as daily step mill goal
      await tester.tap(find.byKey(Key("SetGoal.setStepMillGoalBTN_daily")));
      await tester.pumpAndSettle();

      // Enters '15' into daily elliptical goal textField
      await tester.enterText(
          find.byKey(Key("SetGoal.ellipticalGoalTextField_daily")), '15');
      await tester.pumpAndSettle();

      // Sets 15 minutes as daily elliptical goal
      await tester.tap(find.byKey(Key("SetGoal.setEllipticalGoalBTN_daily")));
      await tester.pumpAndSettle();

      // Enters '15' into daily resistance strength goal textField
      await tester.enterText(
          find.byKey(Key("SetGoal.resStrengthGoalTextField_daily")), '15');
      await tester.pumpAndSettle();

      // Sets 15 minutes as daily resistance strength goal
      await tester.tap(find.byKey(Key("SetGoal.setResStrengthGoalBTN_daily")));
      await tester.pumpAndSettle();

      expect(find.text("15"), findsNWidgets(5));        
    });

    testWidgets(
        'US: When I complete a goal, the completed goals screen should be updated' +
            ' to reflect the newest addition.', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Reach Set Goal Page
      await tester.longPress(find.byKey(Key('Home.exerciseView')));
      await tester.pumpAndSettle();

      // Enters '15' into daily exercise goal textField
      await tester.enterText(
          find.byKey(Key("SetGoal.exerciseGoalTextField_daily")), '15');
      await tester.pumpAndSettle();

      // Sets 15 minutes as daily exercise goal
      await tester.tap(find.byKey(Key("SetGoal.setExerciseGoalBTN_daily")));
      await tester.pumpAndSettle();

      // Goes back to Home
      await tester.tap(find.byKey(Key("SetGoal.goBackBTN")));
      await tester.pumpAndSettle();

     // Reach My Activity Page
      await tester.tap(find.byTooltip("Today's Activity"));
      await tester.pumpAndSettle();

      // Navigates to new activity screen
      await tester.tap(find.byKey(Key("Activity.FAB")));
      await tester.pumpAndSettle();

      // Populates each textFormField with info
      await tester.enterText(
          find.byKey(Key("AddActivity.activityNameTextField")), 'Running');
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key("AddActivity.durationTextField")), '15');
      await tester.pumpAndSettle();

      // Presses "Enter" - hides keyboard
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      // Adds new activity
      await tester.tap(find.byKey(Key("AddActivity.submitButton")));
      await tester.pumpAndSettle();

      // Reach Settings Page
      await tester.tap(find.byTooltip("Settings"));
      await tester.pumpAndSettle();

      // Views completed goals log
      await tester.tap(find.byKey(Key("Settings.viewCompletedGoalsBTN")));
      await tester.pumpAndSettle();

      final now = DateTime.now();

      // Verify the completed goal has been logged.
      expect(find.text("Exercise Time"), findsWidgets);
      expect(find.text("Type: Daily Goal"), findsWidgets);
      expect(find.text("Info: 15.0 min of activity"), findsWidgets);
      expect(find.text("Completed: ${now.month}/${now.day}/${now.year}"), findsWidgets);
    });
  });
}
