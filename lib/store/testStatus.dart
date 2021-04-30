import 'package:flutter/foundation.dart';

/// 跨部件状态共享
///
/// 主要用来处理一些多部件的状态保存，和 shared_preferences 有区别。
/// shared_preferences 是本地保存，这种方式是多部件共享的状态。
class TestState with ChangeNotifier {
  /// 定义
  bool test = false;

  /// 获取
  bool get isTest => test;

  /// 设置
  void setTest() {
    test = !test;
    notifyListeners();
  }
}
