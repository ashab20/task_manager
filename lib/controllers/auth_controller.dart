import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/models/user_model.dart';

class AuthController {
  static String? token;
  static UserMOdel? user;
  Future<void> saveUserInfo(String t, UserMOdel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', t);
    await sharedPreferences.setString('user', jsonEncode(model.toJson()));
    token = t;
    user = model;
  }

  Future<void> initializaUserCache() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
    user = UserMOdel.fromJson(
        jsonDecode(sharedPreferences.getString('user') ?? '{}'));
  }

  Future<bool> isLoginUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    if (token != null) {
      await initializaUserCache();
      return true;
    }
    return false;
  }
}
