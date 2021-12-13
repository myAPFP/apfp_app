import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:apfp/welcome/welcome_widget.dart' as app;

// These tests run from the Home page; please reach this page first on your system to
// run these tests successfully
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Announcements List Screen Tests', () {
    testWidgets(
        'US: My unread announcements and previous announcements should be ' +
            'separated into two different panels: Ensure existence of "Unread" and ' +
            '"Previous" announcements panels', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Reach Announcements Page to verify its existence
      await tester.tap(find.byTooltip('Alerts'));
      await tester.pumpAndSettle();

      // Ensure existence of "Unread Announcements" header and "Previous Announcements" header
      expect(find.text("Unread Announcements"), findsOneWidget);
      expect(find.text("Previous Announcements"), findsOneWidget);
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

      // Ensure announcement subject and information exist for each announcement element
      expect(find.text('Example announcement subject'), findsNWidgets(6));
      expect(find.text('Example announcement information'), findsNWidgets(6));
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
