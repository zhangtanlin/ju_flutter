import 'package:ju_flutter/constant/shared_preferences_key.dart';
import 'package:ju_flutter/http/http_api.dart';
import 'package:ju_flutter/utils/util_shared_preferences.dart';

/// 选择路线
class UtilCheckLine {
  /// 选择路线方法
  ///
  /// [onIpError]ip错误,[onSuccess]路线选择成功,[onFailed]路线选择失败。
  static checkLine({
    Function onIpError,
    Function onSuccess,
    Function onFailed,
  }) async {
    /// 获取本地路线配置参数
    String apiUrlList =
        UtilSharedPref.sharedPref().getString(SharedPrefKey.text) ??
            'http://127.0.0.1:3000';
    print('=apiUrlList2=$apiUrlList=======');

    /// 选择线路接口调用
    var res = await HttpApi.apiGetCheckLine();
    if (res != null && res.status == 200) {
      onSuccess(res);
    } else {
      onFailed('获取路线失败');
    }
  }
}
