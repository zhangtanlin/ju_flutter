import 'package:flutter/material.dart';

/// 自定义 echo 部件
///
/// 实现一个回显字符串的 Echo。
/// statelessWidget 用于不需要维护状态的场景，通常在 build 方法中通过嵌套其他 Widget 来构建 ui，
/// 在构建过程中会递归的构建其嵌套的 Widget。
/// 注意：Widget 的构造函数参数应使用命名参数，命名参数中的必要参数要添加 @require 标注，
///      这样有利于静态代码分析其进行进行检查。
///      在继承 Widget 时，第一个参数通常应该是 Key，另外如果 Widget 需要接收子 Widget ，
///      那么 child 和 children 参数通常应该被放在参数列表的最后，
///      同样按照惯例， Widget 的属性应尽可能的被申明为 final ，防止被意外改变。
/// 方法（调用 Echo 的方法）:
/// Widget build(BuildContext context) {
///   return Echo(text: "hello world");
/// }
class Echo extends StatelessWidget {
  const Echo({
    Key key,
    @required this.text,
    this.backgroundColor: Colors.grey,
  }) : super(key: key);

  final String text;
  final Color backgroundColor;

  /// build 方法有一个 context 参数，它是 BuilContext 类的一个实例，
  /// 表示当前 widget 在 widget 树中的上下文，每个 widget 都会对应一个 context 对象(因为每一个 widget 都是 widget 树上的一个节点)。
  /// 实际上 context 是当前 widget 在 widget 树中位置中执行“相关操作”的一个句柄，
  /// 比如它提供了从当前 widget 开始向上遍历 widget 树以及按照 widget 类型查找父级 widget 的方法。
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor,
        child: Text(text),
      ),
    );
  }
}