import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:ju_flutter/config/network.dart';
import 'package:ju_flutter/http/http_api.dart';
import 'package:ju_flutter/http/http_dio.dart';
import 'package:ju_flutter/model/config.dart';
import 'package:sp_util/sp_util.dart';

/// 选择路线
class UtilCheckLine {
  /// 选择路线方法
  ///
  /// [onIpError]没有网络（ip错误）,[onSuccess]路线选择成功,[onFailed]路线选择失败。
  static checkLine({
    Function onIpError,
    Function onSuccess,
    Function onFailed,
  }) async {
    /// 定义
    /// [totalLine]线路总数
    /// [errorLines]不能够使用的线路
    /// [check]线路检测
    /// [spareLine]备用线路
    /// [handleResult]处理选择线路之后的返回值
    /// [saveLines]保存当前能够使用的线路到本地
    List<String> totalLine = SpUtil.getStringList('CONFIG_LINES') != null
        ? SpUtil.getStringList('CONFIG_LINES')
        : Network.api;
    List<String> errorLines = [];
    Function check;
    Function spareLine;
    Function handleResult;
    Function saveLines;

    /// 方法：保存线路到本地
    saveLines = (List<String> lines) {
      SpUtil.putStringList('CONFIG_LINES', lines);
    };

    /// 方法：备用线路验证
    spareLine = () async {
      try {
        var data = await HttpDio().get(Network.githubApi);
        check(line: data);
      } catch (e) {
        onFailed();
      }
    };

    /// 方法：线路接口调用
    /// [line]线路地址
    /// [verifyLine]请求一次接口验证接口是否畅通
    /// 注意:如果线路验证成功，就使用这个线路来请求“整合接口”
    check = ({String line}) async {
      /// 定义
      List<InternetAddress> ip4;

      /// 验证地址
      try {
        var _uri = Uri.parse(line);
        ip4 = await InternetAddress.lookup(
          _uri.host,
          type: InternetAddressType.IPv4,
        );
        if (ip4?.toString() == "") {
          return null; // DNS 解析错误
        } else {
          try {
            var apiVerify = await HttpDio().purePost('$line/api/line/verify');
            if (apiVerify == null) {
              errorLines.add(line.toString());
              if (errorLines.length == totalLine.length) {
                spareLine();
              }
            }
            return apiVerify;
          } catch (e) {
            return null;
          }
        }
      } catch (e) {
        return null;
      }
    };

    /// 方法：处理返回值+请求整合接口
    handleResult = (line) async {
      if (line != null) {
        HttpDio().initBaseOptions(host: line); // 再次初始化 dio 的线路
        ModelConfig _modelConfig = await HttpApi.apiConfig();
        if (_modelConfig != null && _modelConfig.status == 200) {
          Network.setApi([]); // api 地址
          if (_modelConfig.data.config != null) {
            List<String> tempLines = [];
            String tempLinesStr = _modelConfig.data.config.api;
            tempLinesStr.split(',').forEach((api) {
              tempLines.add(api.toString());
            });
            if (tempLines.length > 0) {
              saveLines(tempLines);
            }
          }
          onSuccess(_modelConfig);
        }
      } else {
        onFailed('线路检测失败');
      }
    };

    /// 网络连接检测（先要执行的方法）
    /// 使用 connectivity_plus 插件判断是否有移动网络和wifi。
    /// 注意：这个网络检测的方法需要写在“线路检测（线路接口调用）”，“备用线路验证”之后。
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Future.any(totalLine.map((line) async {
          var checkResult = await check(line: line);
          if (checkResult != null) {
            return line;
          } else {
            return Future.delayed(Duration(seconds: 6), () {
              return null;
            });
          }
        })).then((line) {
          handleResult(line);
        });
      } else {
        onFailed('暂无网络'); // 线路检测出错了
      }
    } catch (e) {
      onFailed('线路检测失败'); // 线路检测出错了
    }
  }
}
