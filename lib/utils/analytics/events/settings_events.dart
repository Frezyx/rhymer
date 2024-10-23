import 'package:flutter/foundation.dart';
import 'package:rhymer/utils/analytics/analytics_service.dart';

class SettingsEvents {
  const SettingsEvents();

  final openSupport = 'open_support';
  final clearHistory = 'clear_history';

  final _selectLightTheme = 'select_light_theme';
  final _selectDarkTheme = 'select_dark_theme';

  void selectTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    Analytics.i.log(isDark ? _selectDarkTheme : _selectLightTheme);
  }
}
