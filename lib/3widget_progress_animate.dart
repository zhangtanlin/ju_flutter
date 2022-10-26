/*
 * flutter SDK 内置部件介绍
 */
import 'package:flutter/material.dart';
import 'package:ju_flutter/3widget_layout.dart';

class WidgetProgressAimate extends StatefulWidget {
  @override
  _WidgetProgressAimateState createState() => new _WidgetProgressAimateState();
}

class _WidgetProgressAimateState extends State<WidgetProgressAimate>
    with SingleTickerProviderStateMixin {
  // 进度指示器-进度色动画
  AnimationController _animationController;

  @override
  void initState() {
    // 部件初始化-进度指示器-进度色动画
    _animationController = new AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animationController.forward();
    _animationController.addListener(() => {setState(() => {})});
    super.initState();
  }

  @override
  void dispose() {
    // 状态对象被删除时-进度指示器-注销进度色动画
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /**
           * 进度指示器-进度色动画
           * 定制进度指示器风格样式，可以通过 CustomPainter Widget 来自定义绘制逻辑，实际上 LinearProgressIndicator 和
           * CircularProgressIndicator 也正是通过 CustomPainter 来实现外观绘制的。关于 CustomPainter 在后面 自定义 Widget 有详细介绍。
           */
          Padding(
            padding: EdgeInsets.all(16),
            child: LinearProgressIndicator(
              backgroundColor: Colors.amber[900],
              valueColor: ColorTween(
                begin: Colors.brown,
                end: Colors.red,
              ).animate(
                _animationController,
              ), // 从赭色变成红色
              value: _animationController.value,
            ),
          ),
          OutlineButton(
            child: Text('点击查看线性布局及更多的部件'),
            textColor: Colors.red,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WidgetLayout(); // 点击查看线性布局及更多的部件
              }));
            },
          ),
        ],
      ),
    );
  }
}
