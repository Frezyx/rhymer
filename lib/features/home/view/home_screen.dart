import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rhymer/router/router.dart';
import 'package:rhymer/ui/ui.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BannerAd banner;
  var isBannerAlreadyCreated = false;

  _loadAd() async {
    banner = _createBanner();
    setState(() {
      isBannerAlreadyCreated = true;
    });
    // if banner was already created you can just call:
    banner.loadAd(adRequest: const AdRequest());
  }

  BannerAdSize _getAdSize() {
    return BannerAdSize.inline(width: 500, maxHeight: 100);
  }

  _createBanner() {
    return BannerAd(
        adUnitId: 'demo-banner-yandex', // or 'demo-banner-yandex'
        adSize: _getAdSize(),
        adRequest: const AdRequest(),
        onAdLoaded: () {
          // The ad was loaded successfully. Now it will be shown.
        },
        onAdFailedToLoad: (error) {
          // Ad failed to load with AdRequestError.
          // Attempting to load a new ad from the onAdFailedToLoad() method is strongly discouraged.
        },
        onAdClicked: () {
          // Called when a click is recorded for an ad.
        },
        onLeftApplication: () {
          // Called when user is about to leave application (e.g., to go to the browser), as a result of clicking on the ad.
        },
        onReturnedToApplication: () {
          // Called when user returned to application after click.
        },
        onImpression: (impressionData) {
          // Called when an impression is recorded for an ad.
        });
  }

  @override
  initState() {
    super.initState();
    MobileAds.initialize();
    _loadAd();
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
        return Stack(
          children: [
            Scaffold(
              body: child,
              bottomNavigationBar: PlatformNavigationBar(
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
            ),
            if (isBannerAlreadyCreated)
              Align(
                alignment: Alignment.bottomCenter,
                child: AdWidget(bannerAd: banner),
              ),
          ],
        );
      },
    );
  }

  void _openPage(int index, TabsRouter tabsRouter) {
    tabsRouter.setActiveIndex(index);
  }
}
