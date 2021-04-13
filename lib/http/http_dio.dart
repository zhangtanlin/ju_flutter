import 'package:dio/dio.dart';
import 'package:ju_flutter/config/network.dart';

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
  Dio _dio;
  static HttpDio _instance = HttpDio._internal();

  /// 初始化方法
  factory HttpDio() => _instance;

  /// 通用全局单例，第一次使用时初始化
  HttpDio._internal() {
    if (_dio == null) {
      var options = BaseOptions(
        baseUrl: Network.devApi[0],
        connectTimeout: 5000,
        receiveTimeout: 3000,
      );
      _dio = Dio(options);
    }
  }

  /// 判定是否有 baseUrl
  static HttpDio getInstance({String baseUrl}) {
    if (baseUrl == null) {
      return _instance._setNormal();
    } else {
      return _instance._setBaseUrl(baseUrl);
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
  HttpDio _setBaseUrl(String baseUrl) {
    if (_dio != null) {
      _dio.options.baseUrl = baseUrl;
    }
    return this;
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
  post(String url,
      {Map<String, dynamic> params = const {}, onTip = false}) async {
    Response response;
    try {
      response = await _dio.post(url, data: params);
    } catch (e) {
      return null;
    }
    return response.data;
  }
}
