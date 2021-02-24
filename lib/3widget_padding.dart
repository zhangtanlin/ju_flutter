import 'package:flutter/material.dart';

class WidgetPadding extends StatefulWidget {
  @override
  _WidgetPaddingState createState() => new _WidgetPaddingState();
}

class _WidgetPaddingState extends State<WidgetPadding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('布局类部件'),
        ),
        body: Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            alignment: WrapAlignment.center,
            children: <Widget>[
              /**
               * 对齐与相对定位
               * 如果简单调整一个子元素在父元素中的位置，可以根据子部件的宽高来确定自身的宽高。
                Align({
                  Key key,
                  this.alignment = Alignment.center, // 表示子部件在父部件中的起始位置。Alignment，是一个抽象类，
                                                        他有两个常用的子类：Alignment 和 FractionalOffset。
                  this.widthFactor,                  // 用于确定 Align 部件本身宽高的属性；他们是两个缩放因子，会分别乘以元素的宽高，最终的结果就是
                                                        Align 部件的宽高，如果值为 null 滋味儿部件的宽高将会占用尽可能多的空间。
                  this.heightFactor,
                  Widget child,
                })
                注意：Alignment 抽象类继承自 AlignmentGeometry ，表示矩形内的一个点，他有两个属性x/y，分别表示在水平和垂直方向的偏移。
                     Alignment 部件会以矩形中心点作为坐标原点，即 Alignment(0.0, 0.0)。 
                     x/y值从-1到1分别代表矩形左边到右边的距离和顶部到底边的距离，因此两个水平（或垂直）单位则等于矩形的宽（高），如：
                     Alignment(-1.0, -1.0) 代表矩形的左侧顶点【topLeft】；
                     Alignment(1.0, 1.0) 代表矩形的右侧底部终点【bottomRight】；
                     Alignment(1.0, -1.0) 代表矩形的右侧顶点【topRight】；
                     Alignment(-1.0, 1.0) 代表矩形的左侧底部终点【bottomLeft】。
                     计算方式是：(Alignment.x * childWidth / 2 + childWidth / 2, Alignment.y * childHeight / 2 + childHeight / 2)
               * Align 和 Stack 的对比：
               * 相同点：都可以用于指定子元素相对于父元素的偏移。
               * 不同点：
               *    1)定位参考系统不同，Stack/Position 定位的参考系可以是父容器的四个顶点；而 Align 则需要先通过 alignment
               *    参数来确定坐标原点，不同的 alignment 会对应不同原点，最终的偏移是需要通过 alignment 的转换公式来计算出。
               *    2) Stack 可以有多个子元素，并且子元素可以堆叠，而 Align 只能有一个子元素，不存在堆叠。
               */
              Container(
                height: 120.0,
                width: 120.0,
                color: Colors.blue[50],
                child: Align(
                  alignment: Alignment
                      .topRight, // 通过 Alignment.topRight 将flutterLogo 定位到Container的右上角
                  child: FlutterLogo(
                    size: 60,
                  ), // FlutterLogo 是 flutter SDK 提供的一个部件，内容就是 flutter 的商标
                ),
              ),
              Container(
                height: 120.0,
                width: 120.0,
                color: Colors.blue[50],
                child: Align(
                  widthFactor:
                      2, // 添加 widthFactor 和 heightFactor 效果一样，因为FlutterLogo 宽高为60，则Align的最终宽高都是 2*60=120
                  heightFactor: 2,
                  alignment: Alignment.topRight,
                  child: FlutterLogo(
                    size: 60,
                  ),
                ),
              ),
              Container(
                height: 120.0,
                width: 120.0,
                color: Colors.blue[50],
                child: Align(
                  widthFactor: 2,
                  heightFactor: 2,
                  alignment: Alignment(-1.0, 1.0), // Alignment 抽象类设置位置（详情在上面查看）
                  child: FlutterLogo(
                    size: 60,
                  ),
                ),
              ),
              Container(
                height: 120.0,
                width: 120.0,
                color: Colors.blue[50],
                child: Align(
                  widthFactor: 2,
                  heightFactor: 2,
                  alignment:
                      Alignment(2.0, 0.0), // 带入上面的公式可以计算出，实际偏移坐标为(90, 30)。
                  child: FlutterLogo(
                    size: 60,
                  ),
                ),
              ),
              /**
               * FractionalOffset 继承自 Aligment，它和 Alignmen 唯一的区别就是坐标圆点不同。
               * FractionalOffset 的坐标原点为矩形的左侧顶点，这和 Alignment 以中心点为坐标原点不一样，
               * FractionalOffset 坐标转换公式为：
                实际偏移 = (FractionOffset.x * childWidth, FractionOffset.y * childHeight)
               */
              Row(children: <Widget>[
                Container(
                  height: 120.0,
                  width: 120.0,
                  color: Colors.blue[50],
                  child: Align(
                    widthFactor: 2,
                    heightFactor: 2,
                    alignment:
                        FractionalOffset(0.1, 0.2), // 带入之后可以算出，实际偏移为（6, 12）
                    child: FlutterLogo(
                      size: 60,
                    ),
                  ),
                )
              ]),
              /**
               * Center 部件
               * Center 部件继承自 Align，它比 Align 少了一个 alignment 参数。由于 Align 的构造函数中 alignment 值为 Alignment.center
               * 所以，可以认为 Center 部件其实是对齐方式确定(Alignment.center)了的 Align 。 
               * 注意：widthFactory 或 heightFactory 为 null 时部件的宽高将会占用尽可能多的空间。
               */
              DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                  child: Center(
                    child: Text('xxxxxxx1'),
                  )),
              DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                  child: Center(
                    widthFactor: 1, // 添加 widthFactor 和 heightFactor 效果一样，例如：Text 宽高为60，则Align的最终宽高都是 1*60=120
                    heightFactor: 1,
                    child: Text('xxxxxxx2'),
                  )),
            ]));
  }
}
