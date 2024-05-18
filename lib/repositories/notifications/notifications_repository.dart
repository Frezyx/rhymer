import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rhymer/repositories/notifications/notifications.dart';

class NotificationsRepository implements NotificationsRepositoryI {
  NotificationsRepository({
    required FlutterLocalNotificationsPlugin localNotifications,
    required FirebaseMessaging firebaseMessaging,
  })  : _localNotifications = localNotifications,
        _firebaseMessaging = firebaseMessaging;

  final FlutterLocalNotificationsPlugin _localNotifications;
  final FirebaseMessaging _firebaseMessaging;

  static const _defaultChannel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  @override
  Future<String?> getToken() => _firebaseMessaging.getToken();

  @override
  Future<bool> requestPermisison() async {
    final settings = await _firebaseMessaging.requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  @override
  Future<void> init() async {
    final androidPlugin =
        _localNotifications.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin != null) {
      await androidPlugin.createNotificationChannel(_defaultChannel);
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      final android = message.notification?.android;

      if (notification != null && android != null) {}
    });
  }

  @override
  Future<void> showLocalNotification(Notification notification) async {
    await _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.message,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _defaultChannel.id,
          _defaultChannel.name,
          channelDescription: _defaultChannel.description,
          icon: 'ic_launcher',
        ),
      ),
    );
  }
}
