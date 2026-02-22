import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme.dart';
import '../providers/hadith_provider.dart';
import '../providers/settings_provider.dart';

class DailyHadithCard extends StatelessWidget {
  const DailyHadithCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final arabicFont = context.watch<SettingsProvider>().arabicFontFamily;

    return Consumer<HadithProvider>(
      builder: (context, hadithProvider, child) {
        if (!hadithProvider.isLoaded || hadithProvider.todaysHadith == null) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppTheme.accentGold,
                ),
              ),
            ),
          );
        }

        final hadith = hadithProvider.todaysHadith!;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [AppTheme.darkCard, AppTheme.darkSurface]
                    : [Colors.white, AppTheme.cream],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppTheme.accentGold.withValues(alpha: 0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.accentGold.withValues(alpha: isDark ? 0.05 : 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.auto_stories,
                        color: AppTheme.accentGold,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Hadith of the Day',
                        style: AppTheme.englishStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.accentGold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Arabic text
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      hadith.arabicText,
                      style: AppTheme.arabicStyle(
                        fontSize: 22,
                        color: isDark ? Colors.white : Colors.black87,
                        fontFamily: arabicFont,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 16),
                  Divider(
                    color: AppTheme.accentGold.withValues(alpha: 0.3),
                    thickness: 0.5,
                  ),
                  const SizedBox(height: 16),

                  // English translation
                  Text(
                    hadith.englishTranslation,
                    style: AppTheme.englishStyle(
                      fontSize: 15,
                      color: isDark ? Colors.grey[300] : Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  if (hadith.narrator.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      hadith.narrator,
                      style: AppTheme.englishStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.grey[500] : Colors.grey[500],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],

                  const SizedBox(height: 16),

                  // Reference badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      hadith.reference,
                      style: AppTheme.englishStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? AppTheme.lightGreen
                            : AppTheme.primaryGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
