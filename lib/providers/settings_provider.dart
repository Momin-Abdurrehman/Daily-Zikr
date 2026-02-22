import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants.dart';
import '../services/notification_service.dart';

enum AppThemeMode { light, dark, system }

enum ArabicFontStyle { nastaliq, naskh }

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
  ArabicFontStyle _arabicFontStyle = ArabicFontStyle.nastaliq;

  AppThemeMode get themeMode => _themeMode;
  TimeOfDay get morningNotificationTime => _morningNotificationTime;
  TimeOfDay get eveningNotificationTime => _eveningNotificationTime;
  bool get notificationsEnabled => _notificationsEnabled;
  bool get transliterationEnabled => _transliterationEnabled;
  ArabicFontStyle get arabicFontStyle => _arabicFontStyle;
  String get arabicFontFamily => _arabicFontStyle == ArabicFontStyle.nastaliq
      ? 'NotoNastaliqUrdu'
      : 'NotoNaskhArabic';

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

    // Load Arabic font style
    final fontStyleIndex = prefs.getInt(AppConstants.keyArabicFontStyle) ?? 0;
    _arabicFontStyle = ArabicFontStyle.values[fontStyleIndex];

    // Notify UI immediately with loaded values before async scheduling
    notifyListeners();

    // Initialize and schedule notifications if enabled (non-web only)
    if (!kIsWeb && _notificationsEnabled) {
      final notifService = NotificationService();
      await notifService.requestPermissions();
      await notifService.scheduleMorningNotification(_morningNotificationTime);
      await notifService.scheduleEveningNotification(_eveningNotificationTime);
    }
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppConstants.keyThemeMode, mode.index);
  }

  Future<void> setMorningNotificationTime(TimeOfDay time) async {
    _morningNotificationTime = time;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      AppConstants.keyMorningNotificationTime,
      '${time.hour}:${time.minute}',
    );

    // Reschedule notification with new time
    if (_notificationsEnabled && !kIsWeb) {
      await NotificationService().scheduleMorningNotification(time);
    }
  }

  Future<void> setEveningNotificationTime(TimeOfDay time) async {
    _eveningNotificationTime = time;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      AppConstants.keyEveningNotificationTime,
      '${time.hour}:${time.minute}',
    );

    // Reschedule notification with new time
    if (_notificationsEnabled && !kIsWeb) {
      await NotificationService().scheduleEveningNotification(time);
    }
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    _notificationsEnabled = enabled;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyNotificationsEnabled, enabled);

    if (!kIsWeb) {
      final notifService = NotificationService();
      if (enabled) {
        // Request permission on Android 13+
        await notifService.requestPermissions();
        // Schedule both notifications
        await notifService.scheduleMorningNotification(_morningNotificationTime);
        await notifService.scheduleEveningNotification(_eveningNotificationTime);
      } else {
        // Cancel all notifications
        await notifService.cancelAllNotifications();
      }
    }
  }

  Future<void> setTransliterationEnabled(bool enabled) async {
    _transliterationEnabled = enabled;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyTransliterationEnabled, enabled);
  }

  Future<void> setArabicFontStyle(ArabicFontStyle style) async {
    _arabicFontStyle = style;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppConstants.keyArabicFontStyle, style.index);
  }
}
