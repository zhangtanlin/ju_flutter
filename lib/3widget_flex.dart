import 'package:flutter/material.dart';

class WidgetFlex extends StatefulWidget {
  @override
  _WidgetFlexState createState() => new _WidgetFlexState();
}

class _WidgetFlexState extends State<WidgetFlex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('布局类部件'),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              /**
               * 弹性布局允许子部件按照一定比例来分配父容器空间，弹性布局的概念在其他UI系统中也都存在着，
               * 如h5的弹性盒子，安卓中的 FlexboxLayout等，flutter 中的弹性布局主要通过 Flex 和 Expanded 来配合实现。
               * Flex 部件可以沿着水平或者垂直方向排列子组建，如果知道主轴方向，使用 Row 或 Column 会方便一些，因为 Row 和 column
               * 都继承自 Flex 参数基本相同，所以能使用 Flex 的地方基本上都可以使用 Row 或 Column。Flex 本身功能强大，它也可以和 Expanded 组建配合
               * 来实现弹性布局。
                Flex({
                  ...
                  @required this.direction, // 弹性布局的方向, Row默认为水平方向，Column默认为垂直方向
                  List<Widget> children = const <Widget>[],
                })
                */
              OutlineButton(
                child: Text('点击查看进度指示器-进度色动画及更多的部件'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return WidgetFlex(); // 点击查看进度指示器-进度色动画及更多的部件
                  }));
                },
              ),
            ])));
  }
}
