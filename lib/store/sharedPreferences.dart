import 'package:shared_preferences/shared_preferences.dart';

/// 数据持久化方法
///
/// 使用 SharedPreferences 处理数据持久化
class PersistentState {
  // 存储
  static saveState(String key, dynamic value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  // 删除
  static removeState(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(key);
  }
  
  // 获取
  static getState(String key) async {
    var _key;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _key = sharedPreferences.getString(key);
    return _key;
  }
}
