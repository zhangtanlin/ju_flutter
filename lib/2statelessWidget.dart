import 'package:flutter/material.dart';

// 在子树中获取父级 widget
class ChildGetParent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("context 测试"),
      ),
      body: Container(
        child: Builder(builder: (context) {
          // 在 Widget 树中向上查找最近的父级 Scaffold 部件
          Scaffold scaffold = context.findAncestorWidgetOfExactType<Scaffold>();
          // 直接返回 AppBar 的 title，此处实际上是 Txte('context 测试')
          return (scaffold.appBar as AppBar).title;
        }),
      ),
    );
  }
}
