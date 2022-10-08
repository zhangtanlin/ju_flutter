/// 返回结果类
/// [_code]状态码
/// [_message]提示文字
/// [_data]返回值
class HttpResponse {
  int _code;
  String _message;
  dynamic _data;

  /// 格式化
  HttpResponse.fromJson(Map result) {
    this._code = result["code"];
    this._message = result["message"];
    this._data = result["data"];
  }

  // 获取指定值
  int get code => _code;
  String get message => _message;
  dynamic get data => _data;

  @override
  String toString() {
    return "HttpResponse{code:$code,msg:$message,data:$data}";
  }
}
