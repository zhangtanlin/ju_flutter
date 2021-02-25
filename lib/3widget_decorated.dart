import 'package:flutter/material.dart';

class WidgetDecorated extends StatefulWidget {
  @override
  _WidgetDecoratedState createState() => new _WidgetDecoratedState();
}

class _WidgetDecoratedState extends State<WidgetDecorated> {
  // 自定义 redBox，它是一个背景颜色为红色的盒子，不指定它的宽度和高度
  Widget redBox = DecoratedBox(decoration: BoxDecoration(color: Colors.red));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('容器类部件'),
        ),
        body: Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            alignment: WrapAlignment.center,
            children: <Widget>[
              /**
               * DecoratedBox
               * 可以在其自建绘制前（或者绘制后）绘制一些装饰（Decoration）如； 背景/边框/渐变等。
                const DecoratedBox({
                  Decoration decoration,                                       // 代表要绘制的装饰，类行为Decoration，Decoration是一个
                                                                                  抽象类，它定义了一个接口 createBoxPainter(),子类
                                                                                  的主要职责是需要通过实现它来创建一个画笔，该画笔用于绘制装饰。
                  DecorationPosition position = DecorationPosition.background, // 此属性决定在哪里绘制 Decoration ，它接收 DecorationPosition的
                                                                                  枚举类型，枚举类型的值有：
                                                                                  background：在子部件之后绘制，即背景装饰。
                                                                                  foreground：在子部件之上绘制，即前景。
                  Widget child
                })
               * 我们通常直接使用 BoxDecoration 类，它是一个 Decoration 的子类，实现了常用的装饰元素的绘制。
                BoxDecoration({
                  Color color,                         // 颜色
                  DecorationImage image,               //图片
                  BoxBorder border,                    / /边框
                  BorderRadiusGeometry borderRadius,   // 圆角
                  List<BoxShadow> boxShadow,           // 阴影,可以指定多个
                  Gradient gradient,                   // 渐变
                  BlendMode backgroundBlendMode,       // 背景混合模式
                  BoxShape shape = BoxShape.rectangle, // 形状
                })
               * 下面示例，显示了一个渐变按钮（还不能响应点击事件），在自定义部件中介绍完整功能 GradientButton。
               * 下面的示例中使用了 LinearGradient 类用于定义线性渐变的类。
               * flutter 中还提供了渐变配置类，如：RadialGradient/SweepGradient等。
               */
              DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.red, Colors.orange[700]]), // 背景渐变
                      borderRadius: BorderRadius.circular(3.0), // 3像素圆角
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black54,
                            offset: Offset(2.0, 2.0),
                            blurRadius: 4.0)
                      ]),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
                    child: Text('Login', style: TextStyle(color: Colors.white)),
                  )),
              OutlineButton(
                child: Text('点击查看对齐与相对定位及更多的部件',
                    style: TextStyle(
                      color: Colors.red,
                    )),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return WidgetDecorated();
                  }));
                },
              )
            ]));
  }
}
