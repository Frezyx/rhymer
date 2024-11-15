import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhymer/bloc/theme/theme_cubit.dart';
import 'package:rhymer/router/router.dart';
import 'package:rhymer/ui/ui.dart';
import 'package:rhymer/utils/advertising/advertising_service.dart';
import 'package:rhymer/utils/analytics/analytics_service.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BannerAd _banner;
  var _isBannerAlreadyCreated = false;

  @override
  initState() {
    super.initState();
    _initMobileAdd();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        SearchRoute(),
        FavoritesRoute(),
        HistoryRoute(),
        SettingsRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_isBannerAlreadyCreated)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AdWidget(bannerAd: _banner),
                ),
              PlatformNavigationBar(
                tabsRouter: tabsRouter,
                onSelect: (index) => _openPage(index, tabsRouter),
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Поиск',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Избранное',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.history),
                    label: 'История',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Настройки',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _openPage(int index, TabsRouter tabsRouter) {
    tabsRouter.setActiveIndex(index);
    final tabRoutes = tabsRouter.routeCollection.routes.toList();
    final path = tabRoutes[index].path;
    Analytics.i.logScreenView('/$path');
  }

  Future<void> _initMobileAdd() async {
    await MobileAds.initialize();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAd();
    });
  }

  Future<void> _loadAd() async {
    final talker = context.read<Talker>();
    final brightness = context.read<ThemeCubit>().state.brightness;
    final advertising = AdvertisingService(
      brightness: brightness,
      talker: talker,
    );

    final bannerId = advertising.bannerId1;
    if (bannerId == null) {
      talker.warning('empty banner id in ENV');
      return;
    }

    _banner = advertising.createBanner(
      adUnitId: bannerId,
      size: _getAdSize(),
    );
    setState(() => _isBannerAlreadyCreated = true);
    await _banner.loadAd(adRequest: advertising.createAdRequest());
  }

  BannerAdSize _getAdSize() {
    final mq = MediaQuery.maybeOf(context);
    final width = mq?.size.width.toInt() ?? 500;
    return BannerAdSize.inline(width: width, maxHeight: 100);
  }
}
