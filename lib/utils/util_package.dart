import 'package:package_info/package_info.dart';

/// 版本信息
class UtilPackage {
  /// 定义
  ///
  /// [_httpDio]单例对象
  /// [_packageInfo]版本信息
  static UtilPackage _utilPackage = UtilPackage._internal(); // 内部
  static PackageInfo _packageInfo;

  /// 工厂构造方法
  factory UtilPackage() => _utilPackage; // 实例

  /// 单例内部构造方法
  UtilPackage._internal() {
    if (_packageInfo == null) {
      // 初始化
      initPackageInfo();
    }
  }

  /// 获取设备信息
  Future initPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  /// 导出版本信息
  static get getPackageInfo => _packageInfo;
}
