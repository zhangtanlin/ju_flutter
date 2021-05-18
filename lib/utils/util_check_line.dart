import 'package:ju_flutter/config/network.dart';
import 'package:ju_flutter/constant/shared_preferences_key.dart';
import 'package:ju_flutter/http/http_api.dart';
import 'package:sp_util/sp_util.dart';

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
    String apiUrlList = SpUtil.getString(SharedPrefKey.line) ?? Network.prodApi;
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
