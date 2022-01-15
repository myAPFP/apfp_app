import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:apfp/welcome/welcome_widget.dart' as app;

/*
  !  These tests assume you're starting at the Welcome page.
  !  Please log out of the app in Debugging mode before running.
  !  Within 
  ?  welcome_widget.dart,
  !  you MUST in-comment out the following animation code found within it's
  ?  initState():
    
  ?  startPageLoadAnimations(
  ?    animationsMap.values
  ?        .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
  ?    this,
  ?  );
  ! This allows the app to run properly.
*/

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Email Not Confirmed Screen Integration Tests', () {
    testWidgets(
        "US: If I reach this page, I am shown a message explaining that" +
            "my email has not yet been validated", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Launches Login Screen from Welcome
      var loginButtonWel = find.byKey(Key('Welcome.loginButton'));
      await tester.tap(loginButtonWel);
      await tester.pumpAndSettle();

      // Populates each textformfield with valid info
      await tester.enterText(
          find.byKey(Key("Login.emailTextField")), 'example@email.com');
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key("Login.passwordTextField")), 'password12!');
      await tester.pumpAndSettle();

      // Taps Login button
      var loginButton = find.byKey(Key('Login.loginInButton'));
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Ensure email not confirmed message is present
      expect(find.byKey(Key('Email.contextMessage')), findsOneWidget);
    });

    testWidgets(
        "US: I am able to resent the confirmation email if I have not received" +
            "it or if I have deleted it", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Launches Login Screen from Welcome
      var loginButtonWel = find.byKey(Key('Welcome.loginButton'));
      await tester.tap(loginButtonWel);
      await tester.pumpAndSettle();

      // Populates each textformfield with valid info
      await tester.enterText(
          find.byKey(Key("Login.emailTextField")), 'example@email.com');
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key("Login.passwordTextField")), 'password12!');
      await tester.pumpAndSettle();

      // Taps Login button
      var loginButton = find.byKey(Key('Login.loginInButton'));
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Ensure button exists to resend email confirmation
      expect(find.text('Resend Confirmation Email'), findsOneWidget);

      // Tap on button to ensure email confirmation resends
      await tester.tap(find.text('Resend Confirmation Email'));
      tester.pumpAndSettle();
    });

    testWidgets("US: I can return to the welcome screen using a button",
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Launches Login Screen from Welcome
      var loginButtonWel = find.byKey(Key('Welcome.loginButton'));
      await tester.tap(loginButtonWel);
      await tester.pumpAndSettle();

      // Populates each textformfield with valid info
      await tester.enterText(
          find.byKey(Key("Login.emailTextField")), 'example@email.com');
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key("Login.passwordTextField")), 'password12!');
      await tester.pumpAndSettle();

      // Taps Login button
      var loginButton = find.byKey(Key('Login.loginInButton'));
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Ensure back to home button exists
      expect(find.byKey(Key('Email.returnHomeButton')), findsOneWidget);

      // Taps return home button to return to Welcome screen
      var returnHomeButton = find.byKey(Key('Email.returnHomeButton'));
      await tester.tap(returnHomeButton);
      await tester.pumpAndSettle();
    });
  });
}
