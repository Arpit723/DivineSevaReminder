import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_provider.g.dart';

/// Theme mode options for the application
enum ThemeModeOption {
  light('Light Mode'),
  dark('Dark Mode'),
  system('System Default');

  final String label;
  const ThemeModeOption(this.label);
}

/// Theme controller provider - manages theme state
@riverpod
class ThemeController extends _$ThemeController {
  static const String _themeKey = 'app_theme_mode';

  @override
  ThemeModeOption build() {
    // Load saved theme preference
    return _loadThemeMode();
  }

  /// Load theme mode from SharedPreferences
  ThemeModeOption _loadThemeMode() {
    try {
      // This is a synchronous call, but SharedPreferences requires async
      // We'll return system as default and load asynchronously in init
      return ThemeModeOption.system;
    } catch (e) {
      return ThemeModeOption.system;
    }
  }

  /// Initialize theme from persistent storage
  Future<void> initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeString = prefs.getString(_themeKey);

      if (themeString != null) {
        final savedMode = ThemeModeOption.values.firstWhere(
          (mode) => mode.name == themeString,
          orElse: () => ThemeModeOption.system,
        );
        state = savedMode;
      }
    } catch (e) {
      // Keep default system theme
    }
  }

  /// Set theme mode and persist to storage
  Future<void> setTheme(ThemeModeOption mode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeKey, mode.name);
      state = mode;
    } catch (e) {
      // Still update state even if persistence fails
      state = mode;
    }
  }

  /// Toggle between light and dark mode
  Future<void> toggle() async {
    final newMode = state == ThemeModeOption.light
        ? ThemeModeOption.dark
        : ThemeModeOption.light;
    await setTheme(newMode);
  }

  /// Get Flutter ThemeMode from ThemeModeOption
  ThemeMode getThemeMode() {
    switch (state) {
      case ThemeModeOption.light:
        return ThemeMode.light;
      case ThemeModeOption.dark:
        return ThemeMode.dark;
      case ThemeModeOption.system:
        return ThemeMode.system;
    }
  }
}

/// Provider for Flutter ThemeMode
@riverpod
ThemeMode themeMode(ThemeModeRef ref) {
  final controller = ref.watch(themeControllerProvider.notifier);
  return controller.getThemeMode();
}
