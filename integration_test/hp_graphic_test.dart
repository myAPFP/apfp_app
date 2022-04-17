import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:apfp/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Homepage Graphic Tests', () {
    testWidgets(
        'US: ', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
    });
  });
}
