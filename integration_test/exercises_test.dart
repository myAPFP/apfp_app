import 'package:apfp/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

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
      await tester.pumpAndSettle();

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
      await tester.pumpAndSettle();

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
      await tester.pumpAndSettle();

      // Tap on the first exercise InkWell on the page
      await tester.tap(find.byType(InkWell).first);
      await tester.pumpAndSettle();
    });
  });
}
