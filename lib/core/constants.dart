class AppConstants {
  // SharedPreferences Keys
  static const String keyMorningCompleted = 'morning_completed';
  static const String keyEveningCompleted = 'evening_completed';
  static const String keyLastResetDate = 'last_reset_date';
  static const String keyStreak = 'streak';
  static const String keyThemeMode = 'theme_mode';

  // Custom Adhkar Storage Keys
  static const String keyCustomMorningAdhkar = 'custom_morning_adhkar';
  static const String keyCustomEveningAdhkar = 'custom_evening_adhkar';
  static const String keyMorningAdhkarOrder = 'morning_adhkar_order';
  static const String keyEveningAdhkarOrder = 'evening_adhkar_order';
  static const String keyMorningNotificationTime = 'morning_notification_time';
  static const String keyEveningNotificationTime = 'evening_notification_time';
  static const String keyNotificationsEnabled = 'notifications_enabled';
  static const String keyTransliterationEnabled = 'transliteration_enabled';
  static const String keyArabicFontStyle = 'arabic_font_style';
  static const String keyDeviceUuid = 'device_uuid';

  // Default Notification Times
  static const int defaultMorningHour = 6; // After Fajr
  static const int defaultMorningMinute = 0;
  static const int defaultEveningHour = 16; // After Asr
  static const int defaultEveningMinute = 0;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
}
