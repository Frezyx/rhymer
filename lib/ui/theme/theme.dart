import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const _primaryColor = Color(0xFFF82B10);

final darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: _primaryColor,
  textTheme: _textTheme,
  scaffoldBackgroundColor: Colors.black,
  colorScheme: ColorScheme.fromSeed(
    seedColor: _primaryColor,
    brightness: Brightness.dark,
  ),
);

final lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: _primaryColor,
  textTheme: _textTheme,
  scaffoldBackgroundColor: const Color(0xFFEFF1F3),
  dividerTheme: DividerThemeData(
    color: Colors.grey.withOpacity(0.1),
  ),
  // snackBarTheme: SnackBarThemeData(
  //   backgroundColor: _primaryColor,
  // ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: _primaryColor,
    brightness: Brightness.light,
    surface: Colors.white,
  ),
);

const _textTheme = TextTheme(
  titleMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  ),
  headlineLarge: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
  ),
);

extension ThemePlatformExtension on ThemeData {
  bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;
  bool get isCupertino => [TargetPlatform.iOS, TargetPlatform.macOS]
      .contains(defaultTargetPlatform);
  Color get cupertinoAlertColor => const Color(0xFFF82B10);
  Color get cupertinoActionColor => const Color(0xFF3478F7);
}
