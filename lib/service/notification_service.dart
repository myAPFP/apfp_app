import 'package:rxdart/rxdart.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  /// Provides cross-platform functionality for displaying local notifications.
  static FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static FlutterLocalNotificationsPlugin get notifications => _notifications;

  /// Creates a stream which payloads are stored once a user clicks on
  /// a notification.
  static final onNotifications = BehaviorSubject<String?>();

  /// Settings for Android notification channels.
  static AndroidNotificationChannel _channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important _notifications.',
      importance: Importance.high,
      playSound: true);

  static AndroidNotificationChannel get channel => _channel;

  /// Initializes local notifications for iOS and Android.
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
}
