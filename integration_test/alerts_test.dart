import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:apfp/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Announcements List Screen Tests', () {
    testWidgets('US: Ensure existence of announcements panels',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Reach Announcements Page to verify its existence
      await tester.tap(find.byTooltip('Alerts'));
      await tester.pumpAndSettle(Duration(seconds: 2));

      // Ensure existence of "Announcements" header
      expect(find.text("Announcements"), findsOneWidget);
      await tester.pumpAndSettle();
    });

    testWidgets(
        'US: I can preview the announcement subject and description: ' +
            'Ensure an alert has a subject and description visible',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Reach Announcements Page
      await tester.tap(find.byTooltip('Alerts'));
      await tester.pumpAndSettle();

      // Ensure announcement subject and information exist for first announcement. THIS WILL FAIL IN DEPLOYMENT
      expect(find.text('Test - 4/13/2022'), findsOneWidget);
      expect(find.textContaining('This is a test.'), findsOneWidget);
      await tester.pumpAndSettle();
    });

    testWidgets(
        'US: I am able to tap on a particular announcement to ' +
            'view more information on it: Ensure tapping on an alert takes you to that page',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Reach Announcements Page
      await tester.tap(find.byTooltip('Alerts'));
      await tester.pumpAndSettle();

      // Tap on first Alert widget on page
      await tester.tap(find.byKey(Key('Alert')).first);
      await tester.pumpAndSettle();
    });
  });
}
