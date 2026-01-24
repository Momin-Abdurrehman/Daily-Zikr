import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';
import '../core/theme.dart';
import '../providers/adhkar_provider.dart';
import 'adhkar_list_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  String _getIslamicDate() {
    final hijri = HijriCalendar.now();
    return '${hijri.hDay} ${hijri.longMonthName} ${hijri.hYear} AH';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final today = DateFormat('EEEE, MMMM d').format(DateTime.now());
    final islamicDate = _getIslamicDate();

    return Scaffold(
      body: SafeArea(
        child: Consumer<AdhkarProvider>(
          builder: (context, adhkarProvider, child) {
            return CustomScrollView(
              slivers: [
                // App Bar
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _getGreeting(),
                              style: AppTheme.englishStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              today,
                              style: AppTheme.englishStyle(
                                fontSize: 16,
                                color: isDark ? Colors.grey[400] : Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              islamicDate,
                              style: AppTheme.englishStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.accentGold,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.settings_outlined,
                            color: isDark ? Colors.white : Colors.black87,
                            size: 28,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SettingsScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Streak Card
                if (adhkarProvider.streak > 0)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.accentGold,
                              AppTheme.accentGold.withOpacity(0.8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.local_fire_department,
                              color: Colors.white,
                              size: 32,
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${adhkarProvider.streak} Day Streak!',
                                  style: AppTheme.englishStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Keep up the good work!',
                                  style: AppTheme.englishStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                const SliverToBoxAdapter(child: SizedBox(height: 24)),

                // Morning Adhkar Card
                SliverToBoxAdapter(
                  child: _buildAdhkarCard(
                    context,
                    title: 'Morning Adhkar',
                    subtitle: 'أذكار الصباح',
                    icon: Icons.wb_sunny_outlined,
                    isCompleted: adhkarProvider.morningCompleted,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdhkarListScreen(
                            isMorning: true,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Evening Adhkar Card
                SliverToBoxAdapter(
                  child: _buildAdhkarCard(
                    context,
                    title: 'Evening Adhkar',
                    subtitle: 'أذكار المساء',
                    icon: Icons.nightlight_outlined,
                    isCompleted: adhkarProvider.eveningCompleted,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdhkarListScreen(
                            isMorning: false,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 40)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAdhkarCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isCompleted,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? AppTheme.lightGreen.withOpacity(0.2)
                        : Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    isCompleted ? Icons.check_circle : icon,
                    color: isCompleted
                        ? AppTheme.lightGreen
                        : Theme.of(context).colorScheme.primary,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTheme.englishStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: AppTheme.arabicStyle(
                          fontSize: 18,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isCompleted
                              ? AppTheme.lightGreen.withOpacity(0.1)
                              : AppTheme.accentGold.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          isCompleted ? '✓ Completed' : 'Tap to read',
                          style: AppTheme.englishStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isCompleted
                                ? AppTheme.lightGreen
                                : AppTheme.accentGold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: isDark ? Colors.grey[600] : Colors.grey[400],
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
