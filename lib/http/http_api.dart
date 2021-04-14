import 'package:ju_flutter/http/http_dio.dart';
import 'package:ju_flutter/model/check_line.dart';
import 'package:ju_flutter/model/user.dart';

class Api {
  /// 选择线路
  static apiGetCheckLine() async {
    try {
      Map data = await HttpDio.getInstance().get('/api/line');
      ModelCheckLine modelCheckLine = ModelCheckLine.fromJson(data);
      return modelCheckLine;
    } catch (e) {
      return null;
    }
  }

  /// 选择线路
  static apiUser() async {
    try {
      Map data = await HttpDio.getInstance().get('/api/user');
      ModelUser modelUser = ModelUser.fromJson(data);
      return modelUser;
    } catch (e) {
      return null;
    }
  }
}
