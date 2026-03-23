import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme.dart';
import '../providers/adhkar_provider.dart';
import '../widgets/dhikr_card.dart';
import '../widgets/progress_header.dart';
import 'add_custom_dhikr_screen.dart';

class AdhkarListScreen extends StatelessWidget {
  final bool isMorning;

  const AdhkarListScreen({
    super.key,
    required this.isMorning,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AdhkarProvider>(
        builder: (context, adhkarProvider, child) {
          final adhkarList = isMorning
              ? adhkarProvider.morningAdhkar
              : adhkarProvider.eveningAdhkar;
          final hiddenList = isMorning
              ? adhkarProvider.hiddenMorningAdhkar
              : adhkarProvider.hiddenEveningAdhkar;
          final isCompleted = isMorning
              ? adhkarProvider.morningCompleted
              : adhkarProvider.eveningCompleted;

          return Column(
            children: [
              // Header + optional restore icon
              Stack(
                children: [
                  ProgressHeader(
                    title: isMorning ? 'Morning Adhkar' : 'Evening Adhkar',
                    isCompleted: isCompleted,
                  ),
                  if (hiddenList.isNotEmpty)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: SafeArea(
                        child: Tooltip(
                          message: '${hiddenList.length} hidden supplication${hiddenList.length > 1 ? 's' : ''}',
                          child: InkWell(
                            onTap: () => _showRestoreSheet(context, adhkarProvider, hiddenList),
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.visibility_off_outlined, size: 16, color: Colors.white),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${hiddenList.length}',
                                    style: AppTheme.englishStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              // Adhkar List (reorderable)
              Expanded(
                child: ReorderableListView.builder(
                  padding: const EdgeInsets.only(top: 16, bottom: 120),
                  itemCount: adhkarList.length,
                  onReorder: (oldIndex, newIndex) {
                    if (newIndex > oldIndex) newIndex -= 1;
                    adhkarProvider.reorderAdhkar(oldIndex, newIndex, isMorning);
                  },
                  buildDefaultDragHandles: false,
                  proxyDecorator: (child, index, animation) =>
                      Material(color: Colors.transparent, child: child),
                  itemBuilder: (context, index) {
                    final dhikr = adhkarList[index];
                    return ReorderableDragStartListener(
                      key: ValueKey(dhikr.id),
                      index: index,
                      child: DhikrCard(
                        dhikr: dhikr,
                        index: index,
                        // Custom items get permanent delete
                        onDelete: dhikr.isCustom
                            ? () => _confirmDelete(context, adhkarProvider, dhikr.id)
                            : null,
                        // Built-in items get a hide (eye-off) button
                        onHide: !dhikr.isCustom
                            ? () => _confirmHide(context, adhkarProvider, dhikr.id, dhikr.title)
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Consumer<AdhkarProvider>(
        builder: (context, adhkarProvider, child) {
          final isCompleted = isMorning
              ? adhkarProvider.morningCompleted
              : adhkarProvider.eveningCompleted;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                heroTag: 'add_dhikr_fab',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddCustomDhikrScreen(isMorning: isMorning),
                  ),
                ),
                tooltip: 'Add supplication',
                backgroundColor: AppTheme.accentGold,
                foregroundColor: Colors.white,
                elevation: 4,
                child: const Icon(Icons.add),
              ),
              if (!isCompleted) ...[
                const SizedBox(width: 16),
                FloatingActionButton.extended(
                  heroTag: 'complete_fab',
                  onPressed: () => _showCompletionDialog(context, adhkarProvider),
                  icon: const Icon(Icons.check),
                  label: Text(
                    'Mark as Complete',
                    style: AppTheme.englishStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).floatingActionButtonTheme.foregroundColor,
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // ---------------------------------------------------------------------------
  // Hide confirmation
  // ---------------------------------------------------------------------------

  void _confirmHide(BuildContext context, AdhkarProvider provider, String id, String title) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.visibility_off_outlined, size: 24),
            const SizedBox(width: 10),
            Text('Hide Supplication?',
                style: AppTheme.englishStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text(
          '"$title" will be hidden from your list. You can restore it at any time.',
          style: AppTheme.englishStyle(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: AppTheme.englishStyle(fontSize: 15, color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              provider.hideBuiltInDhikr(id, isMorning);
              Navigator.pop(ctx);
            },
            child: Text('Hide', style: AppTheme.englishStyle(fontSize: 15, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Restore bottom sheet
  // ---------------------------------------------------------------------------

  void _showRestoreSheet(BuildContext context, AdhkarProvider provider, List hiddenList) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Consumer<AdhkarProvider>(
        builder: (ctx, p, _) {
          final hidden = isMorning ? p.hiddenMorningAdhkar : p.hiddenEveningAdhkar;
          return DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.3,
            maxChildSize: 0.85,
            expand: false,
            builder: (_, scrollController) => Column(
              children: [
                // Handle bar
                const SizedBox(height: 12),
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Icon(Icons.visibility_off_outlined, size: 22),
                      const SizedBox(width: 10),
                      Text(
                        'Hidden Supplications',
                        style: AppTheme.englishStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${hidden.length}',
                          style: AppTheme.englishStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Divider(),
                if (hidden.isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.check_circle_outline, size: 48, color: Colors.grey),
                          const SizedBox(height: 12),
                          Text('All supplications are visible',
                              style: AppTheme.englishStyle(fontSize: 15, color: Colors.grey)),
                        ],
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.separated(
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      itemCount: hidden.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (_, i) {
                        final d = hidden[i];
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          title: Text(d.title,
                              style: AppTheme.englishStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600)),
                          subtitle: Text(
                            d.arabicText.length > 40
                                ? '${d.arabicText.substring(0, 40)}...'
                                : d.arabicText,
                            style: AppTheme.arabicStyle(fontSize: 14, color: Colors.grey),
                            textDirection: TextDirection.rtl,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: TextButton.icon(
                            onPressed: () => p.restoreDhikr(d.id, isMorning),
                            icon: const Icon(Icons.visibility_outlined, size: 18),
                            label: const Text('Restore'),
                            style: TextButton.styleFrom(
                              foregroundColor: AppTheme.primaryGreen,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Delete (custom adhkar)
  // ---------------------------------------------------------------------------

  void _confirmDelete(BuildContext context, AdhkarProvider provider, String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Delete Supplication?',
            style: AppTheme.englishStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        content: Text(
          'This custom supplication will be permanently removed.',
          style: AppTheme.englishStyle(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: AppTheme.englishStyle(fontSize: 15, color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              provider.deleteCustomDhikr(id, isMorning);
              Navigator.pop(ctx);
            },
            child: Text('Delete', style: AppTheme.englishStyle(fontSize: 15, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Complete dialog
  // ---------------------------------------------------------------------------

  void _showCompletionDialog(BuildContext context, AdhkarProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: AppTheme.lightGreen, size: 28),
            const SizedBox(width: 12),
            Text('Well Done!',
                style: AppTheme.englishStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text(
          isMorning
              ? 'Mark your morning adhkar as complete?'
              : 'Mark your evening adhkar as complete?',
          style: AppTheme.englishStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: AppTheme.englishStyle(fontSize: 16, color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              if (isMorning) {
                provider.markMorningComplete();
              } else {
                provider.markEveningComplete();
              }
              Navigator.pop(context);
              _showSuccessSnackbar(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Complete',
                style: AppTheme.englishStyle(
                    fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showSuccessSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.celebration, color: Colors.white),
            const SizedBox(width: 12),
            Text(
              isMorning
                  ? 'Morning adhkar completed! بارك الله فيك'
                  : 'Evening adhkar completed! بارك الله فيك',
              style: AppTheme.englishStyle(fontSize: 14, color: Colors.white),
            ),
          ],
        ),
        backgroundColor: AppTheme.lightGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
