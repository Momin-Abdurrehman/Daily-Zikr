import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants.dart';
import '../data/adhkar_data.dart';
import '../models/dhikr.dart';

class AdhkarProvider extends ChangeNotifier {
  bool _morningCompleted = false;
  bool _eveningCompleted = false;
  int _streak = 0;
  bool _isLoaded = false;

  List<Dhikr> _morningAdhkar = [];
  List<Dhikr> _eveningAdhkar = [];

  bool get morningCompleted => _morningCompleted;
  bool get eveningCompleted => _eveningCompleted;
  int get streak => _streak;
  bool get isLoaded => _isLoaded;

  List<Dhikr> get morningAdhkar => _morningAdhkar;
  List<Dhikr> get eveningAdhkar => _eveningAdhkar;

  AdhkarProvider() {
    _loadData();
  }

  // ---------------------------------------------------------------------------
  // Internal helpers
  // ---------------------------------------------------------------------------

  /// Merge static + custom list and apply saved order.
  List<Dhikr> _buildOrderedList(
    List<Dhikr> staticList,
    List<Dhikr> customList,
    List<String> savedOrder,
  ) {
    final all = [...staticList, ...customList];
    if (savedOrder.isEmpty) return all;

    final mapped = {for (final d in all) d.id: d};
    final ordered = <Dhikr>[];

    for (final id in savedOrder) {
      if (mapped.containsKey(id)) {
        ordered.add(mapped.remove(id)!);
      }
    }
    // Append any new items not yet in the saved order (e.g. after app update)
    ordered.addAll(mapped.values);
    return ordered;
  }

  Future<List<Dhikr>> _loadCustomAdhkar(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);
    if (raw == null || raw.isEmpty) return [];
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((e) => Dhikr.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<String>> _loadOrder(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  Future<void> _saveCustomAdhkar(String key, List<Dhikr> list) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(list.map((d) => d.toJson()).toList()));
  }

