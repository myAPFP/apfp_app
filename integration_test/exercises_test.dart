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

  group('Exercises List Screen Tests', () {
    testWidgets(
        'US: I can view a description of what this page contains at the top of it.',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Reach Exercises Page
      await tester.tap(find.byTooltip('Exercises'));
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Ensure header and description of this page are present
      expect(find.byKey(Key('Exercises.header')), findsOneWidget);
      expect(find.byKey(Key('Exercises.description')), findsOneWidget);
      await tester.pumpAndSettle();
    });

    testWidgets(
        'US: I can access a list of exercise videos that are available. ' +
            'Information about each video is shown such as the type, the name, and difficulty.',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Reach Exercises Page
      await tester.tap(find.byTooltip('Exercises'));
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Ensure multiple exercise titles and descriptions exist on the page
      expect(find.byKey(Key('ExerciseTitle')), findsWidgets);
      expect(find.byKey(Key('ExerciseDescription')), findsWidgets);
    });

    testWidgets(
        'US: If I tap on an exercise, I am taken to the individual page for that exercise.',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Reach Exercises Page
      await tester.tap(find.byTooltip('Exercises'));
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Tap on the first exercise InkWell on the page
      await tester.tap(find.byType(InkWell).first);
      await tester.pumpAndSettle();
    });
  });
}
