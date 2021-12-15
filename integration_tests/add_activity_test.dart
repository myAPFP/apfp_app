import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:apfp/welcome/welcome_widget.dart' as app;

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
  ! them to all fail.
*/

//
//  I can submit the information to be stored in the application.

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('My Activity Integration Tests', () {
    testWidgets(
        'US:I can input the name of the activity, the type of activity, and duration' +
            'of the activity through a combination of text boxes and dropdown menus.',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Reach My Activity Page to verify its existence
      await tester.tap(find.byTooltip('My Activity'));
      await tester.pumpAndSettle();

      // Navigates to new activity screen
      await tester.tap(find.byKey(Key("Activity.addActivityButtton")));
      await tester.pumpAndSettle();

      

      // Adds blank new activity to enable page scrolling
      await tester.tap(find.byKey(Key("AddActivity.submitButton")));
      await tester.pumpAndSettle();
    });

    testWidgets(
        "US: If I am ready to log another activity, I can press a"
                "button to be taken to a screen to log a new activity" +
            "US: The items are stored in a list so that if I've logged a lot of" +
            "activity, I can scroll through it.", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Reach My Activity Page to verify its existence
      await tester.tap(find.byTooltip('My Activity'));
      await tester.pumpAndSettle();

      // Navigates to new activity screen
      await tester.tap(find.byKey(Key("Activity.addActivityButtton")));
      await tester.pumpAndSettle();

      // Adds blank new activity to enable page scrolling
      await tester.tap(find.byKey(Key("AddActivity.submitButton")));
      await tester.pumpAndSettle();

      // Verifies page can scroll
      await tester.drag(find.byKey(Key("Activity.singleChildScrollView")),
          const Offset(0.0, -300));
      await tester.pump();
    });
  });
}
