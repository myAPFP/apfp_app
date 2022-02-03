import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:apfp/main.dart' as app;

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
