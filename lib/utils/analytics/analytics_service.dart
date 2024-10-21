import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:rhymer/utils/analytics/analytics.dart';

class Analytics implements AnalyticsI {
  Analytics._();

  static Analytics get i => _analytics;
  static final Analytics _analytics = Analytics._();

  @override
  Future<void> log(String name) async {
    await AppMetrica.reportEvent(name);
  }

  @override
  RouteObserver<ModalRoute> get observer => throw UnimplementedError();
}
