import 'package:ju_flutter/http/http_dio.dart';
import 'package:ju_flutter/model/check_line.dart';
import 'package:ju_flutter/model/user.dart';

/// 用户-获取
Future<ModelUser> apiGetUserList({String id='', String name=''}) async {
  try {
    Map data =
        await HttpDio().get(path: '/api/user', query: {id: id, name: name});
    print('=====apiGetUserList:$apiGetUserList=====');
    ModelUser modelUser = ModelUser.fromJson(data);
    return modelUser;
  } catch (e) {
    return null;
  }
}

/// 选择线路
Future<ModelCheckLine> apiGetCheckLine() async {
  try {
    Map data =
        await HttpDio().get(path: '/api/line',);
    print('=====请求线路:$data=====');
    ModelCheckLine modelCheckLine = ModelCheckLine.fromJson(data);
    return modelCheckLine;
  } catch (e) {
    return null;
  }
}
