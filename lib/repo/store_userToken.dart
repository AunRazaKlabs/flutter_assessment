// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

class UserToken {
  UserToken._();

  static const String _userToken = 'userToken';
  static String currentToken = '';

  static Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userToken, token);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    currentToken = prefs.getString(_userToken) ?? '';
    return prefs.getString(_userToken);
  }
}
