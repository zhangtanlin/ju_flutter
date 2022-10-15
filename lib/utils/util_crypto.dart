/// RSA 加解密学习文档:https://www.yisu.com/zixun/693513.html
/// flutter RSA 加解密学习(和nestjs的crypto有差异看不懂,仅作为参考):https://www.jianshu.com/p/212bbd0e0fb3
/// 在线测试公钥私钥加解密:https://travistidwell.com/jsencrypt/demo/index.html
import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:ju_flutter/utils/util_log.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:flutter/services.dart';

final parser = RSAKeyParser();

/// 加解密
class UtilCrypto {
  /// Base64 加密
  static String encodeBase64(String data) {
    String _string = base64Encode(utf8.encode(data));
    return _string;
  }

  /// Base64 解密
  static String decodeBase64(String data) {
    String _string = String.fromCharCodes(base64Decode(data));
    return _string;
  }

  /// 公钥加密
  static publicEncryptFn(data) async {
    try {
      String publicKeyString = await rootBundle.loadString(
        'assets/ssh/public.pem',
      );
      RSAPublicKey publicKey = parser.parse(publicKeyString);
      Encrypter encrypter = Encrypter(
        RSA(
          publicKey: publicKey,
          encoding: RSAEncoding.OAEP,
        ),
      );
      Encrypted tempEncrypt = encrypter.encrypt(data.toString());
      String tempEncryptStr = tempEncrypt.base64;
      return tempEncryptStr;
    } catch (e) {
      UtilLog.p("公钥加密错误:$e");
      return "";
    }
  }

  // 私钥解密
  static Future<String> privateDecryptFn(String data) async {
    try {
      String privateKeyString = await rootBundle.loadString(
        'assets/ssh/private.pem',
      );
      final privateKey = parser.parse(privateKeyString);
      Encrypter encrypter = Encrypter(
        RSA(
          privateKey: privateKey,
          encoding: RSAEncoding.OAEP,
        ),
      );
      Encrypted tempDecrypt = Encrypted.fromBase64(data);
      String decrypted = encrypter.decrypt(tempDecrypt);
      return decrypted;
    } catch (e) {
      print("私钥解密错误:$e");
      return "";
    }
  }
}
