import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _local = FlutterLocalNotificationsPlugin();

  Future<void> initLocalNotification() async {
    const androidSettings =
    AndroidInitializationSettings('@drawable/ic_notification');

    const iosSettings = DarwinInitializationSettings();

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _local.initialize(settings);
  }

  Future<void> setupNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    await _local
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  void listenFCMMessages() {
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        _showNotification(
          title: message.notification!.title,
          body: message.notification!.body,
        );
      }
    });
  }

  Future<void> _showNotification({
    required String? title,
    required String? body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@drawable/ic_notification',
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _local.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      notificationDetails,
    );
  }
}
