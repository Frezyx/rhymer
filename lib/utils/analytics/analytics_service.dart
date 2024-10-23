import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:rhymer/utils/analytics/analytics.dart';
import 'package:rhymer/utils/formatters/formatters.dart';

class Analytics implements AnalyticsI {
  Analytics._();

  static Analytics get i => _analytics;
  static final Analytics _analytics = Analytics._();

  static const favorites = FavoriteEvents();
  static const ads = AdsEvents();
  static const settings = SettingsEvents();
  static const history = HistoryEvents();

  final _firebaseAnalytics = FirebaseAnalytics.instance;

  @override
  RouteObserver<ModalRoute> get observer => FirebaseAnalyticsObserver(
        analytics: _firebaseAnalytics,
        nameExtractor: (settings) {
          final baseName = settings.name?.replaceAll('Route', '');
          if (baseName == null) return null;

          final newPath = StringFormatter.camelCaseToKebab(baseName);
          return '/$newPath';
        },
      );

  @override
  void log(String name) {
    _logAppMetrica(name);
    _logFirebase(name);
  }

  @override
  void logScreenView(String screenName) =>
      _firebaseAnalytics.logScreenView(screenName: screenName);

  void _logFirebase(String name) {
    try {
      _firebaseAnalytics.logEvent(name: name);
    } catch (_) {
      // pass...
    }
  }

  void _logAppMetrica(String name) {
    try {
      AppMetrica.reportEvent(name);
    } catch (_) {
      // pass...
    }
  }
}
