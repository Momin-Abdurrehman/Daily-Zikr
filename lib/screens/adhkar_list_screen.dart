import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme.dart';
import '../providers/adhkar_provider.dart';
import '../widgets/dhikr_card.dart';
import '../widgets/progress_header.dart';

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
          final isCompleted = isMorning
              ? adhkarProvider.morningCompleted
              : adhkarProvider.eveningCompleted;

          return Column(
            children: [
              // Header
              ProgressHeader(
                title: isMorning ? 'Morning Adhkar' : 'Evening Adhkar',
                isCompleted: isCompleted,
              ),

              // Adhkar List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 16, bottom: 100),
                  itemCount: adhkarList.length,
                  itemBuilder: (context, index) {
                    return DhikrCard(
                      dhikr: adhkarList[index],
                      index: index,
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

          if (isCompleted) {
            return const SizedBox.shrink();
          }

          return FloatingActionButton.extended(
            onPressed: () {
              _showCompletionDialog(context, adhkarProvider);
            },
            icon: const Icon(Icons.check),
            label: Text(
              'Mark as Complete',
              style: AppTheme.englishStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).floatingActionButtonTheme.foregroundColor,
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showCompletionDialog(BuildContext context, AdhkarProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: AppTheme.lightGreen,
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              'Well Done!',
              style: AppTheme.englishStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Complete',
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
              style: AppTheme.englishStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.lightGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
