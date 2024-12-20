import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rhymer/api/api.dart';
import 'package:rhymer/app/app.dart';
import 'package:rhymer/firebase_options.dart';
import 'package:rhymer/utils/database/drift.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final appmetricaKey = dotenv.env["APPMETRICA_KEY"];
  final apiUrl = dotenv.env['API_URL'];

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (appmetricaKey != null) {
    await AppMetrica.activate(AppMetricaConfig(appmetricaKey));
  }

  final prefs = await _initPrefs();
  final database = AppDatabase();
  final talker = TalkerFlutter.init(
    settings: TalkerSettings(
      useConsoleLogs: kDebugMode,
      useHistory: kDebugMode,
    ),
  );
  final apiClient = RhymerApiClient.create(apiUrl: apiUrl, talker: talker);

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: TalkerBlocLoggerSettings(
      printEventFullData: false,
      printStateFullData: false,
    ),
  );

  final config = AppConfig(
    database: database,
    preferences: prefs,
    localNotificationsPlugin: FlutterLocalNotificationsPlugin(),
    firebaseMessaging: FirebaseMessaging.instance,
    talker: talker,
    apiClient: apiClient,
  );

  runApp(RhymerApp(config: config));
}

Future<SharedPreferences> _initPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs;
}
