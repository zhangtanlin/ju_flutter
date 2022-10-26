import 'package:flutter/material.dart';
import 'package:ju_flutter/3widget_positioned.dart';

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
      /**
       * 流式布局
       * 在介绍 Row/Column 时，如果 Widget 超出屏幕范围，则会报溢出错误。这是因为 Row 默认只有一行（Column默认只有一列，不超出屏幕），
       * 如果超出不会折行，我】我们把超出屏幕显示范围会自动折行的布局称为流式布局。flutter 通过 Wrap 和 Flow 来支持流式布局。
        Wrap({
          ...
          this.direction = Axis.horizontal,                   // Axis.horizontal为水平方向，Axis.vertical为垂直方向
          this.alignment = WrapAlignment.start,               // 沿主轴方向对齐方式
          this.spacing = 0.0,                                 // 主轴方向子 Widget 的间距
          this.runAlignment = WrapAlignment.start,            // 纵轴方向的间距
          this.runSpacing = 0.0,                              // 纵轴方向的间距
          this.crossAxisAlignment = WrapCrossAlignment.start, // 参照 Row/Column参数
          this.textDirection,
          this.verticalDirection = VerticalDirection.down,
          List<Widget> children = const <Widget>[],
        })
        */
      body: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        alignment: WrapAlignment.center,
        children: <Widget>[
          new Chip(
            avatar: new CircleAvatar(
              backgroundColor: Colors.red,
              child: Text('ni'),
            ),
            label: new Text('数据'),
          ),
          new Chip(
            avatar: new CircleAvatar(
              backgroundColor: Colors.red,
              child: Text('ni'),
            ),
            label: new Text('数据'),
          ),
          new Chip(
            avatar: new CircleAvatar(
              backgroundColor: Colors.red,
              child: Text('ni'),
            ),
            label: new Text('数据'),
          ),
          new Chip(
            avatar: new CircleAvatar(
              backgroundColor: Colors.red,
              child: Text('ni'),
            ),
            label: new Text('数据'),
          ),
          new Chip(
            avatar: new CircleAvatar(
              backgroundColor: Colors.red,
              child: Text('ni'),
            ),
            label: new Text('数据'),
          ),
          new Chip(
            avatar: new CircleAvatar(
              backgroundColor: Colors.red,
              child: Text('ni'),
            ),
            label: new Text('数据'),
          ),
          new Chip(
            avatar: new CircleAvatar(
              backgroundColor: Colors.red,
              child: Text('ni'),
            ),
            label: new Text('数据'),
          ),
          /**
           * 注意：我们一般很少使用 Flow ，因为其过于复杂，需要自己实现子 Widget 的位置转换，在很多场景下轴线考虑的是 Wrap 是否满足需求呢，
           * Flow 要用于一些需要自定义布局策略或性能要求较高（如动画中）的场景。
           * Flow优点1：性能好，Flow 是一个对子部件尺寸以及位置调整非常高效的控件，Flow 用转换矩阵在对子部件进行位置调整的时候进行了优化：
           *    在flow定位过后，如果子部件的尺寸或者位置发生了变化，在FlowDelegate 中的 paintChildren() 方法中调用
           *    context.paintChild 进行重绘，而 context.paintChild 在重绘时使用了转换矩阵，并没有实际调整部件位置。
           * Flow优点2：灵活，由于我们需要实现 FlowDelegate 的 paintChildren() 方法，所以我们需要自己计算每一个部件位置，
           *    因此，可以自定义布局策略。
           * Flow缺点1：shying复杂。
           * Flow缺点2：不能自适应部件大小，必须通过指定父容器大小或实现 TestFlowDelegate 的 getSize 返回固定大小。
           */
          Flow(
            delegate: TestFlowDelegate(margin: EdgeInsets.all(10.0)),
            children: <Widget>[
              new Container(
                width: 80.0,
                height: 80.0,
                color: Colors.amberAccent,
              ),
              new Container(
                width: 80.0,
                height: 80.0,
                color: Colors.red,
              ),
              new Container(
                width: 80.0,
                height: 80.0,
                color: Colors.green,
              ),
              new Container(
                width: 80.0,
                height: 80.0,
                color: Colors.blue,
              ),
              new Container(
                width: 80.0,
                height: 80.0,
                color: Colors.pink,
              ),
            ],
          ),
          OutlineButton(
            child: Text('点击查看层叠布局及更多的部件'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WidgetPositioned();
              }));
            },
          ),
        ],
      ),
    );
  }
}

/*
 * 在 FlowDelegate 上扩展一个 TestFlowDelegate 类
 * 可以看出，我们主要任务就是实现 paintChildren 它的主要任务是确定每一个 Widget 的位置，由于 Flow 不能自适应 Widget 的大小，
 * 我们通过在 getSize 返回一个固定大小来指定 Flow 的大小。
 */
class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;
  TestFlowDelegate({this.margin});
  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    // 计算一个子 Widget 的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        // 绘制子 Widget（有优化）
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(double.infinity, 200.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
