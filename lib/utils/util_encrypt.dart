import 'dart:convert';
import 'dart:io';

/// 加解密
class utilEncrypt {
  /// 加密
  static getEncrypt(Map<String, dynamic> jsonData) async {
    var data;
    if (Platform.isAndroid) {
      data = jsonEncode(jsonData);
    } else {
      data = jsonData;
    }

    // const decryptToken = CryptoJS.AES.decrypt(token, passwordKey).toString(
    //       CryptoJS.enc.Utf8
    //     )
    //     const decryptTokenJSON = JSON.parse(decryptToken)
    //     const decryptTokenName = decryptTokenJSON.name
    //     const getRedisToken = redisClient.get(decryptTokenName + ':token')
    //     if (!getRedisToken) {
    //       return false
    //     }
    //     return true
  }
}
