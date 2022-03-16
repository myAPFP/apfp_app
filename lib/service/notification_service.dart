import 'package:apfp/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationService {
  static FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
      playSound: true);

  static Future init() async {
    final iOS = IOSInitializationSettings();
    final android = AndroidInitializationSettings("@mipmap/ic_launcher");
    final settings = InitializationSettings(android: android, iOS: iOS);
    await notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    notifications.initialize(settings, onSelectNotification: (payload) async {
      onNotifications.add(payload);
    });
  }

  static void showNotification(String title, String body) {
    notifications.show(
        0,
        title,
        body,
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                importance: Importance.high,
                color: FlutterFlowTheme.secondaryColor,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }
}
