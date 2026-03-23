import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme.dart';
import '../models/dhikr.dart';
import '../providers/settings_provider.dart';

class DhikrCard extends StatefulWidget {
  final Dhikr dhikr;
  final int index;
  /// Non-null only for custom (user-added) items.
  final VoidCallback? onDelete;
  /// Non-null only for built-in items — hides the dhikr from the list.
  final VoidCallback? onHide;

  const DhikrCard({
    super.key,
    required this.dhikr,
    required this.index,
    this.onDelete,
    this.onHide,
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
            // Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left-side: drag handle + index badge
                Row(
                  children: [
                    // Drag handle — only this region initiates reorder drag
                    ReorderableDragStartListener(
                      index: widget.index,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Icon(
                          Icons.drag_handle_rounded,
                          color: isDark ? Colors.grey[600] : Colors.grey[400],
                          size: 24,
                        ),
                      ),
                    ),

                    // Index badge
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
                  ],
                ),

                // Right-side: custom badge + repetitions
                Row(
                  children: [
                    // "My Dua" badge for custom entries
                    if (widget.dhikr.isCustom) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppTheme.accentGold.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppTheme.accentGold.withValues(alpha: 0.4)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star_rounded, size: 13, color: AppTheme.accentGold),
                            const SizedBox(width: 4),
                            Text(
                              'My Dua',
                              style: AppTheme.englishStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.accentGold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],

                    // Repetitions badge
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
              ],
            ),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                widget.dhikr.title,
                style: AppTheme.englishStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),

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

            // Transliteration
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
            Divider(color: subtitleColor?.withValues(alpha: 0.3), thickness: 1),
            const SizedBox(height: 16),

            // English Translation
            Text(
              widget.dhikr.englishTranslation,
              style: AppTheme.englishStyle(fontSize: 15, color: subtitleColor),
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

            // Bottom row: Virtue button + optional Delete button
            Row(
              children: [
                // Virtue button occupies remaining space
                Expanded(
                  child: InkWell(
                    onTap: widget.dhikr.fazail.isEmpty
                        ? null
                        : () => setState(() => _showFazail = !_showFazail),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: widget.dhikr.fazail.isEmpty
                            ? Colors.transparent
                            : AppTheme.accentGold.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: widget.dhikr.fazail.isEmpty
                            ? null
                            : Border.all(color: AppTheme.accentGold.withValues(alpha: 0.3)),
                      ),
                      child: widget.dhikr.fazail.isEmpty
                          ? const SizedBox.shrink()
                          : Row(
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
                ),

                // Action button — eye-off for built-in, delete for custom
                if (widget.onHide != null || widget.onDelete != null) ...[
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: widget.onDelete ?? widget.onHide,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: widget.onDelete != null
                            ? Colors.redAccent.withValues(alpha: 0.1)
                            : Colors.grey.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: widget.onDelete != null
                              ? Colors.redAccent.withValues(alpha: 0.3)
                              : Colors.grey.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Icon(
                        widget.onDelete != null
                            ? Icons.delete_outline_rounded
                            : Icons.visibility_off_outlined,
                        color: widget.onDelete != null ? Colors.redAccent : Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ],
            ),

            // Expandable Fazail Section
            if (widget.dhikr.fazail.isNotEmpty)
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                crossFadeState:
                    _showFazail ? CrossFadeState.showSecond : CrossFadeState.showFirst,
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
                          const Icon(Icons.auto_awesome, color: AppTheme.accentGold, size: 18),
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
