import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rhymer/api/api.dart';
import 'package:rhymer/features/favorites/bloc/bloc/favorite_rhymes_bloc.dart';
import 'package:rhymer/features/history/bloc/history_rhymes_bloc.dart';
import 'package:rhymer/features/search/bloc/rhymes_list_bloc.dart';
import 'package:rhymer/repositories/favorites/favorites.dart';
import 'package:rhymer/repositories/history/history_repository.dart';
import 'package:rhymer/repositories/history/models/models.dart';
import 'package:rhymer/router/router.dart';
import 'package:rhymer/ui/ui.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final config = Configuration.local([
    HistoryRhymes.schema,
    FavoriteRhymes.schema,
  ]);
  final realm = Realm(config);
  runApp(RhymerApp(realm: realm));
}

class RhymerApp extends StatefulWidget {
  const RhymerApp({super.key});

  @override
  State<RhymerApp> createState() => _RhymerAppState();
}

class _RhymerAppState extends State<RhymerApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    final historyRepository = HistoryRepository(realm: widget.realm);
    final favoritesRepository = FavoritesRepository(realm: widget.realm);

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
      ],
      child: MaterialApp.router(
        title: 'Rhymer',
        theme: themeData,
        routerConfig: _router.config(),
      ),
    );
  }
}
