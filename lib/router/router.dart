import 'package:auto_route/auto_route.dart';
import 'package:rhymer/features/favorites/favorites.dart';
import 'package:rhymer/features/history/history.dart';
import 'package:rhymer/features/home/home.dart';
import 'package:rhymer/features/search/search.dart';
import 'package:rhymer/features/settings/settings.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          path: '/',
          children: [
            AutoRoute(
              page: SearchRoute.page,
              path: 'search',
            ),
            AutoRoute(
              page: FavoritesRoute.page,
              path: 'favorites',
            ),
            AutoRoute(
              page: HistoryRoute.page,
              path: 'poems',
            ),
            AutoRoute(
              page: SettingsRoute.page,
              path: 'settings',
            ),
          ],
        ),
      ];
}
