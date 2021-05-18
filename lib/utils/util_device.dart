import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';

/// 设备信息
class UtilDevice {
  /// 定义
  ///
  /// [_deviceInfoPlugin]设备信息
  /// [_androidDeviceInfo]安卓设备信息
  /// [_iosDeviceInfo]ios设备信息
  /// [_packageInfo]版本信息
  static DeviceInfoPlugin _deviceInfoPlugin;
  static AndroidDeviceInfo _androidDeviceInfo;
  static IosDeviceInfo _iosDeviceInfo;
  static PackageInfo _packageInfo;

  factory UtilDevice() {
    return initDeviceInfo();
  }

  /// 导出
  get androidDeviceInfo => _androidDeviceInfo;
  get iosDeviceInfo => _iosDeviceInfo;
  get packageInfo => _packageInfo;

  /// 初始化
  ///
  /// [_deviceInfoPlugin]获取设备信息
  /// [_packageInfo]获取版本信息
  static initDeviceInfo() async {
    _deviceInfoPlugin = DeviceInfoPlugin();
    _packageInfo = await PackageInfo.fromPlatform();
    if (Platform.isAndroid) {
      _androidDeviceInfo = await _deviceInfoPlugin.androidInfo ?? '';
    }
    if (Platform.isIOS) {
      _iosDeviceInfo = await _deviceInfoPlugin.iosInfo ?? '';
    }
  }
}
