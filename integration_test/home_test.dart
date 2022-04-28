import 'package:apfp/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Home Screen Tests', () {
    testWidgets(
        'US: I am able to view the few most recent announcements in an area at the top of the screen. ' +
            'I am displayed their title', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Ensure announcements panel exists
      expect(find.text('Recent Announcements'), findsOneWidget);
      expect(find.byKey(Key('Home.announcements')), findsOneWidget);

      // Ensure three announcements are shown
      expect(find.byKey(Key('Home.infoIcon')), findsNWidgets(3));
      expect(find.byKey(Key('Home.announcementText')), findsNWidgets(3));
    });

    testWidgets(
        'US: My activity that has been logged for the day is shown in a graphical representation. ' +
            'If I tap on it, I am taken to the My Activity page.',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Ensure Today's Activity header and activity GUI (placeholder) exist
      expect(find.text("Today's Activity"), findsOneWidget);
      expect(find.byKey(Key('Home.goalsTabbedContainer')), findsOneWidget);

      // Note: tests regarding the Goals graphic in Home is 
      // in the goals_and_hpGraphic_test file.
    });
  });
}
