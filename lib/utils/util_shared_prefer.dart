import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

/// 本地持久化存储（键值对）
class UtilSharedPrefer {
  static SharedPreferences _sp;
  static UtilSharedPrefer _instance;

  UtilSharedPrefer._();

  static Future<UtilSharedPrefer> getInstance() async {
    if (_instance == null) {
      _instance = UtilSharedPrefer._();
    }
    if (_sp == null) {
      _sp = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  static SharedPreferences getSp() {
    return _sp;
  }
}
