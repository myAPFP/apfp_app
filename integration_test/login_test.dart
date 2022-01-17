import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:apfp/main.dart' as app;

// TODO: Complete user story once screen is implemented:
// US: If I have forgotten my password, there is a button
// I can press to take me through the password reset process.

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

  group('Login Screen Integration Tests', () {
    testWidgets(
        "US: I can enter my email address and password through text fields." +
            "These fields are labeled.", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Launches Login Screen from Welcome
      var loginButtonWel = find.byKey(Key('Welcome.loginButton'));
      await tester.tap(loginButtonWel);
      await tester.pumpAndSettle();

      // Populates each textformfield with valid info
      await tester.enterText(find.byKey(Key("Login.emailTextField")), 'John');
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(Key("Login.passwordTextField")), 'Doe');
      await tester.pumpAndSettle();

      // Verify each textfield holds user input
      expect(find.text('John'), findsNWidgets(1));
      expect(find.text('Doe'), findsNWidgets(1));
    });

    testWidgets("US: I can toggle my password visibility through a button.",
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Launches Login Screen from Welcome
      var loginButtonWel = find.byKey(Key('Welcome.loginButton'));
      await tester.tap(loginButtonWel);
      await tester.pumpAndSettle();

      // Populates password textformfield with valid password
      await tester.enterText(
          find.byKey(Key("Login.passwordTextField")), 'password12!');
      await tester.pumpAndSettle();

      // Toggles password textfieldform visibility
      await tester.tap(find.byKey(Key("Login.passwordVisibiltyIcon")));
      await tester.pumpAndSettle();

      // Verify password textfield input is visible
      expect(find.text('password12!'), findsNWidgets(1));

      // Toggles password textfieldform visibility again
      await tester.tap(find.byKey(Key("Login.passwordVisibiltyIcon")));
      await tester.pumpAndSettle();
    });

    testWidgets(
        "US: Once my information has been entered, I can press a button" +
            "to attempt to log in.", (WidgetTester tester) async {
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
    });
  });
}
