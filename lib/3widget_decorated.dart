import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:ju_flutter/3widget_scaffold.dart';

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
           * DecoratedBox 装饰容器
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
                colors: [Colors.red, Colors.orange[700]],
              ), // 背景渐变
              borderRadius: BorderRadius.circular(3.0), // 3像素圆角
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 4.0,
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
              child: Text('Login', style: TextStyle(color: Colors.white)),
            ),
          ),
          /**
           * Transform 变换
           * Transform 可以在其子部件绘制时对其应用一些矩阵变换来实现一些特效。Matrix4 是一个 4D 矩阵，通过它可以实现各种矩阵操作。
           * 由于矩阵变化时发生在绘制时，而无需重新布局和构建等过程，所以性能很好。
           */
          Row(children: <Widget>[
            Container(
              color: Colors.black,
              child: new Transform(
                // 相对于坐标系原点的对齐方式
                alignment: Alignment.topRight,
                // 沿y轴倾斜0.3弧度
                transform: new Matrix4.skewY(0.5),
                child: new Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.deepOrange,
                  child: const Text('我是一段文字'),
                ),
              ),
            ),
          ]),
          // Transform.translate 接收一个 offset 参数，可以在绘制时沿 x/y 轴对子部件平移指定距离。
          Row(children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              child: Transform.translate(
                offset: Offset(20.0, 5.0),
                child: Text('Transform.translate测试'),
              ),
            )
          ]),
          // Transform.rotate 可以对子部件 旋转 转换
          Row(children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.blue),
              child: Transform.rotate(
                // 旋转90度,注意：要使用math需要倒入=>import 'dart:math' as maths
                angle: math.pi / 2,
                child: Text('Transform.translate测试'),
              ),
            )
          ]),
          // Transform.scale 可以对子部件进行 缩小或者放大 。
          Row(children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.blue),
              child: Transform.scale(
                scale: 1.5, // 子部件文字，放大1.5倍
                child: Text('Transform.translate测试'),
              ),
            )
          ]),
          /**
           * 注意：Transform的变换是应用在绘制阶段，而不是应用在布局（layout）阶段，所以无论对子部件应用何种变化，其占用空间的大小
           *    和屏幕上的位置都是固定不变的，因为这些是在布局阶段就确定了的。
           * 下面示例，由于第一个 Text 应用变换（放大）后，其在绘制时会放大，但其占用的空间依然为红色部分，所以第二个 Text会紧挨着红色部分，
           * 最终会出现文字重合。
           * 注意： 由于矩阵变化只会作用在绘制阶段，所以在某些场景下，在ui需要变化时，可以直接通过矩阵变化来达到视觉上的ui变化，而不需要去
           *    重新触发 build 流程，这样会节省 layout 的开销，所以性能比较好。比如之前的Flow部件，它内部就是用矩阵变换来更新ui，
           *    除此之外，flutter 的动画部件中也大量使用了 Transform 以提高性能。
           */
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // 居中对齐
            children: <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                child: Transform.scale(
                  // 子部件放大1.5倍
                  scale: 1.5,
                  child: Text("transform在绘制阶段不是布局阶段"),
                ),
              ),
              Text(
                "测试",
                style: TextStyle(color: Colors.green, fontSize: 18.0),
              )
            ],
          ),
          // 点击查看容器类部件-Scaffold及更多的部件
          OutlineButton(
            child: Text(
              '点击查看容器类部件-Scaffold及更多的部件',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WidgetScaffold();
              }));
            },
          ),
          /**
           * RotateBox
           * RotateBox 和 Transform.rotate 的功能相似，他们都可以对子部件进行旋转转换，但是有一点不同：
           * RotateBox 的变换是在 layout 阶段，会影响子部件的位置和大小。
           */
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.green),
                // 将 Transform.rotate 换成 RotateBox
                child: RotatedBox(
                  // 旋转90度（1/4圈）
                  quarterTurns: 1,
                  child: Text('测试 RotateBox'),
                ),
              ),
              Text('对比测试 RotateBox', style: TextStyle(color: Colors.orange))
            ],
          ),
          /**
           * Container
           * Container 是一个组合类容器，它本身不对应具体的 RenderObject，它是 DecoratedBox/ConstrainedBox/Transform/Padding和
           * Align等部件组合的多功能容器，所以我们只需通过 Container 部件可以实现同时需要装饰/变换/限制的场景。
           * Container 部件组合优于继承的实例。
            Container({
              this.alignment,
              this.padding,                    // 容器内补白，属于decoration的装饰范围
              Color color,                     // 背景色
              Decoration decoration,           // 背景装饰，color和decoration是互斥的，如果同时设置会报错，实际上当指定 color是，Container
                                                  内部会自动创建一个 decoration。
              Decoration foregroundDecoration, // 前景装饰
              double width,                    // 容器的宽度
              double height,                   // 容器的高度
              BoxConstraints constraints,      // 容器大小的限制条件，如果同时有constraints和width/height指定大小，则width/height优先，
                                                  实际上 Container 内部会根据width/height来生成一个 constraints。
              this.margin,                     // 容器外补白，不属于decoration的装饰范围
              this.transform,                  // 变换
              this.child,
            })
           */
          Container(
            margin: EdgeInsets.only(top: 10.0, left: 50.0),
            // 卡片大小
            constraints: BoxConstraints.tightFor(
              width: 200.0,
              height: 150.0,
            ),
            // 背景装饰
            decoration: BoxDecoration(
              // 背景镜像渐变
              gradient: RadialGradient(
                colors: [Colors.red, Colors.orange],
                center: Alignment.topLeft,
                radius: .98,
              ),
              // 卡片阴影
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 4.0,
                )
              ],
            ),
            // 卡片倾斜
            transform: Matrix4.rotationZ(.2),
            // 卡片内文字居中
            alignment: Alignment.center,
            // 卡片文字
            child: Text(
              '卡片内文字',
              style: TextStyle(color: Colors.white, fontSize: 40.0),
            ),
          ),
          // Container 的 Padding 和 Margin。Container 内的margin/padding都是通过Padding部件来实现。
          Container(
            margin: EdgeInsets.all(10.0), // 容器外边距
            color: Colors.red[900],
            child: Text('Container 容器的 Margin1'),
          ),
          Container(
            padding: EdgeInsets.all(10.0), // 容器外边距
            color: Colors.blue[900],
            child: Text(
              'Container 容器的 Padding1',
              style: TextStyle(color: Colors.red),
            ),
          ),
          // 等价于上面第2个（从下往上数第2个部件） Container。
          Padding(
            padding: EdgeInsets.all(10.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.red[900],
              ),
              child: Text('Container 容器的 Margin2'),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.blue[900]),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Container 容器的 Padding2',
                style: TextStyle(color: Colors.red),
              ),
            ),
          )
        ],
      ),
    );
  }
}
