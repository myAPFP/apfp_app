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

  group('Individual Announcement Screen Tests', () {
    testWidgets(
        'US: I can view the title of the announcement sent by the APFP, as well as all of the information that has been sent out. ' +
            'Ensure title and description are visible on individual announcement page.',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Reach Announcements Page
      await tester.tap(find.byTooltip('Alerts'));
      await tester.pumpAndSettle(Duration(seconds: 2));

      // Tap on first Alert widget on page
      await tester.tap(find.byKey(Key('Alert')).first);
      await tester.pumpAndSettle();

      // Ensure title and description exist and are displayed
      expect(find.byKey(Key('Alert.title')), findsOneWidget);
      expect(find.byKey(Key('Alert.description')), findsOneWidget);
      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets(
        'US: I can return to the main list of announcements through a button at the top of the screen. ' +
            'Ensure back button is present and returns to list when pressed',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Reach Announcements Page
      await tester.tap(find.byTooltip('Alerts'));
      await tester.pumpAndSettle(Duration(seconds: 2));

      // Tap on first Alert widget on page
      await tester.tap(find.byKey(Key('Alert')).first);
      await tester.pumpAndSettle();

      // Expect back button to exist with shown text
      expect(find.text('< Back to Announcements'), findsOneWidget);

      // Tap on back button to ensure returns to list
      await tester.tap(find.text('< Back to Announcements'));
      await tester.pumpAndSettle();
    });
  });
}