  Future<void> _saveOrder(String key, List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, ids);
  }

  // ---------------------------------------------------------------------------
  // Load
  // ---------------------------------------------------------------------------

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();

    final today = DateTime.now().toIso8601String().split('T')[0];
    final lastReset = prefs.getString(AppConstants.keyLastResetDate) ?? '';

    _streak = prefs.getInt(AppConstants.keyStreak) ?? 0;

    if (lastReset != today && lastReset.isNotEmpty) {
      final lastResetDate = DateTime.parse(lastReset);
      final todayDate = DateTime.parse(today);
      final daysSinceLastReset = todayDate.difference(lastResetDate).inDays;

      final lastMorning = prefs.getBool(AppConstants.keyMorningCompleted) ?? false;
      final lastEvening = prefs.getBool(AppConstants.keyEveningCompleted) ?? false;

      if (daysSinceLastReset == 1 && lastMorning && lastEvening) {
        // streak preserved
      } else {
        _streak = 0;
        await prefs.setInt(AppConstants.keyStreak, 0);
      }

      _morningCompleted = false;
      _eveningCompleted = false;
      await prefs.setString(AppConstants.keyLastResetDate, today);
      await prefs.setBool(AppConstants.keyMorningCompleted, false);
      await prefs.setBool(AppConstants.keyEveningCompleted, false);
    } else if (lastReset.isEmpty) {
      _morningCompleted = false;
      _eveningCompleted = false;
      _streak = 0;
      await prefs.setString(AppConstants.keyLastResetDate, today);
      await prefs.setBool(AppConstants.keyMorningCompleted, false);
      await prefs.setBool(AppConstants.keyEveningCompleted, false);
      await prefs.setInt(AppConstants.keyStreak, 0);
    } else {
      _morningCompleted = prefs.getBool(AppConstants.keyMorningCompleted) ?? false;
      _eveningCompleted = prefs.getBool(AppConstants.keyEveningCompleted) ?? false;
    }

    // Load custom adhkar and saved orders
    final customMorning = await _loadCustomAdhkar(AppConstants.keyCustomMorningAdhkar);
    final customEvening = await _loadCustomAdhkar(AppConstants.keyCustomEveningAdhkar);
    final morningOrder = await _loadOrder(AppConstants.keyMorningAdhkarOrder);
    final eveningOrder = await _loadOrder(AppConstants.keyEveningAdhkarOrder);

    _morningAdhkar = _buildOrderedList(AdhkarData.morningAdhkar, customMorning, morningOrder);
    _eveningAdhkar = _buildOrderedList(AdhkarData.eveningAdhkar, customEvening, eveningOrder);

    _isLoaded = true;
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Custom Adhkar CRUD
  // ---------------------------------------------------------------------------

  Future<void> addCustomDhikr(Dhikr dhikr) async {
    if (dhikr.category == 'morning') {
      _morningAdhkar = [..._morningAdhkar, dhikr];
      final customOnly = _morningAdhkar.where((d) => d.isCustom).toList();
      await _saveCustomAdhkar(AppConstants.keyCustomMorningAdhkar, customOnly);
      await _saveOrder(AppConstants.keyMorningAdhkarOrder, _morningAdhkar.map((d) => d.id).toList());
    } else {
      _eveningAdhkar = [..._eveningAdhkar, dhikr];
      final customOnly = _eveningAdhkar.where((d) => d.isCustom).toList();
      await _saveCustomAdhkar(AppConstants.keyCustomEveningAdhkar, customOnly);
      await _saveOrder(AppConstants.keyEveningAdhkarOrder, _eveningAdhkar.map((d) => d.id).toList());
    }
    notifyListeners();
  }

  Future<void> deleteCustomDhikr(String id, bool isMorning) async {
    if (isMorning) {
      _morningAdhkar = _morningAdhkar.where((d) => d.id != id).toList();
      final customOnly = _morningAdhkar.where((d) => d.isCustom).toList();
      await _saveCustomAdhkar(AppConstants.keyCustomMorningAdhkar, customOnly);
      await _saveOrder(AppConstants.keyMorningAdhkarOrder, _morningAdhkar.map((d) => d.id).toList());
    } else {
      _eveningAdhkar = _eveningAdhkar.where((d) => d.id != id).toList();
      final customOnly = _eveningAdhkar.where((d) => d.isCustom).toList();
      await _saveCustomAdhkar(AppConstants.keyCustomEveningAdhkar, customOnly);
      await _saveOrder(AppConstants.keyEveningAdhkarOrder, _eveningAdhkar.map((d) => d.id).toList());
    }
    notifyListeners();
  }

  Future<void> reorderAdhkar(int oldIndex, int newIndex, bool isMorning) async {
    if (isMorning) {
      final list = [..._morningAdhkar];
      final item = list.removeAt(oldIndex);
      list.insert(newIndex, item);
      _morningAdhkar = list;
      await _saveOrder(AppConstants.keyMorningAdhkarOrder, list.map((d) => d.id).toList());
    } else {
      final list = [..._eveningAdhkar];
      final item = list.removeAt(oldIndex);
      list.insert(newIndex, item);
      _eveningAdhkar = list;
      await _saveOrder(AppConstants.keyEveningAdhkarOrder, list.map((d) => d.id).toList());
    }
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Completion & streak
  // ---------------------------------------------------------------------------

  Future<void> markMorningComplete() async {
    if (_morningCompleted) return;
    _morningCompleted = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyMorningCompleted, true);
    if (_morningCompleted && _eveningCompleted) {
      _streak++;
      await prefs.setInt(AppConstants.keyStreak, _streak);
    }
    notifyListeners();
  }

  Future<void> markEveningComplete() async {
    if (_eveningCompleted) return;
    _eveningCompleted = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyEveningCompleted, true);
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

  Future<void> refresh() async {
    _isLoaded = false;
    notifyListeners();
    await _loadData();
  }
}
