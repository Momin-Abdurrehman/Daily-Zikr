import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme.dart';
import '../providers/adhkar_provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey[400] : Colors.grey[600];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Consumer2<SettingsProvider, AdhkarProvider>(
        builder: (context, settingsProvider, adhkarProvider, child) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Theme Section
              _buildSectionHeader('Appearance', textColor),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.brightness_6_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        'Theme',
                        style: AppTheme.englishStyle(
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                      subtitle: Text(
                        _getThemeModeName(settingsProvider.themeMode),
                        style: AppTheme.englishStyle(
                          fontSize: 14,
                          color: subtitleColor,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                      onTap: () => _showThemeDialog(context, settingsProvider),
                    ),
                    const Divider(height: 1),
                    SwitchListTile(
                      secondary: Icon(
                        Icons.translate,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        'Show Transliteration',
                        style: AppTheme.englishStyle(
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                      subtitle: Text(
                        'Display pronunciation guide below Arabic text',
                        style: AppTheme.englishStyle(
                          fontSize: 14,
                          color: subtitleColor,
                        ),
                      ),
                      value: settingsProvider.transliterationEnabled,
                      onChanged: (value) {
                        settingsProvider.setTransliterationEnabled(value);
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: Icon(
                        Icons.font_download_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        'Arabic Font Style',
                        style: AppTheme.englishStyle(
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                      subtitle: Text(
                        _getArabicFontStyleName(settingsProvider.arabicFontStyle),
                        style: AppTheme.englishStyle(
                          fontSize: 14,
                          color: subtitleColor,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                      onTap: () => _showArabicFontDialog(context, settingsProvider),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Notifications Section
              _buildSectionHeader('Notifications', textColor),
              Card(
                child: Column(
                  children: [
                    SwitchListTile(
                      secondary: Icon(
                        Icons.notifications_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        'Enable Notifications',
                        style: AppTheme.englishStyle(
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                      subtitle: Text(
                        'Get reminded to read your adhkar',
                        style: AppTheme.englishStyle(
                          fontSize: 14,
                          color: subtitleColor,
                        ),
                      ),
                      value: settingsProvider.notificationsEnabled,
                      onChanged: (value) {
                        settingsProvider.setNotificationsEnabled(value);
                      },
                    ),
                    if (settingsProvider.notificationsEnabled) ...[
                      const Divider(height: 1),
                      ListTile(
                        leading: Icon(
                          Icons.wb_sunny_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text(
                          'Morning Reminder',
                          style: AppTheme.englishStyle(
                            fontSize: 16,
                            color: textColor,
                          ),
                        ),
                        subtitle: Text(
                          _formatTime(settingsProvider.morningNotificationTime),
                          style: AppTheme.englishStyle(
                            fontSize: 14,
                            color: subtitleColor,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                        onTap: () => _pickTime(
                          context,
                          settingsProvider.morningNotificationTime,
                          (time) => settingsProvider.setMorningNotificationTime(time),
                        ),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: Icon(
                          Icons.nightlight_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text(
                          'Evening Reminder',
                          style: AppTheme.englishStyle(
                            fontSize: 16,
                            color: textColor,
                          ),
                        ),
                        subtitle: Text(
                          _formatTime(settingsProvider.eveningNotificationTime),
                          style: AppTheme.englishStyle(
                            fontSize: 14,
                            color: subtitleColor,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                        onTap: () => _pickTime(
                          context,
                          settingsProvider.eveningNotificationTime,
                          (time) => settingsProvider.setEveningNotificationTime(time),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Progress Section
              _buildSectionHeader('Progress', textColor),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.local_fire_department,
                        color: AppTheme.accentGold,
                      ),
                      title: Text(
                        'Current Streak',
                        style: AppTheme.englishStyle(
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.accentGold.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${adhkarProvider.streak} days',
                          style: AppTheme.englishStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.accentGold,
                          ),
                        ),
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: Icon(
                        Icons.refresh,
                        color: Colors.red[400],
                      ),
                      title: Text(
                        'Reset Progress',
                        style: AppTheme.englishStyle(
                          fontSize: 16,
                          color: Colors.red[400],
                        ),
                      ),
                      subtitle: Text(
                        'Clear all completion data and streak',
                        style: AppTheme.englishStyle(
                          fontSize: 14,
                          color: subtitleColor,
                        ),
                      ),
                      onTap: () => _showResetDialog(context, adhkarProvider),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // About Section
              _buildSectionHeader('About', textColor),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.info_outline,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        'Daily Zikr',
                        style: AppTheme.englishStyle(
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                      subtitle: Text(
                        'Version 1.1.0',
                        style: AppTheme.englishStyle(
                          fontSize: 14,
                          color: subtitleColor,
                        ),
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: Icon(
                        Icons.book_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        'Sources',
                        style: AppTheme.englishStyle(
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                      subtitle: Text(
                        'Hisnul Muslim, Sahih Bukhari, Sahih Muslim',
                        style: AppTheme.englishStyle(
                          fontSize: 14,
                          color: subtitleColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color? textColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: AppTheme.englishStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textColor?.withValues(alpha: 0.6),
        ),
      ),
    );
  }

  String _getThemeModeName(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';
      case AppThemeMode.system:
        return 'System Default';
    }
  }

  String _getArabicFontStyleName(ArabicFontStyle style) {
    switch (style) {
      case ArabicFontStyle.nastaliq:
        return 'Indo-Pak (Nastaliq)';
      case ArabicFontStyle.naskh:
        return 'Standard (Naskh)';
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  void _showThemeDialog(BuildContext context, SettingsProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Choose Theme',
          style: AppTheme.englishStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: AppThemeMode.values.map((mode) {
            return RadioListTile<AppThemeMode>(
              title: Text(_getThemeModeName(mode)),
              value: mode,
              groupValue: provider.themeMode,
              onChanged: (value) {
                if (value != null) {
                  provider.setThemeMode(value);
                  Navigator.pop(context);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showArabicFontDialog(BuildContext context, SettingsProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Arabic Font Style',
          style: AppTheme.englishStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ArabicFontStyle.values.map((style) {
            final fontFamily = style == ArabicFontStyle.nastaliq
                ? 'NotoNastaliqUrdu'
                : 'NotoNaskhArabic';
            return RadioListTile<ArabicFontStyle>(
              title: Text(_getArabicFontStyleName(style)),
              subtitle: Text(
                'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
                style: AppTheme.arabicStyle(
                  fontSize: 16,
                  fontFamily: fontFamily,
                ),
                textDirection: TextDirection.rtl,
              ),
              value: style,
              groupValue: provider.arabicFontStyle,
              onChanged: (value) {
                if (value != null) {
                  provider.setArabicFontStyle(value);
                  Navigator.pop(context);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _pickTime(
    BuildContext context,
    TimeOfDay currentTime,
    Function(TimeOfDay) onPicked,
  ) async {
    final time = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );
    if (time != null) {
      onPicked(time);
    }
  }

  void _showResetDialog(BuildContext context, AdhkarProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Reset Progress?',
          style: AppTheme.englishStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'This will clear all completion data and reset your streak to 0. This action cannot be undone.',
          style: AppTheme.englishStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTheme.englishStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              provider.resetProgress();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Progress has been reset',
                    style: AppTheme.englishStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[400],
              foregroundColor: Colors.white,
            ),
            child: Text(
              'Reset',
              style: AppTheme.englishStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
