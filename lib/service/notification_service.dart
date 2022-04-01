import 'package:apfp/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationService {
  static FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static AndroidNotificationChannel _channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important _notifications.',
      importance: Importance.high,
      playSound: true);

  static Future init() async {
    final iOS = IOSInitializationSettings();
    final android = AndroidInitializationSettings('app_icon');
    final settings = InitializationSettings(android: android, iOS: iOS);
    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
    _notifications.initialize(settings, onSelectNotification: (payload) async {
      onNotifications.add(payload);
    });
  }

  static void showGoalNotification(String title, String body,
      {int id = 0, String type = "Daily"}) {
    _notifications.show(
        id,
        title,
        body,
        NotificationDetails(
            android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          importance: Importance.high,
          color: FlutterFlowTheme.secondaryColor,
          playSound: true
        )),
        payload: type);
  }
}
