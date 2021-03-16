import 'package:flutter/material.dart';

// 公共头部
class Header extends StatelessWidget {
  final Widget leftWidget; // 左侧部件
  final Widget centerWidget; // 中部部件
  final Widget rightWidget; // 右侧部件
  final VoidCallback
      onLeftCallback; // 返回 widget 点击事件， 默认触发返回功能 Navigator.pop(context)
  Header({
    Key key,
    this.leftWidget,
    this.centerWidget,
    this.rightWidget,
    this.onLeftCallback,
  }) : super(key: key);

  // 头部左部
  Widget _left() {
    return Center(
        child: leftWidget == null
            ? Container(
                alignment: Alignment.center,
                child: Text('data'),
              )
            : leftWidget);
  }
  // 头部中部
  // 头部右部
  @override
  Widget build(BuildContext context) {
    return Row(children: [_left()]);
  }
}
