import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:realm/realm.dart';
import 'package:rhymer/app/app.dart';
import 'package:rhymer/firebase_options.dart';
import 'package:rhymer/repositories/history/models/models.dart';
import 'package:rhymer/utils/database/drift.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final realm = _initRealm();
  final prefs = await _initPrefs();
  final database = AppDatabase();

  final config = AppConfig(
    realm: realm,
    database: database,
    preferences: prefs,
    localNotificationsPlugin: FlutterLocalNotificationsPlugin(),
    firebaseMessaging: FirebaseMessaging.instance,
  );
  runApp(RhymerApp(config: config));
}

Future<SharedPreferences> _initPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs;
}

Realm _initRealm() {
  final realmConfig = Configuration.local([HistoryRhymes.schema]);
  final realm = Realm(realmConfig);
  return realm;
}
