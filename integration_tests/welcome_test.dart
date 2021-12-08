import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:apfp/welcome/welcome_widget.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Welcome Screen Integration Tests', () {
    testWidgets('Tap on the Login button,' + 
    'verify navigation', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      var loginButton = find.byKey(Key('Welcome.LoginButton'));

      // Expect to find the item on screen.
      expect(loginButton, findsOneWidget);

      // Emulates a tap on the login button.
      await tester.tap(loginButton);

      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify naviagtion to login route after button press.
      expect(find.text('Forgot Your Password?'), findsOneWidget);
    });

  testWidgets('Tap on the Create Account button,' + 
  'verify navigation', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      var createAcctButton = find.byKey(Key('Welcome.CreateAcctButton'));

      // Expect to find the item on screen.
      expect(createAcctButton, findsOneWidget);

      // Emulates a tap on the create account button.
      await tester.tap(createAcctButton);

      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify naviagtion to create account route after button press.
      expect(find.text('Welcome to the Adult Physical Fitness Program at' +
      'Ball State University! Please enter the details' +
      'below to create your account.'), findsOneWidget);
    });
  });
}
