// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:rhymer/app/app_config.dart';
import 'package:rhymer/repositories/favorites/favorites.dart';
import 'package:rhymer/repositories/history/history.dart';
import 'package:rhymer/repositories/notifications/notifications.dart';
import 'package:rhymer/repositories/rhymes/rhymes.dart';
import 'package:rhymer/repositories/settings/settings.dart';

class RepositoryContainer {
  const RepositoryContainer({
    required this.historyRepository,
    required this.favoritesRepository,
    required this.settingsRepository,
    required this.notificationsRepository,
    required this.rhymesRepository,
  });

  final HistoryRepositoryI historyRepository;
  final FavoritesRepositoryI favoritesRepository;
  final SettingsRepositoryI settingsRepository;
  final NotificationsRepositoryI notificationsRepository;
  final RhymesRepositoryI rhymesRepository;

  factory RepositoryContainer.prod({
    required AppConfig config,
  }) =>
      RepositoryContainer(
        historyRepository: HistoryRepository(db: config.database),
        favoritesRepository: FavoritesRepository(db: config.database),
        settingsRepository: SettingsRepository(preferences: config.preferences),
        rhymesRepository: RhymesRepository(apiClient: config.apiClient),
        notificationsRepository: NotificationsRepository(
          localNotifications: config.localNotificationsPlugin,
          firebaseMessaging: config.firebaseMessaging,
        ),
      );
}
