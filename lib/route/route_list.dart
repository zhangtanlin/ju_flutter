import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ju_flutter/route/route_handlers.dart';

/// fluro 自定义路由
class RouteList {

  /// 定义路由
  static String welcome = "/"; // 欢迎界面
  static String home = "/home"; // 首页
  static String customizeEcho = "/customizeEcho"; // 自定义 Echo
  static String customizeRouter = "/customizeRouter"; // 路由学习
  static String childGetParent = "/childGetParent"; // 子树中获取父级widget
  static String lifeCycle = "/lifeCycle"; // 部件内 state 的生命周期
  static String textWidget = "/textWidget"; // 点击查看 flutter SDK 内置部件介绍
  static String cupertinoList = "/cupertinoList"; // flutter Cupertino ui 的部件介绍

  /// 路由处理程序
  ///
  /// [router.notFoundHandler]处理路由没发现的情况
  /// [router.define()]第一个参数是路由地址，第二个参数是页面跳转和传参，第三个参数是默认的转场动画，默认不设置转场动画。
  static void configureRoutes(FluroRouter router) {
    router.define(welcome, handler: welcomeHandler); // 欢迎路由
    router.define(home, handler: homeHandler); // 首页
    router.define(customizeEcho, handler: customizeEchoHandler); // 自定义 echo 部件
    router.define(customizeRouter, handler: customizeRouterHandler); // 路由学习
    router.define(childGetParent, handler: childGetParentHandler); // 子树中获取父级widget
    router.define(lifeCycle, handler: lifeCycleHandler); // 部件内 state 的生命周期
    router.define(textWidget, handler: textWidgetHandler); // 点击查看 flutter SDK 内置部件介绍
    router.define(cupertinoList, handler: cupertinoListHandler); // flutter Cupertino ui 的部件介绍
    
    /// 没有匹配到指定路由时
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("路由未找到 !!!");
      return;
    });
  }
}
