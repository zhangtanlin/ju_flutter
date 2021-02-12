import 'package:flutter/material.dart';

/* 
 * 实现一个回显字符串的 Echo。
 * statelessWidget 用于不需要维护状态的场景，通常在 build 方法中通过嵌套其他 Widget 来构建 ui，
 * 在构建过程中会递归的构建其嵌套的 Widget。
 * 注意：Widget 的构造函数参数应使用命名参数，命名参数中的必要参数要添加 @require 标注，
 *      这样有利于静态代码分析其进行进行检查。
 *      在继承 Widget 时，第一个参数通常应该是 Key，另外如果 Widget 需要接收子 Widget ，
 *      那么 child 和 children 参数通常应该被放在参数列表的最后，
 *      同样按照惯例， Widget 的属性应尽可能的被申明为 final ，防止被意外改变。
 */
class Echo extends StatelessWidget {
  const Echo({
    Key key,
    @required this.text,
    this.backgroundColor: Colors.grey,
  }) : super(key: key);

  final String text;
  final Color backgroundColor;

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

// // 调用方法
// Widget build(BuildContext context) {
//   return Echo(text: "hello world");
// }