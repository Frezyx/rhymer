import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

class AdvertisingService {
  AdvertisingService({
    required this.talker,
    required this.brightness,
  });

  final Talker talker;
  final Brightness brightness;

  String? get bannerId1 {
    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final bannerId = isAndroid
        ? dotenv.env['Y1_BANNER_ANDROID']
        : dotenv.env['Y1_BANNER_IOS'];
    return bannerId;
  }

  BannerAd createBanner({
    required String adUnitId,
    required BannerAdSize size,
  }) {
    return BannerAd(
      adUnitId: adUnitId,
      // adUnitId: 'demo-banner-yandex', // or 'demo-banner-yandex'
      adSize: size,

      onAdLoaded: () {},
      onAdFailedToLoad: talker.handle,
    );
  }

  AdRequest createAdRequest() => AdRequest(
        preferredTheme:
            brightness == Brightness.dark ? AdTheme.dark : AdTheme.light,
      );
}
