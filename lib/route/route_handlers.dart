import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ju_flutter/2statefullWidget.dart';
import 'package:ju_flutter/2statelessWidget.dart';
import 'package:ju_flutter/3widget_route.dart';
import 'package:ju_flutter/3widget_tab.dart';
import 'package:ju_flutter/3widget_text.dart';
import 'package:ju_flutter/4cupertino.dart';
import 'package:ju_flutter/view/home.dart';
import 'package:ju_flutter/view/welcome.dart';

/// 欢迎界面
var welcomeHandler = Handler(
  handlerFunc: (
    BuildContext context,
    Map<String, dynamic> params,
  ) {
    return Welcome();
  },
);

/// 欢迎界面
var homeHandler = Handler(
  handlerFunc: (
    BuildContext context,
    Map<String, dynamic> params,
  ) {
    return Home();
  },
);

/// 自定义 echo
var customizeEchoHandler = Handler(
  handlerFunc: (
    BuildContext context,
    Map<String, dynamic> params,
  ) {
    return ShowEcho();
  },
);

/// 路由学习
var customizeRouterHandler = Handler(
  handlerFunc: (
    BuildContext context,
    Map<String, dynamic> params,
  ) {
    return WidgetRoute();
  },
);

/// 子树中获取父级widget
var childGetParentHandler = Handler(
  handlerFunc: (
    BuildContext context,
    Map<String, dynamic> params,
  ) {
    return ChildGetParent();
  },
);

/// 部件内 state 的生命周期
var lifeCycleHandler = Handler(
  handlerFunc: (
    BuildContext context,
    Map<String, dynamic> params,
  ) {
    return CounterWidget();
  },
);

/// 点击查看 flutter SDK 内置部件介绍
var textWidgetHandler = Handler(
  handlerFunc: (
    BuildContext context,
    Map<String, dynamic> params,
  ) {
    return WidgetText();
  },
);

/// flutter Cupertino ui 的部件介绍
var cupertinoListHandler = Handler(
  handlerFunc: (
    BuildContext context,
    Map<String, dynamic> params,
  ) {
    return CupertinoList();
  },
);

/// 自定义选项卡
var customizeTabHandler = Handler(
  handlerFunc: (
    BuildContext context,
    Map<String, dynamic> params,
  ) {
    return CustomizeTab();
  },
);
