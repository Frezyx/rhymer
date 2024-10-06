import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhymer/app/app.dart';
import 'package:rhymer/app/repository_container.dart';
import 'package:rhymer/bloc/theme/theme_cubit.dart';
import 'package:rhymer/features/favorites/bloc/bloc/favorite_rhymes_bloc.dart';
import 'package:rhymer/features/history/bloc/history_rhymes_bloc.dart';
import 'package:rhymer/features/search/bloc/rhymes_list_bloc.dart';
import 'package:rhymer/repositories/favorites/favorites.dart';
import 'package:rhymer/repositories/history/history_repository_interface.dart';
import 'package:rhymer/repositories/notifications/notifications.dart';
import 'package:rhymer/repositories/rhymes/rhymes.dart';
import 'package:rhymer/repositories/settings/settings.dart';

class AppInitializer extends StatelessWidget {
  const AppInitializer({
    super.key,
    required this.child,
    required this.config,
    required this.repositoryContainer,
  });

  final Widget child;
  final AppConfig config;
  final RepositoryContainer repositoryContainer;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<HistoryRepositoryI>(
          create: (context) => repositoryContainer.historyRepository,
        ),
        RepositoryProvider<FavoritesRepositoryI>(
          create: (context) => repositoryContainer.favoritesRepository,
        ),
        RepositoryProvider<SettingsRepositoryI>(
          create: (context) => repositoryContainer.settingsRepository,
        ),
        RepositoryProvider<NotificationsRepositoryI>(
          create: (context) => repositoryContainer.notificationsRepository,
        ),
        RepositoryProvider<RhymesRepositoryI>(
          create: (context) => repositoryContainer.rhymesRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RhymesListBloc(
              rhymesRepository: context.read<RhymesRepositoryI>(),
              historyRepository: context.read<HistoryRepositoryI>(),
              favoritesRepositoryInterface:
                  context.read<FavoritesRepositoryI>(),
            ),
          ),
          BlocProvider(
            create: (context) => HistoryRhymesBloc(
              historyRepository: context.read<HistoryRepositoryI>(),
            ),
          ),
          BlocProvider(
            create: (context) => FavoriteRhymesBloc(
              favoritesRepository: context.read<FavoritesRepositoryI>(),
            ),
          ),
          BlocProvider(
            create: (context) => ThemeCubit(
              settingsRepository: context.read<SettingsRepositoryI>(),
            ),
          ),
        ],
        child: child,
      ),
    );
  }
}
