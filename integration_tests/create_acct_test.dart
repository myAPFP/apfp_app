import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:apfp/welcome/welcome_widget.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Create Account Screen Integration Tests', () {
    testWidgets(
        'Tap on the Create Account button with no input,' +
            'verify each textfield displays an warning',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Launches Create Account Screen from Welcome
      var createAcctButton_wel = find.byKey(Key('Welcome.createAcctButton'));
      await tester.tap(createAcctButton_wel);
      await tester.pumpAndSettle();

      // Taps Create Account Button without any input
      var createAcctButton = find.byKey(Key('Create.createAcctButton'));
      await tester.tap(createAcctButton);
      await tester.pumpAndSettle();

      // Verify each textfield displays a no-input warning.
      expect(find.text('Please provide a value'), findsNWidgets(5));
    });

    testWidgets(
        "US: I can enter my name, email address, and passwords through the" +
            "use of text fields.", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Launches Create Account Screen from Welcome
      var createAcctButton_wel = find.byKey(Key('Welcome.createAcctButton'));
      await tester.tap(createAcctButton_wel);
      await tester.pumpAndSettle();

      // Populates each textformfield with valid info
      await tester.enterText(
          find.byKey(Key("Create.firstNameTextField")), 'John');
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key("Create.lastNameTextField")), 'Doe');
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key('Create.emailTextField')), 'example@email.com');
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key('Create.passwordTextField')), 'password12!');
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key('Create.confirmPasswordTextField')), 'password12!');
      await tester.pumpAndSettle();

      // Verify each TextFormField validated and accepted each credential
      expect(find.text('Please provide a value'), findsNWidgets(0));
    });

    testWidgets(
        "US: Once my information has been filled out, I am able to press a button" +
            " to submit my information.", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Launches Create Account Screen from Welcome
      var createAcctButton_wel = find.byKey(Key('Welcome.createAcctButton'));
      await tester.tap(createAcctButton_wel);
      await tester.pumpAndSettle();

      // Populates each textformfield with valid info
      await tester.enterText(
          find.byKey(Key("Create.firstNameTextField")), 'John');
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key("Create.lastNameTextField")), 'Doe');
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key('Create.emailTextField')), 'example@email.com');
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key('Create.passwordTextField')), 'password12!');
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key('Create.confirmPasswordTextField')), 'password12!');
      await tester.pumpAndSettle();

      // Hides keybaord by tapping screen
      await tester.tap(find.byKey(Key('Create.confirmPasswordLabel')));
      await tester.pumpAndSettle();

      // Taps Create Account button, submitting the info entered
      var createAcctButton = find.byKey(Key('Create.createAcctButton'));
      await tester.tap(createAcctButton);
      await tester.pumpAndSettle();
    });

    testWidgets(
        "US: I am able to toggle my password visibility using a button.",
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Launches Create Account Screen from Welcome
      var createAcctButton_wel = find.byKey(Key('Welcome.createAcctButton'));
      await tester.tap(createAcctButton_wel);
      await tester.pumpAndSettle();

      // Populates PW textformfields with example password
      await tester.enterText(
          find.byKey(Key('Create.passwordTextField')), 'password12!');
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key('Create.confirmPasswordTextField')), 'password12!');
      await tester.pumpAndSettle();

      // Toggles each password textfieldform visibility
      await tester.tap(find.byKey(Key("Create.pWVisibilty")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("Create.confirmPWVisibilty")));
      await tester.pumpAndSettle();

      // Verify the entered password is shown
      expect(find.text('password12!'), findsNWidgets(2));

      // Toggles each password textfieldform visibility again
      await tester.tap(find.byKey(Key("Create.pWVisibilty")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("Create.confirmPWVisibilty")));
      await tester.pumpAndSettle();
    });
  });
}
