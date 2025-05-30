// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  static const String _isLoggedInKey = "is_logged_in";
  static const String _userEmailKey = "user_email";
  static const String _userNameKey = "user_name";
  static const String _userPasswordKey = "user_password";

  bool _isLoggedIn = false;
  bool _isLoading = false;
  String? _userEmail;
  String? _userName;
  String? _errorMessage;

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  String? get userEmail => _userEmail;
  String? get userName => _userName;
  String? get errorMessage => _errorMessage;

  Future<void> initializeAuth() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;
    if (_isLoggedIn) {
      _userEmail = prefs.getString(_userEmailKey);
      _userName = prefs.getString(_userNameKey);
    }
    notifyListeners();
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await Future.delayed(Duration(seconds: 1));
      if (password.length < 6) {
        throw Exception("Password must be atleast 6 characters long");
      }
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setString(_userEmailKey, email);
      await prefs.setString(_userNameKey, email.split("@")[0]);

      _isLoggedIn = true;
      _userEmail = email;
      _userName = email.split("@")[0];
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp(String email, String password, String userName) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      // network delay

      await Future.delayed(Duration(seconds: 1));

      if (password.length < 6) {
        throw Exception("Password must be at least 6 characters long");
      }

      if (userName.isEmpty) {
        throw Exception("Name can\t be empty");
      }

      if (!email.contains("@")) {
        throw Exception("Please enter a valid email");
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setString(_userEmailKey, email);
      await prefs.setString(_userNameKey, userName);

      _isLoggedIn = true;
      _userEmail = email;
      _userName = userName;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await Future.delayed(Duration(seconds: 1));

      if (!email.contains("@")) {
        throw Exception("Please enter a valid email");
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
