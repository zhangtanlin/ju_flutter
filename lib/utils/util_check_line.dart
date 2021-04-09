import 'package:ju_flutter/http/http_dio.dart';
import 'package:ju_flutter/store/sharedPreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 选择路线
///
/// [onIpError]ip错误,[onSuccess]路线选择成功,[onFailed]路线选择失败。

void UtilCheckLine(
    // Function onIpError,
    // Function onSuccess,
    // Function onFailed,
    ) async {
  /// [HttpDio()]是初始化[httpDio]的方法。
  /// [initHttpHeader]初始化 http 请求的header。
  /// [initSystemInfo]初始化 http 请求的系统信息参数。
  final HttpDio httpDio = HttpDio();
  await httpDio.initSystemInfo();

  SharedPreferences sharedPreferences =
      await PersistentState.getState('CONFIG_LINEX');
  print('===shared$sharedPreferences===');
}
