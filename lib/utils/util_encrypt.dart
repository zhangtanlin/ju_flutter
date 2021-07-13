import 'dart:convert';

/// 加解密
class UtilEncrypt {
  //// Base64 加密
  static String encodeBase64(String data) {
    String _string = base64Encode(utf8.encode(data));
    return _string;
  }

  /// Base64 解密
  static String decodeBase64(String data) {
    String _string = String.fromCharCodes(base64Decode(data));
    return _string;
  }
}
