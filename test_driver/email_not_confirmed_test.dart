import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:apfp/welcome/welcome_widget.dart' as app;


// These tests run from the Email Not Confirmed screen,
// Please reach this page first to run these tests successfully
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Email Not Confirmed Screen Integration Tests', (){
    testWidgets("US: If I reach this page, I am shown a message explaining that" +
      "my email has not yet been validated", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Ensure email not confirmed message is present
      expect(find.byKey(Key('Email.contextMessage')), findsOneWidget);
    });

    testWidgets("US: I am able to resent the confirmation email if I have not received" +
      "it or if I have deleted it", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Ensure button exists to resend email confirmation
      expect(find.text('Resend Confirmation Email'), findsOneWidget);

      // Tap on button to ensure email confirmation resends
      await tester.tap(find.text('Resend Confirmation Email'));
      tester.pumpAndSettle();
    });

    testWidgets("US: I can return to the welcome screen using a button",
      (WidgetTester tester) async{
      app.main();
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