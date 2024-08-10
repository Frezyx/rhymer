abstract interface class SettingsRepositoryI {
  bool isDarkThemeSelected();
  Future<void> setDarkThemeSelected(bool selected);
}
