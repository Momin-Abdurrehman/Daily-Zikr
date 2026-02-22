import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme.dart';
import '../data/adhkar_data.dart';
import '../models/dhikr.dart';
import '../providers/settings_provider.dart';

class FazailScreen extends StatefulWidget {
  const FazailScreen({super.key});

  @override
  State<FazailScreen> createState() => _FazailScreenState();
}

class _FazailScreenState extends State<FazailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fazail (Virtues)'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.accentGold,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: const [
            Tab(text: 'Morning'),
            Tab(text: 'Evening'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFazailList(AdhkarData.morningAdhkar, isDark),
          _buildFazailList(AdhkarData.eveningAdhkar, isDark),
        ],
      ),
    );
  }

  Widget _buildFazailList(List<Dhikr> adhkarList, bool isDark) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: adhkarList.length,
      itemBuilder: (context, index) {
        final dhikr = adhkarList[index];
        return _FazailCard(
          dhikr: dhikr,
          index: index,
          isDark: isDark,
        );
      },
    );
  }
}

class _FazailCard extends StatelessWidget {
  final Dhikr dhikr;
  final int index;
  final bool isDark;

  const _FazailCard({
    required this.dhikr,
    required this.index,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey[400] : Colors.grey[600];
    final arabicFont = context.watch<SettingsProvider>().arabicFontFamily;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        childrenPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: AppTheme.englishStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        title: Text(
          _getShortTitle(dhikr.arabicText),
          style: AppTheme.arabicStyle(
            fontSize: 18,
            color: textColor,
            fontFamily: arabicFont,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textDirection: TextDirection.rtl,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            'Repeat ${dhikr.repetitions}× - ${dhikr.reference}',
            style: AppTheme.englishStyle(
              fontSize: 12,
              color: subtitleColor,
            ),
          ),
        ),
        children: [
          // Arabic Text
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                dhikr.arabicText,
                style: AppTheme.arabicStyle(
                  fontSize: 20,
                  color: textColor,
                  fontFamily: arabicFont,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Translation
          Text(
            dhikr.englishTranslation,
            style: AppTheme.englishStyle(
              fontSize: 14,
              color: subtitleColor,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),
          
          Divider(color: subtitleColor?.withValues(alpha: 0.3)),
          
          const SizedBox(height: 16),

          // Fazail Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.accentGold.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.accentGold.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      color: AppTheme.accentGold,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Virtue (Fazilah)',
                      style: AppTheme.englishStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.accentGold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  dhikr.fazail,
                  style: AppTheme.englishStyle(
                    fontSize: 14,
                    color: textColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Reference
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu_book_outlined,
                size: 16,
                color: subtitleColor,
              ),
              const SizedBox(width: 8),
              Text(
                dhikr.reference,
                style: AppTheme.englishStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: subtitleColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getShortTitle(String arabicText) {
    // Get first line or first 50 characters
    final firstLine = arabicText.split('\n').first;
    if (firstLine.length > 50) {
      return '${firstLine.substring(0, 50)}...';
    }
    return firstLine;
  }
}
