import 'package:rhymer/repositories/notifications/notifications.dart';

abstract interface class NotificationsRepositoryI {
  Future<void> init();
  Future<String?> getToken();
  Future<bool> requestPermisison();
  Future<void> showLocalNotification(Notification notification);
}
