import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:realm/realm.dart';
import 'package:rhymer/utils/database/drift.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  AppConfig({
    required this.realm,
    required this.database,
    required this.preferences,
    required this.localNotificationsPlugin,
    required this.firebaseMessaging,
  });

  final Realm realm;
  final AppDatabase database;
  final SharedPreferences preferences;
  final FlutterLocalNotificationsPlugin localNotificationsPlugin;
  final FirebaseMessaging firebaseMessaging;
}
