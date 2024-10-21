import 'package:rhymer/utils/analytics/events/ads_events.dart';
import 'package:rhymer/utils/analytics/events/favorite_events.dart';

abstract class AnalyticsEvents {
  static const favorites = FavoriteEvents();
  static const ads = AdsEvents();
}
