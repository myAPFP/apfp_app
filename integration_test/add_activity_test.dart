import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:apfp/main.dart' as app;

/*
  ! In order to run these tests, please ensure you're logged into the app
  ! after launching it in Debugging mode. These tests assume you've reached 
  ! the homepage. Once logged in, stop the app and within 
  ? welcome_widget.dart, 
  ! you MUST comment out the following animation code found within it's
  ? initState():
    
  ?  startPageLoadAnimations(
  ?    animationsMap.values
  ?        .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
  ?    this,
  ?  );

  ! This is done to prevent animation tickers from stalling our tests, causing 
  ! them to all fail. Before launching the app in Debugging mode again, 
  ! you MUST un-comment out the above animation code.
*/

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('My Activity Integration Tests', () {
    testWidgets(
        'US: I can input the name of the activity, the type of activity,' +
            'calories burned and duration of the activity via text boxes.' +
            'US: I can submit the information to be stored in the application.',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Reach My Activity Page to verify its existence
      await tester.tap(find.byTooltip('My Activity'));
      await tester.pumpAndSettle();

      // Navigates to new activity screen
      await tester.tap(find.byKey(Key("Activity.addActivityButtton")));
      await tester.pumpAndSettle();

      // Populates each textformfield with info
      await tester.enterText(
          find.byKey(Key("AddActivity.activityNameTextField")), 'Jogging');
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key("AddActivity.totalCalTextField")), '100');
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key("AddActivity.exerciseTextField")), 'Cardio');
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key("AddActivity.durationTextField")), '10 min');
      await tester.pumpAndSettle();

      // Presses "Enter" - hides keyboard
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      // Adds new activity
      await tester.tap(find.byKey(Key("AddActivity.submitButton")));
      await tester.pumpAndSettle();

      // Verifies new info is stored
      expect(find.byIcon(Icons.info), findsOneWidget);
      expect(
          find.text("10 min                       100 cals"), findsOneWidget);
      expect(find.text("Jogging"), findsOneWidget);
      expect(find.text("Cardio"), findsNWidgets(4));
    });
  });
}
