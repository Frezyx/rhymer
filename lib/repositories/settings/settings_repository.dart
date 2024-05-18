import 'package:rhymer/repositories/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository implements SettingsRepositoryI {
  SettingsRepository({
    required this.preferences,
  });

  final SharedPreferences preferences;

  static const _isDarkThemeSelectedKey = 'dark_theme_selected';

  @override
  bool isDarkThemeSelected() {
    final selected = preferences.getBool(_isDarkThemeSelectedKey);
    return selected ?? false;
  }

  @override
  Future<void> setDarkThemeSelected(bool selected) async {
    await preferences.setBool(_isDarkThemeSelectedKey, selected);
  }
}
