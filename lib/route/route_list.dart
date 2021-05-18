import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ju_flutter/route/route_handlers.dart';

/// fluro 自定义路由
///
/// 先定义路由地址再配置到dio
class RouteList {
  /// 欢迎界面
  static String welcome = "/";

  /// 首页
  static String home = "/home";

  /// 自定义 Echo
  static String customizeEcho = "/customizeEcho";

  /// 路由学习
  static String customizeRouter = "/customizeRouter";

  /// 子树中获取父级widget
  static String childGetParent = "/childGetParent";

  /// 部件内 state 的生命周期
  static String lifeCycle = "/lifeCycle";

  /// 点击查看 flutter SDK 内置部件介绍
  static String textWidget = "/textWidget";

  /// flutter Cupertino ui 的部件介绍
  static String cupertinoList = "/cupertinoList";

  /// 自定义选项卡
  static String customizeTab = "/customizeTab";

  /// 路由处理程序
  ///
  /// [router.notFoundHandler]处理路由没发现的情况
  /// [router.define()]第一个参数是路由地址，第二个参数是页面跳转和传参，第三个参数是默认的转场动画，默认不设置转场动画。
  static void configureRoutes(FluroRouter router) {
    /// 配置-欢迎路由
    router.define(welcome, handler: welcomeHandler);

    /// 配置-首页路由
    router.define(home, handler: homeHandler);

    /// 配置-自定义 echo 部件
    router.define(customizeEcho, handler: customizeEchoHandler);

    /// 配置-路由学习
    router.define(customizeRouter, handler: customizeRouterHandler);

    /// 配置-子树中获取父级widget
    router.define(childGetParent, handler: childGetParentHandler);

    /// 配置-部件内 state 的生命周期
    router.define(lifeCycle, handler: lifeCycleHandler);

    /// 配置-点击查看 flutter SDK 内置部件介绍
    router.define(textWidget, handler: textWidgetHandler);

    /// 配置-flutter Cupertino ui 的部件介绍
    router.define(cupertinoList, handler: cupertinoListHandler);

    /// 配置-自定义 tab 选项卡
    router.define(customizeTab, handler: customizeTabHandler);

    /// 没有匹配到指定路由时
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print("路由未找到 !!!");
        return;
      },
    );
  }
}
