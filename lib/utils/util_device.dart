import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:ju_flutter/utils/util_log.dart';

/// 设备信息(含版本信息)
class UtilDevice {
  /// 定义
  ///
  /// [_utilDevice]单例对象
  /// [_deviceInfoPlugin]设备信息
  /// [_androidDeviceInfo]安卓设备信息
  /// [_iosDeviceInfo]ios设备信息
  static UtilDevice _utilDevice = UtilDevice._internal(); // 内部
  static DeviceInfoPlugin _deviceInfoPlugin;
  static AndroidDeviceInfo _androidDeviceInfo;
  static IosDeviceInfo _iosDeviceInfo;

  /// 工厂构造方法（这里使用命名构造函数方式进行声明）。
  factory UtilDevice() => _utilDevice;

  /// 单例内部构造方法(此写法可避免外部暴露构造函数，并进行实例化)。
  UtilDevice._internal() {
    if (_deviceInfoPlugin == null) {
      // 初始化
      initDeviceInfo();
    }
  }

  /// 初始化 android/ios 信息
  Future<void> initDeviceInfo() async {
    _deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo _androidInfo = await _deviceInfoPlugin.androidInfo;
      _androidDeviceInfo = _androidInfo;
    }
    if (Platform.isIOS) {
      IosDeviceInfo _iosInfo = await _deviceInfoPlugin.iosInfo;
      _iosDeviceInfo = _iosInfo;
    }
  }

  /// 导出安卓设备信息
  static get getAndroidInfo => _androidDeviceInfo;

  /// 导出 ios 设备信息
  static get getIosInfo => _iosDeviceInfo;
}
