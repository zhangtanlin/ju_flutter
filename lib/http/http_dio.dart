import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ju_flutter/config/network.dart';
import 'package:ju_flutter/global/global.dart';
import 'package:ju_flutter/utils/util_device.dart';

/// 构造 http 请求类
///
/// 注意1：如果起了后端服务，用以测试需要使用ip地址进行访问。
/// 注意2：如果是本地安卓测试，需要在"android/app/src/main/AndroidManifest.xml"路径文件的
/// application标签内补充参数 android:usesCleartextTraffic="true" 表示全局允许不安全/HTTP请求。
/// 注意3：在iOS上的整个应用程序中全局允许不安全/ HTTP请求，您可以将其添加到主字典定义下的ios/Runner/info.plist中：
/// ```
/// <key>NSAppTransportSecurity</key>
/// <dict>
///   <key>NSAllowsArbitraryLoads</key>
///   <true/>
/// </dict>
/// ```
/// 参考文档： [https://www.cnblogs.com/sundaysme/p/12624185.html]
class HttpDio {
  /// 定义
  ///
  /// [_dio]dio
  /// [_baseOptions]dio基础参数信息
  /// [_basicParams]dio的post方法基础参数
  /// [_packageInfo]版本信息
  static HttpDio _instance = HttpDio._internal();
  Dio _dio;
  BaseOptions _baseOptions;
  Map<String, dynamic> _basicParams;

  /// 初始化方法
  factory HttpDio() => _instance;

  /// 通用全局单例，第一次使用时初始化
  HttpDio._internal() {
    if (_dio == null) {
      _setBasicParams();
      var options = BaseOptions(
        baseUrl: Network.devApi[0],
        connectTimeout: 5000,
        receiveTimeout: 3000,
      );
      _dio = Dio(options);
    }
  }

  /// 判定是否有 baseUrl
  static HttpDio getInstance({String url}) {
    if (url == null) {
      return _instance._setNormal();
    } else {
      return _instance._setBasicUrl(url);
    }
  }

  /// 设置默认域名
  HttpDio _setNormal() {
    if (_dio != null) {
      if (_dio.options.baseUrl != Network.devApi[0]) {
        _dio.options.baseUrl = Network.devApi[0];
      }
    }
    return this;
  }

  /// 指定特定域名，比如 cdn 或者首次 http 请求
  HttpDio _setBasicUrl(String url) {
    if (_dio != null) {
      _dio.options.baseUrl = url;
    }
    return this;
  }

  /// 设置公共参数
  Map<String, dynamic> _setBasicParams() {
    Map<String, dynamic> tempBasicParams = {};
    if (Platform.isAndroid) {
      tempBasicParams['oauth_id'] = UtilDevice().androidDeviceInfo;
      tempBasicParams['version'] = UtilDevice().packageInfo.version;
    }
    if (Platform.isIOS) {}
    String tempToken = Global.token;
    tempBasicParams['token'] = tempToken;
    tempBasicParams['oauth_type'] = '${Platform.isAndroid ? 'android' : 'ios'}';
    _basicParams = tempBasicParams;
    return tempBasicParams;
  }

  /// get方法
  get(String url,
      {Map<String, dynamic> querys = const {}, noTip = false}) async {
    Response response;
    try {
      response = await _dio.get(url, queryParameters: querys);
    } catch (e) {
      return null;
    }
    return response.data;
  }

  /// post方法
  post(
    String url, {
    Map<String, dynamic> params = const {},
    onTip = false,
  }) async {
    Response response;
    try {
      Map<String, dynamic> tempParam;
      if (params == null) tempParam = {};
      tempParam.addAll(_basicParams);
      response = await _dio.post(url, data: tempParam);
    } catch (e) {
      return null;
    }
    return response.data;
  }
}
