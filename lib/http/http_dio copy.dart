import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:ju_flutter/config/network.dart';
import 'package:ju_flutter/utils/util_language.dart';
import 'package:package_info/package_info.dart';

/// 构造 http 请求类
///
/// [_packageInfo]-应用程序信息
/// [_deviceInfoPlugin]-设备信息
/// [_androidDeviceInfo]-android信息
/// [_iosDeviceInfo]-ios信息
/// [_baseParam]-基础参数
/// [baseOptions]-dio 参数
/// [_dio]-http请求插件
/// [_defaultHeader]-默认请求头
class HttpDio {
  static Dio _dio;
  static HttpDio _httpDio;
  PackageInfo _packageInfo;
  DeviceInfoPlugin _deviceInfoPlugin;
  AndroidDeviceInfo _androidDeviceInfo;
  IosDeviceInfo _iosDeviceInfo;
  Map<String, dynamic> _baseParam;
  BaseOptions baseOptions;
  Map<String, dynamic> _defaultHeader = {
    'Accept': 'application/json',
    'Content-Type': 'application/x-www-from-urlencoded'
  };

  /// 工厂模式初始化 HttpDio，用以判定是否已经初始化。
  ///
  /// 如果[_dio]没有初始化，则初始化；否则返回[_dio]。
  factory HttpDio(String type) {
    if (_httpDio == null) {
      _httpDio = HttpDio.initDeviceInfo();
      _dio = Dio();
    }
    /// 如果是 get 请求
    if (type == 'get') {

    }
    return _httpDio;
  }

  /// 工厂模式扩展设备信息
  HttpDio.initDeviceInfo() {
    _deviceInfoPlugin = DeviceInfoPlugin();
  }

  /// 初始化获取(安卓/IOS)信息
  initSystemInfo({
    String hostUrl,
  }) async {
    if (Platform.isAndroid) {
      _androidDeviceInfo = await _deviceInfoPlugin.androidInfo;
    }
    if (Platform.isIOS) {
      _iosDeviceInfo = await _deviceInfoPlugin.iosInfo;
    }
  }

  /// http 请求参数
  ///
  /// 注意1:如果返回数据是 json(content-type),dio会自动把数据转换成json。
  /// 注意2:响应流上前后 两次接收到数据的间隔，单位为秒，如果两次间隔超过[receiveTimeout]，
  /// [Dio]将会抛出一个[DioErrorType.RECEIVE_TIMEOUT]的异常。
  initHttpHeader({String hostUrl = '', Map<String, dynamic> headers}) {
    baseOptions = BaseOptions(
        baseUrl: hostUrl ?? Network.defaultApi,
        connectTimeout: 20 * 1000,
        responseType: ResponseType.plain,
        receiveTimeout: 3000000,
        headers: headers ?? _defaultHeader);
    print('=888=$_dio=');
    print('==woaini:$baseOptions===');
    // _dio.options = baseOptions;
  }

  /// 基础参数
  Map<String, dynamic> _setBaseParam() {
    Map<String, dynamic> info = {};
    if (Platform.isAndroid) {
      print('=====andriod请求:=====');
      info['oauth_id'] = _androidDeviceInfo.androidId; // 安卓id
    }
    if (Platform.isIOS) {
      print('=====ios请求:=====');
      info['oauth_id'] = _iosDeviceInfo.identifierForVendor; // ios的id
    }
    print('=====公共参数1:=====');
    info['version'] = _packageInfo.version; // 版本
    info['language'] = UtilLanguage.language == Language.hans ? 1 : 2; // 语言
    print('=====公共参数2:=====');
    _baseParam = info;
  }

  /// post 请求（纯净版不带参数）
  HttpDio.purePost(String path) {
    purePost(path);
  }
  Future<Null> purePost(String path) {
    try {
      var response =
          _dio.post(path, options: Options(responseType: ResponseType.plain));
      return response;
    } catch (e) {
      return null;
    }
  }

  /// post 请求
  Future<Map> post({String path = '', Map<String, dynamic> params}) async {
    try {
      if (params == null) params = {};
      Map<String, dynamic> tempParam = _setBaseParam();
      tempParam.addAll(params);
      var data = tempParam;
      Response response = await _dio.post(path, data: data ?? '');
      var responseData = response.data;
      if (responseData == null || responseData == '') return {};
      return responseData;
    } catch (e) {
      return null;
    }
  }

  /// get 请求
  Future get({String path, Map<String, dynamic> query}) async {
    print('=====get请求:=====');
    try {
      if (query == null) query = {};
      print('=====tempParam1:=====');
      Map<String, dynamic> tempParam = _setBaseParam();
      print('=====tempParam2:=====');
      tempParam.addAll(query);
      var data = tempParam;
      print('=====get1.data:$data=====');
      var response = await _dio.get(path, queryParameters: data);
      print('=====get1.response:$response=====');
      var responseData = response.data;
      print('=====get2.response:$responseData=====');
      if (responseData == null || responseData == '') return {};
      return responseData;
    } catch (e) {
      return null;
    }
  }
}
