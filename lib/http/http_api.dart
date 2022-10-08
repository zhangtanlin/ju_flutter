import 'package:ju_flutter/http/http_api_name.dart';
import 'package:ju_flutter/http/http_dio.dart';
import 'package:ju_flutter/model/check_line.dart';
import 'package:ju_flutter/model/config.dart';
import 'package:ju_flutter/model/user.dart';

class HttpApi {
  /// 线路列表
  static apiGetCheckLine() async {
    try {
      Map data = await HttpDio().post(
        HttpApiName.lineList,
      );
      ModelCheckLine modelCheckLine = ModelCheckLine.fromJson(data);
      return modelCheckLine;
    } catch (e) {
      return null;
    }
  }

  /// 整合接口
  static apiConfig() async {
    try {
      Map data = await HttpDio().post(
        HttpApiName.config,
      );
      ModelConfig _modelConfig = ModelConfig.fromJson(data);
      return _modelConfig;
    } catch (e) {
      return null;
    }
  }

  /// 用户列表
  static apiGetUserList() async {
    try {
      Map data = await HttpDio().post(
        HttpApiName.userList,
      );
      ModelUser _modelUser = ModelUser.fromJson(data);
      return _modelUser;
    } catch (e) {
      return null;
    }
  }

  /// 视频详情
  static apiVideoDetail() async {
    try {
      Map data = await HttpDio().post(
        HttpApiName.videoDetail,
      );
      ModelUser modelUser = ModelUser.fromJson(data);
      return modelUser;
    } catch (e) {
      return null;
    }
  }
}
