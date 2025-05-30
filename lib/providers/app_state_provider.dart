// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateProvider with ChangeNotifier {
  static const String _hasSeenOnboardingKey = "has_seen_onboarding";
  bool _hasSeenOnboarding = false;
  bool _isInitialized = false;

  bool get hasSeenOnboaring => _hasSeenOnboarding;
  bool get isInitialized => _isInitialized;

  Future<void> initializeApp() async {
    if (_isInitialized) return;

    final prefs = await SharedPreferences.getInstance();
    _hasSeenOnboarding = prefs.getBool(_hasSeenOnboardingKey) ?? false;
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> setOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    _hasSeenOnboarding = true;
    notifyListeners();
  }
}
