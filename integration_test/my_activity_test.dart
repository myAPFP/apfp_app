import 'package:apfp/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('My Activity Integration Tests', () {
    testWidgets(
        'US: I can view information about past entries from that day,' +
            'such as the name of the exercise, the type of the exercise, and the duration.',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Reach My Activity Page to verify its existence
      await tester.tap(find.byTooltip("Today's Activity"));
      await tester.pumpAndSettle();
    });

    testWidgets(
        "US: If I am ready to log another activity, I can press a"
                " button to be taken to a screen to log a new activity\n" +
            "US: The items are stored in a list so that if I've logged a lot of" +
            " activity, I can scroll through it.", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Reach My Activity Page to verify its existence
      await tester.tap(find.byTooltip("Today's Activity"));
      await tester.pumpAndSettle();

      // Adds 5 activities
      for (int i = 0; i < 5; i++) {
        // Navigates to new activity screen
        await tester.tap(find.byKey(Key("Activity.FAB")));
        await tester.pumpAndSettle();

        // Populates each textFormField with info
        await tester.enterText(
            find.byKey(Key("AddActivity.activityNameTextField")), 'Jogging');
        await tester.pumpAndSettle();
        await tester.enterText(
            find.byKey(Key("AddActivity.durationTextField")), '10');
        await tester.pumpAndSettle();

        // Presses "Enter" - hides keyboard
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        // Adds new activity
        await tester.tap(find.byKey(Key("AddActivity.submitButton")));
        await tester.pumpAndSettle();
      }

      // Verifies page can scroll
      await tester.drag(find.byKey(Key("Activity.singleChildScrollView")),
          const Offset(0.0, -300));
      await tester.pump();
    });
  });
}
