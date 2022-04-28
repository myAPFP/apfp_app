import 'package:apfp/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// You must be logged into the app before running these tests.

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
