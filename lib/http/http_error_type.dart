import 'package:dio/dio.dart';

/// 返回异常类
/// [_code]状态码
/// [_message]提示文字
/// [_data]返回值
class ErrorType {
  // 处理 Dio 异常
  static String dioError(DioError error) {
    switch (error.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        return "网络连接超时";
      case DioErrorType.SEND_TIMEOUT:
        return "发送超时";
      case DioErrorType.RECEIVE_TIMEOUT:
        return "服务器异常";
      case DioErrorType.RESPONSE:
        return "服务器异常";
      case DioErrorType.CANCEL:
        return "请求被取消";
      case DioErrorType.DEFAULT:
        return "未知错误";
      default:
        return "异常错误";
    }
  }

  // 处理 http 错误码
  static String httpError(int errorCode) {
    String message;
    switch (errorCode) {
      case 300:
        message =
            "被请求的资源有一系列可供选择的回馈信息，每个都有自己特定的地址和浏览器驱动的信息，浏览器能够自行选择一个首选的地址进行重定向";
        break;
      case 301:
        message = "被请求的资源已经永久移动到新位置，并且将来任何对此资源的引用都应该使用本响应返回的若干个URL之一";
        break;
      case 302:
        message = "请求的资源，临时从不同的URL相应请求";
        break;
      case 303:
        message = "当前请求的资源在另一个URL上被找到，而且客户端应当采用GET的方式访问资源";
        break;
      case 304:
        message = "如果客户端发送了带GET的请求，且该请求已被允许，而文档内容（自上次访问以来或者根据请求的条件）并没有改变";
        break;
      case 400:
        message = "参数有误";
        break;
      case 401:
        message = "用户验证失败";
        break;
      case 403:
        message = "服务器拒绝执行";
        break;
      case 404:
        message = "请求资源不存在";
        break;
      case 405:
        message = "请求方法不正确";
        break;
      case 408:
        message = "请求超时";
        break;
      case 409:
        message = "和被请求的资源状态冲突,无法完成请求";
        break;
      case 500:
        message = "服务器异常";
        break;
      case 501:
        message = "服务器无法处理当前请求类型/服务未实现";
        break;
      case 502:
        message = "网关错误";
        break;
      case 503:
        message = "服务不可用";
        break;
      case 504:
        message = "网关超时,未及时得到响应请求";
        break;
      case 505:
        message = "服务器不支持请求中所使用的HTTP协议版本";
        break;
      default:
        message = "请求失败,错误码:$errorCode";
    }
    return message;
  }
}
