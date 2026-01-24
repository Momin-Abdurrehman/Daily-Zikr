import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants.dart';

enum AppThemeMode { light, dark, system }

class SettingsProvider extends ChangeNotifier {
  AppThemeMode _themeMode = AppThemeMode.system;
  TimeOfDay _morningNotificationTime = const TimeOfDay(
    hour: AppConstants.defaultMorningHour,
    minute: AppConstants.defaultMorningMinute,
  );
  TimeOfDay _eveningNotificationTime = const TimeOfDay(
    hour: AppConstants.defaultEveningHour,
    minute: AppConstants.defaultEveningMinute,
  );
  bool _notificationsEnabled = true;
  bool _transliterationEnabled = true; // Show transliteration by default

  AppThemeMode get themeMode => _themeMode;
  TimeOfDay get morningNotificationTime => _morningNotificationTime;
  TimeOfDay get eveningNotificationTime => _eveningNotificationTime;
  bool get notificationsEnabled => _notificationsEnabled;
  bool get transliterationEnabled => _transliterationEnabled;

  ThemeMode get materialThemeMode {
    switch (_themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    // Load theme mode
    final themeModeIndex = prefs.getInt(AppConstants.keyThemeMode) ?? 2;
    _themeMode = AppThemeMode.values[themeModeIndex];

    // Load notification times
    final morningTime = prefs.getString(AppConstants.keyMorningNotificationTime);
    if (morningTime != null) {
      final parts = morningTime.split(':');
      _morningNotificationTime = TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
    }

    final eveningTime = prefs.getString(AppConstants.keyEveningNotificationTime);
    if (eveningTime != null) {
      final parts = eveningTime.split(':');
      _eveningNotificationTime = TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
    }

    // Load notifications enabled
    _notificationsEnabled = prefs.getBool(AppConstants.keyNotificationsEnabled) ?? true;
    
    // Load transliteration enabled
    _transliterationEnabled = prefs.getBool(AppConstants.keyTransliterationEnabled) ?? true;

    notifyListeners();
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    _themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppConstants.keyThemeMode, mode.index);
    notifyListeners();
  }

  Future<void> setMorningNotificationTime(TimeOfDay time) async {
    _morningNotificationTime = time;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      AppConstants.keyMorningNotificationTime,
      '${time.hour}:${time.minute}',
    );
    notifyListeners();
  }

  Future<void> setEveningNotificationTime(TimeOfDay time) async {
    _eveningNotificationTime = time;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      AppConstants.keyEveningNotificationTime,
      '${time.hour}:${time.minute}',
    );
    notifyListeners();
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    _notificationsEnabled = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyNotificationsEnabled, enabled);
    notifyListeners();
  }

  Future<void> setTransliterationEnabled(bool enabled) async {
    _transliterationEnabled = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyTransliterationEnabled, enabled);
    notifyListeners();
  }
}
