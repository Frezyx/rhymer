import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rhymer/api/api.dart';
import 'package:rhymer/utils/database/drift.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker/talker.dart';

class AppConfig {
  AppConfig({
    required this.database,
    required this.preferences,
    required this.localNotificationsPlugin,
    required this.firebaseMessaging,
    required this.talker,
    required this.apiClient,
  });

  final AppDatabase database;
  final SharedPreferences preferences;
  final FlutterLocalNotificationsPlugin localNotificationsPlugin;
  final FirebaseMessaging firebaseMessaging;
  final Talker talker;
  final RhymerApiClient apiClient;
}
