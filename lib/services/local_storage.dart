import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _authTokenKey = 'auth_token';
  static const String _userEmailKey = 'user_email';
  static const String _rememberMeKey = 'remember_me';

  static const String _userDataKey = 'user_data';

  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userDataKey, jsonEncode(userData));
  }

  static Future<Map<String, dynamic>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString(_userDataKey);
    if (userDataString != null) {
      return jsonDecode(userDataString);
    }
    return {};
  }

  static Future<SharedPreferences?> _getInstance() async {
    try {
      return await SharedPreferences.getInstance();
    } on MissingPluginException catch (_) {
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<void> saveAuthData(
    String token,
    String email,
    bool rememberMe,
  ) async {
    final prefs = await _getInstance();
    if (prefs == null) return;
    await prefs.setString(_authTokenKey, token);
    await prefs.setString(_userEmailKey, email);
    await prefs.setBool(_rememberMeKey, rememberMe);
  }

  static Future<Map<String, dynamic>> getAuthData() async {
    final prefs = await _getInstance();
    if (prefs == null) return {};
    return {
      'token': prefs.getString(_authTokenKey) ?? '',
      'email': prefs.getString(_userEmailKey) ?? '',
      'rememberMe': prefs.getBool(_rememberMeKey) ?? false,
    };
  }

  static Future<void> clearAuthData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_authTokenKey);
      await prefs.remove(_userEmailKey);
      await prefs.remove(_rememberMeKey);
    } catch (e, stackTrace) {
      print('Error clearing auth data: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  static Future<void> clearUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userDataKey);
    } catch (e, stackTrace) {
      print('Error clearing user data: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }
}
