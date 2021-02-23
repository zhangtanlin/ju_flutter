import 'package:flutter/material.dart';

class WidgetFlow extends StatefulWidget {
  @override
  _WidgetFlowState createState() => new _WidgetFlowState();
}

class _WidgetFlowState extends State<WidgetFlow> {
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
                  @required this.direction, // 弹性布局的方向：Axis.horizontal为水平方向，Axis.vertical为垂直方向
                  List<Widget> children = const <Widget>[],
                })
               * Flex 继承自 MultichildrenderObjectWidget，对应的 RenderObject 为 RenderFlex ，RenderFlex中实现了其布局算法，
               */
              Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Text('弹性布局1'),
                  Text('弹性布局2')
                ],
              ),
              /**
               * 使用 Expanded 可以按比例扩伸 子部件所占用的比例。
               * flex 参数为弹性系数，如果为0 或者 null，则 child 是没有弹性的，即不会被延伸占用的空间。如果大于0，所有的 Expended 按照其 flex 的比例
               * 来分割主轴的全部空闲空间。
               */
              Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 30.0,
                      color: Colors.red[900],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 30.0,
                      color: Colors.green[900],
                    ),
                  )
                ],
              ),
              OutlineButton(
                child: Text('点击查看进度指示器-进度色动画及更多的部件'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return WidgetFlow(); // 点击查看进度指示器-进度色动画及更多的部件
                  }));
                },
              ),
            ])));
  }
}
