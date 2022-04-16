import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:apfp/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

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

      // Enters '15' into daily exercise goal textfield
      await tester.enterText(
          find.byKey(Key("AddGoal.exerciseGoalTextField_daily")), '15');
      await tester.pumpAndSettle();

      // Sets 15 minutes as daily exercise goal
      await tester.tap(find.byKey(Key("AddGoal.setExerciseGoalBTN_daily")));
      await tester.pumpAndSettle();

      // Goes back to Home
      await tester.tap(find.byKey(Key("AddGoal.goBackBTN")));
      await tester.pumpAndSettle();

      // Ensure exercise goal progress is displayed
      expect(find.text('0.00 / 15.00\nTotal Minutes'), findsOneWidget);
      expect(find.text('Your goal is 0.00% complete.'), findsOneWidget);

      // Reach Add Goal Page
      await tester.longPress(find.byKey(Key('Home.exerciseView')));

      // Enters '20' into daily exercise goal textfield
      await tester.enterText(
          find.byKey(Key("AddGoal.exerciseGoalTextField_daily")), '20');
      await tester.pumpAndSettle();

      // Changes daily exercise goal to 20 minutes
      await tester.tap(find.byKey(Key("AddGoal.setExerciseGoalBTN_daily")));
      await tester.pumpAndSettle();

      // Goes back to Home
      await tester.tap(find.byKey(Key("AddGoal.goBackBTN")));
      await tester.pumpAndSettle();

      // Ensure daily exercise goal is now 20 minutes
      expect(find.text('0.00 / 20.00\nTotal Minutes'), findsOneWidget);
    }); 
  });
}
