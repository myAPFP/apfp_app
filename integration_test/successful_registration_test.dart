import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:apfp/widgets/welcome/welcome_widget.dart' as app;

  /*
  !  These tests assume you're starting at the Welcome page.
  !  They will only pass if the entered credentials are valid
  !  and the associated account doesn't exist already.
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
          find.byKey(Key('Create.emailTextField')), emailEx1);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key('Create.passwordTextField')), passwordEx);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key('Create.confirmPasswordTextField')), passwordEx);
      await tester.pumpAndSettle();

      // Hides keybaord by tapping screen
      await tester.tap(find.byKey(Key('Create.confirmPasswordLabel')));
      await tester.pumpAndSettle();
    });

    testWidgets('I am able to return to the welcome screen through a button.',
        (WidgetTester tester) async {
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
          find.byKey(Key('Create.emailTextField')), emailEx2);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key('Create.passwordTextField')), passwordEx);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(Key('Create.confirmPasswordTextField')), passwordEx);
      await tester.pumpAndSettle();

      // Hides keybaord by tapping screen
      await tester.tap(find.byKey(Key('Create.confirmPasswordLabel')));
      await tester.pumpAndSettle();
    });
  });
}
