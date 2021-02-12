import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/*
 * 声明一个 Widget 类
 * abstract 用来创建由具体类扩展的抽象类，抽象类可以包含抽象方法。
 * Widget 类继承自 DianosticableTree(诊断树)主要作用是提供调试信息。 
 * Widget 类本身是一个抽象类，最核心的就是定义了 createElement() 接口，
 * 开发中一般都不用直接继承 Widget 类来实现一个新组建，相反通常会通过继承 StatelessWidget 或 StatefullWidget 来间接继承 Widget 类来实现。
 * StatelessWidget 和 StatefullWidget 都是直接继承自 WIdget类，这两个类是 flutter 中非常重要的两个抽象类。
 */
@immutable
abstract class Widget extends DiagnosticableTree {
  const Widget({this.key});
  /*
   * 类似于react/vue中的key，作用是决定是否在下一次 build 时复用旧的 Widget,决定条件在 canUpdate 方法中。
   * 为 Widget 显示添加 key 的话可能（不一定）会使 ui 在重新构建时变的高效。
   * 一般只在构建列表项 ui 时会显式指定 key 
   */
  final Key key;
  /*
   * 一个 Widget 可以对应多个 Element, flutter framework在构建 ui 树时，会先调用此方法生成对应节点的 element 对象。
   * 此方法是 flutter framework 隐式调用的，在开发中基本上不会调用。
   */
  @protected
  Element createElement();

  @override
  String toStringShort() {
    return key == null ? '$runtimeType' : '$runtimeType-$key';
  }

  // debugFillProperties() 复写父类方法，主要是设置诊断树的一些特性。 
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.defaultDiagnosticsTreeStyle = DiagnosticsTreeStyle.dense;
  }

  /*
   * canUpdate() 是一个静态方法，它主要用于在 Widget 树重新 build 是复用旧的 Widget，即是否用新的 Widget 对象去更新旧 ui 树上所对应的 element 对象的配置。
   * 通过其源码可以看到，只要 newWidget 与 oldWidget 的 runtimeType 和 key同时相等就会用 newWidget 去更新 element 对象的配置，否则就会创建新的 element。
   */
  static bool canUpdate(Widget oldWidget, Widget newWidget) {
    return oldWidget.runtimeType == newWidget.runtimeType &&
        oldWidget.key == newWidget.key;
  }
}
