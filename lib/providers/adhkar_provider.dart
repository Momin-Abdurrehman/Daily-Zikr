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

  // All ordered items (visible + hidden)
  List<Dhikr> _allMorningAdhkar = [];
  List<Dhikr> _allEveningAdhkar = [];

  // IDs the user has chosen to hide (built-in only)
  Set<String> _hiddenMorningIds = {};
  Set<String> _hiddenEveningIds = {};

  bool get morningCompleted => _morningCompleted;
  bool get eveningCompleted => _eveningCompleted;
  int get streak => _streak;
  bool get isLoaded => _isLoaded;

  /// Visible (non-hidden) adhkar
  List<Dhikr> get morningAdhkar =>
      _allMorningAdhkar.where((d) => !_hiddenMorningIds.contains(d.id)).toList();
  List<Dhikr> get eveningAdhkar =>
      _allEveningAdhkar.where((d) => !_hiddenEveningIds.contains(d.id)).toList();

  /// Hidden built-in items (for the Restore sheet)
  List<Dhikr> get hiddenMorningAdhkar =>
      _allMorningAdhkar.where((d) => _hiddenMorningIds.contains(d.id)).toList();
  List<Dhikr> get hiddenEveningAdhkar =>
      _allEveningAdhkar.where((d) => _hiddenEveningIds.contains(d.id)).toList();

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

    // Load custom adhkar, saved orders, and hidden IDs
    final customMorning = await _loadCustomAdhkar(AppConstants.keyCustomMorningAdhkar);
    final customEvening = await _loadCustomAdhkar(AppConstants.keyCustomEveningAdhkar);
    final morningOrder = await _loadOrder(AppConstants.keyMorningAdhkarOrder);
    final eveningOrder = await _loadOrder(AppConstants.keyEveningAdhkarOrder);

    _allMorningAdhkar = _buildOrderedList(AdhkarData.morningAdhkar, customMorning, morningOrder);
    _allEveningAdhkar = _buildOrderedList(AdhkarData.eveningAdhkar, customEvening, eveningOrder);

    final hiddenMorning = await _loadOrder(AppConstants.keyHiddenMorningIds);
    final hiddenEvening = await _loadOrder(AppConstants.keyHiddenEveningIds);
    _hiddenMorningIds = hiddenMorning.toSet();
    _hiddenEveningIds = hiddenEvening.toSet();

    _isLoaded = true;
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Custom Adhkar CRUD
  // ---------------------------------------------------------------------------

  Future<void> addCustomDhikr(Dhikr dhikr) async {
    if (dhikr.category == 'morning') {
      _allMorningAdhkar = [..._allMorningAdhkar, dhikr];
      final customOnly = _allMorningAdhkar.where((d) => d.isCustom).toList();
      await _saveCustomAdhkar(AppConstants.keyCustomMorningAdhkar, customOnly);
      await _saveOrder(AppConstants.keyMorningAdhkarOrder, _allMorningAdhkar.map((d) => d.id).toList());
    } else {
      _allEveningAdhkar = [..._allEveningAdhkar, dhikr];
      final customOnly = _allEveningAdhkar.where((d) => d.isCustom).toList();
      await _saveCustomAdhkar(AppConstants.keyCustomEveningAdhkar, customOnly);
      await _saveOrder(AppConstants.keyEveningAdhkarOrder, _allEveningAdhkar.map((d) => d.id).toList());
    }
    notifyListeners();
  }

  Future<void> deleteCustomDhikr(String id, bool isMorning) async {
    if (isMorning) {
      _allMorningAdhkar = _allMorningAdhkar.where((d) => d.id != id).toList();
      final customOnly = _allMorningAdhkar.where((d) => d.isCustom).toList();
      await _saveCustomAdhkar(AppConstants.keyCustomMorningAdhkar, customOnly);
      await _saveOrder(AppConstants.keyMorningAdhkarOrder, _allMorningAdhkar.map((d) => d.id).toList());
    } else {
      _allEveningAdhkar = _allEveningAdhkar.where((d) => d.id != id).toList();
      final customOnly = _allEveningAdhkar.where((d) => d.isCustom).toList();
      await _saveCustomAdhkar(AppConstants.keyCustomEveningAdhkar, customOnly);
      await _saveOrder(AppConstants.keyEveningAdhkarOrder, _allEveningAdhkar.map((d) => d.id).toList());
    }
    notifyListeners();
  }

  /// Reorder operates on the *visible* list, then we rebuild the full all-list order.
  Future<void> reorderAdhkar(int oldIndex, int newIndex, bool isMorning) async {
    if (isMorning) {
      // Work on the visible (non-hidden) slice
      final visible = morningAdhkar;
      final item = visible.removeAt(oldIndex);
      visible.insert(newIndex, item);
      // Rebuild _allMorningAdhkar preserving hidden items at their relative positions
      _allMorningAdhkar = _mergeReorderedVisible(visible, _allMorningAdhkar, _hiddenMorningIds);
      await _saveOrder(AppConstants.keyMorningAdhkarOrder, _allMorningAdhkar.map((d) => d.id).toList());
    } else {
      final visible = eveningAdhkar;
      final item = visible.removeAt(oldIndex);
      visible.insert(newIndex, item);
      _allEveningAdhkar = _mergeReorderedVisible(visible, _allEveningAdhkar, _hiddenEveningIds);
      await _saveOrder(AppConstants.keyEveningAdhkarOrder, _allEveningAdhkar.map((d) => d.id).toList());
    }
    notifyListeners();
  }

  /// Re-inserts hidden items at their previous positions within the new visible order.
  List<Dhikr> _mergeReorderedVisible(
    List<Dhikr> newVisible,
    List<Dhikr> previousAll,
    Set<String> hiddenIds,
  ) {
    final hiddenItems = previousAll.where((d) => hiddenIds.contains(d.id)).toList();
    // Simple strategy: hidden items go at the end (they're not shown anyway)
    return [...newVisible, ...hiddenItems];
  }

  // ---------------------------------------------------------------------------
  // Hide / Restore built-in Adhkar
  // ---------------------------------------------------------------------------

  Future<void> hideBuiltInDhikr(String id, bool isMorning) async {
    if (isMorning) {
      _hiddenMorningIds = {..._hiddenMorningIds, id};
      await _saveOrder(AppConstants.keyHiddenMorningIds, _hiddenMorningIds.toList());
    } else {
      _hiddenEveningIds = {..._hiddenEveningIds, id};
      await _saveOrder(AppConstants.keyHiddenEveningIds, _hiddenEveningIds.toList());
    }
    notifyListeners();
  }

  Future<void> restoreDhikr(String id, bool isMorning) async {
    if (isMorning) {
      _hiddenMorningIds = _hiddenMorningIds.difference({id});
      await _saveOrder(AppConstants.keyHiddenMorningIds, _hiddenMorningIds.toList());
    } else {
      _hiddenEveningIds = _hiddenEveningIds.difference({id});
      await _saveOrder(AppConstants.keyHiddenEveningIds, _hiddenEveningIds.toList());
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
