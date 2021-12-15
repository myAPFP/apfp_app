import 'package:apfp/flutter_flow/flutter_flow_youtube_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:apfp/welcome/welcome_widget.dart' as app;

/*
  ! In order to run these tests, please ensure you're logged into the app
  ! after launching it in Debugging mode. These tests assume you've reached 
  ! the homepage. Once logged in, stop the app and within 
  ? welcome_widget.dart, 
  ! you MUST comment out the following animation code found within it's
  ? initState():
    
  ?  startPageLoadAnimations(
  ?    animationsMap.values
  ?        .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
  ?    this,
  ?  );

  ! This is done to prevent animation tickers from stalling our tests, causing 
  ! them to all fail. Before launching the app in Debugging mode again, 
  ! you MUST un-comment out the above animation code.
*/

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Exercise Video Screen Integration Tests', () {
    testWidgets(
      'US: I can access a YouTube player containing an exercise video.', (WidgetTester tester) async{
      app.main();
      await tester.pumpAndSettle();

      // Reach Exercise Videos Page
      await tester.tap(find.byTooltip('Exercises'));
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Open Individual Exercise Videos Page
      await tester.tap(find.byType(InkWell).first);
      await tester.pumpAndSettle();

      // Verify YouTube player is present
      expect(find.byType(FlutterFlowYoutubePlayer), findsOneWidget);
    });

    testWidgets(
      'US: I can view info about the video, such as the title, source, and description.',
      (WidgetTester tester) async{
      app.main();
      await tester.pumpAndSettle();

      // Reach Exercise Videos Page
      await tester.tap(find.byTooltip('Exercises'));
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Open Individual Exercise Videos Page
      await tester.tap(find.byType(InkWell).first);
      await tester.pumpAndSettle();

      // Ensure video details are present (title, source, description)
      expect(find.byKey(Key('Video.videoTitle')), findsWidgets);
      expect(find.byKey(Key('Video.videoSource')), findsWidgets);
      expect(find.byKey(Key('Video.videoDescriptionTitle')), findsWidgets);
      expect(find.byKey(Key('Video.videoDescriptionBody')), findsWidgets);
      });

    testWidgets(
      'US: I can return to the list of exercise videos using a button.', (WidgetTester tester) async{
      app.main();
      await tester.pumpAndSettle();

      // Reach Exercise Videos Page
      await tester.tap(find.byTooltip('Exercises'));
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Open Individual Exercise Videos Page
      await tester.tap(find.byType(InkWell).first);
      await tester.pumpAndSettle();

      // Verify 'Back to all Videos' button exists
      expect(find.byType(InkWell).first, findsOneWidget);

      // Tap on 'Back to all Videos button to return to all videos list
      await tester.tap(find.byType(InkWell).first);
      await tester.pumpAndSettle();
    });
  });
}