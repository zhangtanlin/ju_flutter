import 'package:flutter/foundation.dart';

/// 通知冒泡（Notificationg Bubbling）
/// 子节点向父节点传递 Notification。不仅能够提供数据供子孙节点使用，还可以在数据改变的时候通知所有听众刷新。
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
