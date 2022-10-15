import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';

/// 公共方法
class UtilTool {
  /// 字符串转buffer(Uint8List)
  static Uint8List stringToUint8List(String data) {
    List<int> tempList = data.codeUnits;
    Uint8List tempBytes = Uint8List.fromList(tempList);
    return tempBytes;
  }

  /// buffer(Uint8List)转字符串
  static String uint8ListToString(Uint8List data) {
    String tempStr = String.fromCharCodes(data);
    return tempStr;
  }
}
