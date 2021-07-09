import 'package:ju_flutter/http/http_dio.dart';
import 'package:ju_flutter/model/check_line.dart';
import 'package:ju_flutter/model/config.dart';
import 'package:ju_flutter/model/user.dart';

class HttpApi {
  /// 选择线路
  static apiGetCheckLine() async {
    try {
      Map data = await HttpDio().post('/api/line');
      ModelCheckLine modelCheckLine = ModelCheckLine.fromJson(data);
      return modelCheckLine;
    } catch (e) {
      return null;
    }
  }

  /// 整合接口
  static apiConfig() async {
    try {
      Map data = await HttpDio().post('/api/config');
      ModelConfig _modelConfig = ModelConfig.fromJson(data);
      return _modelConfig;
    } catch (e) {
      return null;
    }
  }

  /// 用户
  static apiGetUserList() async {
    try {
      Map data = await HttpDio().post('/api/user');
      ModelUser _modelUser = ModelUser.fromJson(data);
      return _modelUser;
    } catch (e) {
      return null;
    }
  }

  /// 视频详情
  static apiVideoDetail() async {
    try {
      Map data = await HttpDio().post('/api/user');
      ModelUser modelUser = ModelUser.fromJson(data);
      return modelUser;
    } catch (e) {
      return null;
    }
  }
}
