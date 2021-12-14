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

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Home Screen Tests', () {
    testWidgets(
        'US: I am able to view the few most recent announcements in an area at the top of the screen. ' +
            'I am displayed their title', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Ensure announcements panel exists
      expect(find.text('Recent\nAnnouncements'), findsOneWidget);
      expect(find.byKey(Key('Home.announcements')), findsOneWidget);

      // Ensure three announcement titles are shown
      expect(find.textContaining('Alert '), findsNWidgets(3));
    });

// The following test is quite rudimentary; ensures existence of the Today's Activity panel.
// This feature has yet to be implemented.

    testWidgets(
        'US: My activity that has been logged for the day is shown in a graphical representation. ' +
            'If I tap on it, I am taken to the My Activity page.',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Ensure Today's Activity header and activity GUI (placeholder) exist
      expect(find.text("Today's Activity"), findsOneWidget);
      expect(find.byKey(Key('Home.activityGUI')), findsOneWidget);
    });
  });
}
