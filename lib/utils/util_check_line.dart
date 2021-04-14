import 'package:ju_flutter/config/network.dart';
import 'package:ju_flutter/http/http_api.dart';
import 'package:ju_flutter/store/sharedPreferences.dart';

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
    List<String> apiUrlList;
    if (apiUrlList == null) {
      apiUrlList = await PersistentState.getState('CONFIG_LINEX');
      if (apiUrlList == null) {
        apiUrlList = Network.proApi;
      }
    }

    /// 选择线路接口调用
    var res = await Api.apiGetCheckLine();
    if (res != null && res.status == 200) {
      onSuccess(res);
    } else {
      onFailed('获取路线失败');
    }
  }
}
