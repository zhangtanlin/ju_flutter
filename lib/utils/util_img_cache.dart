import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// 图片缓存到本地
class UtilImageCache {
  /// 定义
  /// [_cacheImgDir]缓存的文件夹名称
  /// [_cacheImgPath]缓存的文件夹路径
  /// [_appPath]应用路径
  static String _cacheImgDir = "NewImgCacheDir";
  static String _cacheImgPath;
  static String _appPath;

  /// 初始化
  static Future<void> initCacheImg() async {
    var documents;
    if (Platform.isAndroid) {
      documents = await getExternalStorageDirectories();
    } else {
      documents = await getApplicationDocumentsDirectory();
    }
    _appPath = documents.path;
    _cacheImgPath = '$_appPath/$_cacheImgDir/';

    // 不知道下面这一块代码是在做啥
    // Directory directory = Directory(_cacheImgPath);
    // bool isExists = await directory.exists();
    // if (!isExists) {
    //   await directory.create(recursive: true);
    // }
  }

  /// 获取
  /// [cacheImgPath]缓存文件夹路径
  /// [appPath]缓存文件夹路径
  static get cacheImgPath => _cacheImgPath;
  static get appPath => _appPath;
}
