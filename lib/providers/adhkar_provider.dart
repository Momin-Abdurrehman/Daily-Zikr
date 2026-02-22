import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants.dart';
import '../data/adhkar_data.dart';
import '../models/dhikr.dart';

class AdhkarProvider extends ChangeNotifier {
  bool _morningCompleted = false;
  bool _eveningCompleted = false;
  int _streak = 0;
  String _lastResetDate = '';
  bool _isLoaded = false;

  bool get morningCompleted => _morningCompleted;
  bool get eveningCompleted => _eveningCompleted;
  int get streak => _streak;
  bool get isLoaded => _isLoaded;

  List<Dhikr> get morningAdhkar => AdhkarData.morningAdhkar;
  List<Dhikr> get eveningAdhkar => AdhkarData.eveningAdhkar;

  AdhkarProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Get today's date
    final today = DateTime.now().toIso8601String().split('T')[0];
    final lastReset = prefs.getString(AppConstants.keyLastResetDate) ?? '';
    
    // Load saved streak first
    _streak = prefs.getInt(AppConstants.keyStreak) ?? 0;
    
    if (lastReset != today && lastReset.isNotEmpty) {
      // Check how many days have passed since last reset
      final lastResetDate = DateTime.parse(lastReset);
      final todayDate = DateTime.parse(today);
      final daysSinceLastReset = todayDate.difference(lastResetDate).inDays;

      final lastMorning = prefs.getBool(AppConstants.keyMorningCompleted) ?? false;
      final lastEvening = prefs.getBool(AppConstants.keyEveningCompleted) ?? false;

      if (daysSinceLastReset == 1 && lastMorning && lastEvening) {
        // Exactly yesterday and fully completed - preserve streak
      } else {
        // Missed a day or last day wasn't completed - reset streak
        _streak = 0;
        await prefs.setInt(AppConstants.keyStreak, 0);
      }
      
      // Reset completion for new day
      _morningCompleted = false;
      _eveningCompleted = false;
      _lastResetDate = today;
      
      await prefs.setString(AppConstants.keyLastResetDate, today);
      await prefs.setBool(AppConstants.keyMorningCompleted, false);
      await prefs.setBool(AppConstants.keyEveningCompleted, false);
    } else if (lastReset.isEmpty) {
      // First time using app
      _morningCompleted = false;
      _eveningCompleted = false;
      _lastResetDate = today;
      _streak = 0;
      
      await prefs.setString(AppConstants.keyLastResetDate, today);
      await prefs.setBool(AppConstants.keyMorningCompleted, false);
      await prefs.setBool(AppConstants.keyEveningCompleted, false);
      await prefs.setInt(AppConstants.keyStreak, 0);
    } else {
      // Same day - load saved state
      _morningCompleted = prefs.getBool(AppConstants.keyMorningCompleted) ?? false;
      _eveningCompleted = prefs.getBool(AppConstants.keyEveningCompleted) ?? false;
      _lastResetDate = lastReset;
    }
    
    _isLoaded = true;
    notifyListeners();
  }

  Future<void> markMorningComplete() async {
    if (_morningCompleted) return; // Already completed
    
    _morningCompleted = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyMorningCompleted, true);
    
    // Check if BOTH now completed - update streak (only once)
    if (_morningCompleted && _eveningCompleted) {
      _streak++;
      await prefs.setInt(AppConstants.keyStreak, _streak);
    }
    
    notifyListeners();
  }

  Future<void> markEveningComplete() async {
    if (_eveningCompleted) return; // Already completed
    
    _eveningCompleted = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyEveningCompleted, true);
    
    // Check if BOTH now completed - update streak (only once)
    if (_morningCompleted && _eveningCompleted) {
      _streak++;
      await prefs.setInt(AppConstants.keyStreak, _streak);
    }
    
    notifyListeners();
  }

  Future<void> resetProgress() async {
    _morningCompleted = false;
    _eveningCompleted = false;
    _streak = 0;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyMorningCompleted, false);
    await prefs.setBool(AppConstants.keyEveningCompleted, false);
    await prefs.setInt(AppConstants.keyStreak, 0);
    
    notifyListeners();
  }
  
  // Force refresh data (useful for debugging)
  Future<void> refresh() async {
    _isLoaded = false;
    notifyListeners();
    await _loadData();
  }
}
