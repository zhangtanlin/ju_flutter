/// 参考事例文档[https://zhuanlan.zhihu.com/p/487172584]
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ju_flutter/config/network.dart';
import 'package:ju_flutter/utils/util_device.dart';
import 'package:ju_flutter/utils/util_log.dart';
import 'package:ju_flutter/utils/util_package.dart';

import 'http_response.dart';

/// 构造 http 请求类（单例模式）
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
  /// [_httpDio]单例对象
  /// [_dio]dio
  static HttpDio _httpDio;
  static Dio _dio;
  Map _baseParams;
  BaseOptions _baseOptions;
  Map<String, dynamic> baseHeader = {
    "Accept": "application/json",
    "Content-Type": "application/json; charset=UTF-8",
  };

  factory HttpDio() => _instance;

  /// 初始化配置
  static HttpDio _instance = HttpDio._internal();

  /// 通用全局单例,第一次使用时初始化
  HttpDio._internal() {
    if (_dio == null) {
      _dio = Dio(
        BaseOptions(
          baseUrl: Network.api[0],
          connectTimeout: 20 * 1000,
          receiveTimeout: 300000,
          headers: baseHeader,
        ),
      );
    }
  }

  /// 获取
  get dio => _dio;

  /// 初始化公共请求参数
  initBaseOptions({String host, Map<String, dynamic> headers}) {
    _baseOptions = BaseOptions(
      baseUrl: host ?? Network.api[0],
      connectTimeout: 20 * 1000,
      receiveTimeout: 300000,
      headers: headers ?? baseHeader,
    );
    _dio.options = _baseOptions;
  }

  /// api的公共参数
  Map<String, dynamic> getBaseParam() {
    Map<String, dynamic> info = {
      'version': UtilPackage.getPackageInfo.version ?? "",
    };
    if (Platform.isAndroid) {
      info['oauth_id'] = UtilDevice.getAndroidInfo.androidId ?? "";
      info['bundleId'] = UtilPackage.getPackageInfo.packageName ?? "";
    } else {
      var map = UtilDevice.getIosInfo.map ?? {};
      info['oauth_id'] = UtilDevice.getIosInfo.identifierForVendor;
      info['bundleId'] = map['bundleId'];
    }
    info['token'] = '';
    info['app_type'] = 'flt';
    info['oauth_type'] = '${Platform.isAndroid ? 'android' : 'ios'}';
    _baseParams = info;
    return info;
  }

  /// 分析请求结果
  HttpResponse analysisResponse(Response res) {
    if (res.statusCode == 200 || res.statusCode == 201) {
      if (res.data["code"] == 200) {
        UtilLog.p("200");
        if (res.data is Map) {
          return HttpResponse.fromJson(res.data);
        } else {
          return jsonDecode(res.data);
        }
      } else if (res.data["code"] == 404) {
        UtilLog.p("404");
        return HttpResponse.fromJson({
          "code": 404,
          "message": "正常",
          "data": null,
        });
      } else if (res.data["code"] == 300) {
        UtilLog.p("300");
        return HttpResponse.fromJson({
          "code": 300,
          "message": "正常",
          "data": null,
        });
      }
    } else {
      UtilLog.p("业务错误,报错信息");
      return HttpResponse.fromJson({
        "code": 200,
        "message": "正常",
        "data": null,
      });
    }
  }

  /// get方法
  Future get(String path, {Map<String, dynamic> querys}) async {
    Response _response;
    try {
      _response = await _dio.get(path, queryParameters: querys ?? {});
      return analysisResponse(_response);
    } on DioError catch (e) {
      UtilLog.p("get方法$e");
      return null;
    }
  }

  /// post纯净方法
  Future purePost(String path, {dynamic params}) async {
    Response _response;
    try {
      _response = await _dio.post(
        path,
        options: Options(responseType: ResponseType.plain),
        data: params,
      );
      return analysisResponse(_response);
    } catch (e) {
      UtilLog.p("post纯净方法$e");
      return null;
    }
  }

  /// post 方法
  Future post(String path, {Map<String, dynamic> params}) async {
    Response _response;
    try {
      if (params == null) params = {};
      Map<String, dynamic> tempParam = getBaseParam();
      tempParam.addAll(params);
      _response = await _dio.post(path, data: tempParam);
      return analysisResponse(_response);
    } catch (e) {
      UtilLog.p("post方法$e");
      return null;
    }
  }

  /// upload方法
  uploadFile(api, {FormData params}) async {
    Response _response;
    try {
      // 注:考虑选取图片的第三方库差异此处文件格式在外界转化.
      _response = await _dio.post(
        api,
        data: params,
      );
      return analysisResponse(_response);
    } catch (e) {
      UtilLog.p("upload方法$e");
      return null;
    }
  }
}
