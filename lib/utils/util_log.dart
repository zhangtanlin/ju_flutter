class UtilLog {
  /// 定义
  static int _limit = 70;

  /// [_logLine()]日志间的分割线
  static void _logLine({String prompt = ''}) {
    print('$prompt----------');
  }

  /// [_logRemainder()]显示大于 _limit 的剩余日志
  /// 1:创建 buffer 字符串，
  /// 2:把每个字符都添加进 buffer 文件内，
  /// 2-1:如果 1 除以 _limit 取余为 0 并且 i != 0（_limit的倍数且i != 0）打印并清空 StringBuffer。
  /// 2-1-1:判断是否到最后了（如果总长度 - i < _limit 表示已经到最后了）就截取从 lastIndex到最后的长度。
  static void _logRemainder(String msg) {
    // 写法1:
    // var outStr = StringBuffer();
    // for (var i = 0; i < msg.length; i++) {
    //   outStr.write(msg[i]);
    //   if (i % _limit == 0 && i != 0) {
    //     print(outStr);
    //     outStr.clear();
    //     var lastIndex = i + 1;
    //     if (msg.length - lastIndex < _limit) {
    //       print('++++++++++++++++++++++++++');
    //       var remainderStr = msg.substring(lastIndex, msg.length);
    //       print(remainderStr);
    //       break;
    //     }
    //   }
    // }
    // 写法2:
    for (var i = 0; i < msg.length; i++) {
      var msgLength = msg.length;
      var cutStart = i * _limit;
      var cutEnd = i * _limit + _limit;
      var start = cutStart, end;
      if (cutStart > msgLength) {
        break;
      }
      if (cutEnd > msg.length) {
        end = msg.length;
      } else {
        end = cutEnd;
      }
      var remainderStr = msg.substring(start, end);
      print(remainderStr);
    }
  }

  /// [_log()]打印全部日志
  static void _log(String msg) {
    _logLine(prompt: '开始');
    if (msg.length < _limit) {
      print(msg);
    } else {
      _logRemainder(msg);
    }
    _logLine(prompt: '结束');
  }

  /// 打印日志【暴露出去的方法（外部调用的方法）】
  static void p(dynamic obj) {
    var tempString = obj.toString().trim();
    _log(tempString);
  }
}
