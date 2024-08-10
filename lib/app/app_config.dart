import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:realm/realm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  AppConfig({
    required this.realm,
    required this.preferences,
    required this.localNotificationsPlugin,
    required this.firebaseMessaging,
  });

  final Realm realm;
  final SharedPreferences preferences;
  final FlutterLocalNotificationsPlugin localNotificationsPlugin;
  final FirebaseMessaging firebaseMessaging;
}
