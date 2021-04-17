import 'package:shared_preferences/shared_preferences.dart';

/// 数据持久化方法
class UtilSharedPref {
  static SharedPreferences _sharedPref;
  static UtilSharedPref _utilSharedPref;

  UtilSharedPref._();

  static Future<UtilSharedPref> getUtilSharedPref() async {
    if (_utilSharedPref == null) {
      _utilSharedPref = UtilSharedPref._();
    }
    if (_sharedPref == null) {
      _sharedPref = await SharedPreferences.getInstance();
    }
    return _utilSharedPref;
  }

  static SharedPreferences sharedPref() {
    return _sharedPref;
  }
}
