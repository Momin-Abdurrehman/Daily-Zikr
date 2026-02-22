import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants.dart';
import '../models/hadith.dart';

class HadithProvider extends ChangeNotifier {
  List<Hadith> _allHadith = [];
  Hadith? _todaysHadith;
  bool _isLoaded = false;
  String _deviceUuid = '';

  Hadith? get todaysHadith => _todaysHadith;
  bool get isLoaded => _isLoaded;

  HadithProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    await _loadHadithData();
    await _ensureDeviceUuid();
    _selectTodaysHadith();
    _isLoaded = true;
    notifyListeners();
  }

  Future<void> _loadHadithData() async {
    final jsonString = await rootBundle.loadString('assets/data/hadith.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    _allHadith = jsonList.map((j) => Hadith.fromJson(j as Map<String, dynamic>)).toList();
  }

  Future<void> _ensureDeviceUuid() async {
    final prefs = await SharedPreferences.getInstance();
    _deviceUuid = prefs.getString(AppConstants.keyDeviceUuid) ?? '';
    if (_deviceUuid.isEmpty) {
      _deviceUuid = _generateUniqueId();
      await prefs.setString(AppConstants.keyDeviceUuid, _deviceUuid);
    }
  }

  String _generateUniqueId() {
    final now = DateTime.now();
    final seed = now.microsecondsSinceEpoch;
    final hash1 = seed.toRadixString(36);
    final hash2 = (seed * 31 + identityHashCode(this)).toRadixString(36);
    return '$hash1-$hash2';
  }

  void _selectTodaysHadith() {
    if (_allHadith.isEmpty) return;

    final today = DateTime.now();
    final dateString = '${today.year}-${today.month}-${today.day}';
    final combinedSeed = '$_deviceUuid:$dateString';

    final index = combinedSeed.hashCode.abs() % _allHadith.length;
    _todaysHadith = _allHadith[index];
  }
}
