import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:apfp/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const String emailEx1 = 'bkwalker@bsu.edu';
  const String emailEx2 = 'apfpapp@gmail.com';
  const String passwordEx = 'password12!';

  group('Successful Registration Screen Integration Tests', () {
    testWidgets(
        'US: As a user, If I reach this page,' +
            'I am shown a message stating that I have registered and' +
            'telling me to check my email for verification..',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Launches Create Account Screen from Welcome
      var createAcctButtonWel = find.byKey(Key('Welcome.createAcctButton'));
      await tester.tap(createAcctButtonWel);
      await tester.pumpAndSettle();

      // Populates each textFormField with valid info
      await tester.enterText(
          find.byKey(Key("Create.firstNameTextField")), 'John');
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key("Create.lastNameTextField")), 'Doe');
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key('Create.emailTextField')), emailEx1);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key('Create.passwordTextField')), passwordEx);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key('Create.confirmPasswordTextField')), passwordEx);
      await tester.pumpAndSettle();

      // Hides keyboard by tapping screen
      await tester.tap(find.byKey(Key('Create.confirmPasswordLabel')));
      await tester.pumpAndSettle();
    });

    testWidgets('I am able to return to the welcome screen through a button.',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Launches Create Account Screen from Welcome
      var createAcctButtonWel = find.byKey(Key('Welcome.createAcctButton'));
      await tester.tap(createAcctButtonWel);
      await tester.pumpAndSettle();

      // Populates each textFormField with valid info
      await tester.enterText(
          find.byKey(Key("Create.firstNameTextField")), 'John');
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key("Create.lastNameTextField")), 'Doe');
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key('Create.emailTextField')), emailEx2);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key('Create.passwordTextField')), passwordEx);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key('Create.confirmPasswordTextField')), passwordEx);
      await tester.pumpAndSettle();

      // Hides keyboard by tapping screen
      await tester.tap(find.byKey(Key('Create.confirmPasswordLabel')));
      await tester.pumpAndSettle();
    });
  });
}
