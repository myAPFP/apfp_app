import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:apfp/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // You must be logged into the app before running these tests.
  group('Goal Tests', () {
    testWidgets(
        'US: I can set a goal and I am reminded of that goal on the Homepage.' +
            'US: I am able to monitor the progress of any active goal.' + 
            'US: I am able to change my goal at any time.',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Reach Add Goal Page
      await tester.longPress(find.byKey(Key('Home.exerciseView')));
      await tester.pumpAndSettle();

      // Enters '15' into daily exercise goal textfield
      await tester.enterText(
          find.byKey(Key("SetGoal.exerciseGoalTextField_daily")), '15');
      await tester.pumpAndSettle();

      // Sets 15 minutes as daily exercise goal
      await tester.tap(find.byKey(Key("SetGoal.setExerciseGoalBTN_daily")));
      await tester.pumpAndSettle();

      // Edits goal by entering '20' into daily exercise goal textfield
      await tester.enterText(
          find.byKey(Key("SetGoal.exerciseGoalTextField_daily")), '20');
      await tester.pumpAndSettle();

      // Sets 20 minutes as daily exercise goal
      await tester.tap(find.byKey(Key("SetGoal.setExerciseGoalBTN_daily")));
      await tester.pumpAndSettle();

      // Goes back to Home
      await tester.tap(find.byKey(Key("SetGoal.goBackBTN")));
      await tester.pumpAndSettle();

      // Ensure exercise goal progress is displayed in Home
      expect(find.text('Your goal is 0% complete.'), findsOneWidget);
    }); 
  });
}
