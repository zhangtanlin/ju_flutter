import 'package:flutter/material.dart';
import 'package:ju_flutter/3widget_align.dart';

class WidgetPositioned extends StatefulWidget {
  @override
  _WidgetPositionedState createState() => new _WidgetPositionedState();
}

class _WidgetPositionedState extends State<WidgetPositioned> {
  @override
  Widget build(BuildContext context) {
    // 通过 ConstrainedBox来确保Stack占满全屏
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      /**
       * 层叠布局 Stack/Positioned
       * 层叠布局和web中的绝对定位，andeoid中 的Frame 布局相似，子组建可以根据距父容器四个角的位置来确定自身的位置。
       * 绝对定位允许子部件duidie起来（按照代码中声明的顺序）。flutter 中使用 Stack 和 Positioned 这两个部件来配合实现绝对定位。
       * Stack 允许子部件堆叠，而 Positioned 用于根据 Stack 的四个角来确定子部件的位置。
        Stack({
          this.alignment = AlignmentDirectional.topStart, // 此参数决定如何去对齐没有定位（没有使用 Positioned）或部分定位的子部件，
                                                              所谓部分定位，在这里特指没有在某一个轴上定位：left，right为横轴；top，bottom为纵轴，
                                                              只要包含某个轴上的一个定位属性就算在该轴上有定位。
          this.textDirection,                             // 和Row，Wap的textDirection功能一样，都用于确定alignment对齐的参考系，即
                                                              textDirection的值为TextDirection.ltr,则alignment的start代表左，end代表右；
                                                              textDirection的值为Textdirection.rtl,则alignment的start代表右，end代表左。
          this.fit = StackFit.loose,                      // 此参数用于确定没有定位的子部件如何去适应Stack的大小。StackFit.loose表示使用子部件
                                                              的大小，StackFit.expand表示扩伸到Stack的大小。
                                                              注意：因为Stack是堆叠的，所以开启之后后面的元素可能会遮盖前面的元素，无论是否定位。
          this.overflow = Overflow.clip,                  // 此属性决定如何显示超出Stack显示空间的子部件，值为 Overflow.clip时，超出部分会被裁剪，
                                                              值为Overflow.visible 时则不会。
          List<Widget> children = const <Widget>[],
        })
        * Positioned 参数详情：
        const Positioned({
          Key key,                // 
          this.left,              // 距离 Stack 左边的距离
          this.top,               // 距离 Stack 上边的距离
          this.right,             // 距离 Stack 右边的距离
          this.bottom,            // 距离 Stack 底边的距离
          this.width,             // 用于指定需要定位元素的宽度和高度，注意：Positioned 的 width/height和其他地方的意义稍微有点区别，此处用于
                                      配合 left/top/right/bottom 来定位部件。举个例子，在水平方向上，只能指定 left/right/width三个属性中的
                                      两个，如指定left和width，right会自动算出来，如果同时指定3个属性值则会报错，垂直方向同理。
          this.height,            // 
          @required Widget child, // 
        })
        */
      child: Stack(
        alignment: Alignment.center, // 指定未定位或部分定位的Widget的对齐方式
        // fit: StackFit.expand, // 指定未定位或部分定位的 Widget 延伸到 Stack 大小。【因为Stack是堆叠的所以开启之后那个未定位的Container会遮盖第一个定位的Positioned】
        children: <Widget>[
          Positioned(
            left: 100.0,
            child: Text(
              '我是第一个Positioned',
              style: TextStyle(color: Colors.blueAccent, fontSize: 16.0),
            ),
          ),
          Container(
            child: Text(
              "我是未定位的",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            color: Colors.brown,
          ),
          Positioned(
            top: 100.0,
            child: Text(
              '我是第二个Positioned',
              style: TextStyle(color: Colors.green, fontSize: 16.0),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Text(
              '我是第三个Positioned',
              style: TextStyle(color: Colors.orange, fontSize: 16.0),
            ),
          ),
          Positioned(
            bottom: 0,
            child: OutlineButton(
              child: Text(
                '点击查看对齐与相对定位及更多的部件',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return WidgetAlign();
                }));
              },
            ),
          ),
        ],
      ),
    );
  }
}
