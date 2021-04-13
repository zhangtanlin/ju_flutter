import 'package:ju_flutter/http/http_dio.dart';
import 'package:ju_flutter/model/check_line.dart';

/// 选择线路
Future<ModelCheckLine> apiGetCheckLine() async {
  try {
    Map data = await HttpDio().get('/api/line');
    ModelCheckLine modelCheckLine = ModelCheckLine.fromJson(data);
    return modelCheckLine;
  } catch (e) {
    return null;
  }
}
