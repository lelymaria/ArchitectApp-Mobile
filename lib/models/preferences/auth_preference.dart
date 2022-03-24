import 'dart:convert';

import 'package:architect_app/models/responses/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPreference {
  Future<void> setUserData(dynamic userData) async {
    final prefs = await SharedPreferences.getInstance();
    Map userDataJson = userData.toJson();
    await prefs.setString("user_data", jsonEncode(userDataJson));
    return;
  }

  Future<User> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String userDataJson = prefs.getString("user_data");
    Map userData = jsonDecode(userDataJson);
    return User.fromJson(userData);
    // return userData;
  }

  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
    return;
  }

  Future<bool> hasToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get("token") == null ? false : true;
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  Future<void> deleteAuthData() async {
    await Future.delayed(Duration(seconds: 1));
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("user_data");
    await prefs.remove("token");
  }
}
