import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme.dart';
import '../models/dhikr.dart';
import '../providers/settings_provider.dart';

class DhikrCard extends StatefulWidget {
  final Dhikr dhikr;
  final int index;

  const DhikrCard({
    super.key,
    required this.dhikr,
    required this.index,
  });

  @override
  State<DhikrCard> createState() => _DhikrCardState();
}

class _DhikrCardState extends State<DhikrCard> {
  bool _showFazail = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey[400] : Colors.grey[600];
    final settingsProvider = context.watch<SettingsProvider>();
    final showTransliteration = settingsProvider.transliterationEnabled;
    final arabicFont = settingsProvider.arabicFontFamily;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header with index and repetitions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${widget.index + 1}',
                    style: AppTheme.englishStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.accentGold.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${widget.dhikr.repetitions}×',
                    style: AppTheme.englishStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.accentGold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Arabic Text
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                widget.dhikr.arabicText,
                style: AppTheme.arabicStyle(
                  fontSize: 26,
                  color: textColor,
                  fontFamily: arabicFont,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            // Transliteration (conditional)
            if (showTransliteration && widget.dhikr.transliteration.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                widget.dhikr.transliteration,
                style: AppTheme.englishStyle(
                  fontSize: 14,
                  color: subtitleColor,
                  fontWeight: FontWeight.w500,
                ).copyWith(fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ],
            
            const SizedBox(height: 16),
            
            // Divider
            Divider(
              color: subtitleColor?.withValues(alpha: 0.3),
              thickness: 1,
            ),
            
            const SizedBox(height: 16),
            
            // English Translation
            Text(
              widget.dhikr.englishTranslation,
              style: AppTheme.englishStyle(
                fontSize: 15,
                color: subtitleColor,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 12),
            
            // Reference
            Text(
              widget.dhikr.reference,
              style: AppTheme.englishStyle(
                fontSize: 12,
                color: subtitleColor?.withValues(alpha: 0.7),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            // Virtue Button
            InkWell(
              onTap: () {
                setState(() {
                  _showFazail = !_showFazail;
                });
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppTheme.accentGold.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.accentGold.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _showFazail ? Icons.expand_less : Icons.auto_awesome,
                      color: AppTheme.accentGold,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _showFazail ? 'Hide Virtue' : 'Show Virtue (Fazilah)',
                      style: AppTheme.englishStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.accentGold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Expandable Fazail Section
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              crossFadeState: _showFazail 
                  ? CrossFadeState.showSecond 
                  : CrossFadeState.showFirst,
              firstChild: const SizedBox.shrink(),
              secondChild: Container(
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.accentGold.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          color: AppTheme.accentGold,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Virtue (Fazilah)',
                          style: AppTheme.englishStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.accentGold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.dhikr.fazail,
                      style: AppTheme.englishStyle(
                        fontSize: 14,
                        color: textColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
