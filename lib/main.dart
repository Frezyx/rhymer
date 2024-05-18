// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:realm/realm.dart';
import 'package:rhymer/api/api.dart';
import 'package:rhymer/bloc/theme/theme_cubit.dart';
import 'package:rhymer/features/favorites/bloc/bloc/favorite_rhymes_bloc.dart';
import 'package:rhymer/features/history/bloc/history_rhymes_bloc.dart';
import 'package:rhymer/features/search/bloc/rhymes_list_bloc.dart';
import 'package:rhymer/firebase_options.dart';
import 'package:rhymer/repositories/favorites/favorites.dart';
import 'package:rhymer/repositories/history/history_repository.dart';
import 'package:rhymer/repositories/history/models/models.dart';
import 'package:rhymer/repositories/settings/settings_repository.dart';
import 'package:rhymer/router/router.dart';
import 'package:rhymer/ui/ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final config = Configuration.local([
    HistoryRhymes.schema,
    FavoriteRhymes.schema,
  ]);
  final realm = Realm(config);
  final prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final messaging = FirebaseMessaging.instance;
  messaging.getToken().then((token) => log(token ?? 'Нет токена'));

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  final androidPlugin =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
  if (androidPlugin != null) {
    await androidPlugin.createNotificationChannel(channel);
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final notification = message.notification;
    final android = message.notification?.android;

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'ic_launcher',
          ),
        ),
      );
    }
  });

  runApp(
    RhymerApp(
      realm: realm,
      preferences: prefs,
    ),
  );
}

class RhymerApp extends StatefulWidget {
  const RhymerApp({
    super.key,
    required this.realm,
    required this.preferences,
  });

  final Realm realm;
  final SharedPreferences preferences;

  @override
  State<RhymerApp> createState() => _RhymerAppState();
}

class _RhymerAppState extends State<RhymerApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    final historyRepository = HistoryRepository(realm: widget.realm);
    final favoritesRepository = FavoritesRepository(realm: widget.realm);
    final settingsRepository = SettingsRepository(
      preferences: widget.preferences,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RhymesListBloc(
            apiClient: RhymerApiClient.create(apiUrl: dotenv.env['API_URL']),
            historyRepository: historyRepository,
            favoritesRepositoryInterface: favoritesRepository,
          ),
        ),
        BlocProvider(
          create: (context) => HistoryRhymesBloc(
            historyRepository: historyRepository,
          ),
        ),
        BlocProvider(
          create: (context) => FavoriteRhymesBloc(
            favoritesRepository: favoritesRepository,
          ),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(
            settingsRepository: settingsRepository,
          ),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Rhymer',
            theme: state.isDark ? darkTheme : lightTheme,
            routerConfig: _router.config(),
          );
        },
      ),
    );
  }
}
