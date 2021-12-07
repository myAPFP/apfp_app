import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:apfp/welcome/welcome_widget.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Tap on the Create Account button with no input, verify each textfield displays an warning',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Launches Create Account Screen from Welcome
      var createAcctButton_welcome = find.byKey(Key('Welcome.CreateAcctButton'));
      await tester.tap(createAcctButton_welcome);
      await tester.pumpAndSettle();

      // Taps Create Account Button without any input
      var createAcctButton = find.byKey(Key('Create.CreateAcctButton'));
      await tester.tap(createAcctButton);
      await tester.pumpAndSettle();

      // Verify each textfield displays a no-input warning.
      expect(find.text('Please provide a value'), findsNWidgets(5));
    });
  });
}
