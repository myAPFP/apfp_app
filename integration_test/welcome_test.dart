import 'package:apfp/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Welcome Screen Integration Tests', () {
    testWidgets(
        'US: As a user, I can access the log in page to use my personal' +
            'information to log into the app.', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      var loginButton = find.byKey(Key('Welcome.loginButton'));

      // Expect to find the item on screen.
      expect(loginButton, findsOneWidget);

      // Emulates a tap on the login button.
      await tester.tap(loginButton);

      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify navigation to login route after button press.
      expect(find.text('Forgot Your Password?'), findsOneWidget);
    });

    testWidgets('Tap on the Create Account button,' + 'verify navigation',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      var createAcctButton = find.byKey(Key('Welcome.createAcctButton'));

      // Expect to find the item on screen.
      expect(createAcctButton, findsOneWidget);

      // Emulates a tap on the create account button.
      await tester.tap(createAcctButton);

      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify navigation to create account route after button press.
      expect(find.text('First Name'), findsOneWidget);
    });
  });
}
