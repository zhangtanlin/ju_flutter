import 'package:flutter/material.dart';
import 'package:ju_flutter/3widget_decorated.dart';

class WidgetPadding extends StatefulWidget {
  @override
  _WidgetPaddingState createState() => new _WidgetPaddingState();
}

class _WidgetPaddingState extends State<WidgetPadding> {
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
           * Padding 填充
           * Padding 可以给其子节点添加填充（留白），和编剧效果类似。
            Padding({
              ...
              EdgeInsetsGeometry padding, // 是一个抽象类，我们一般都使用 EdgeInsets，
                                              它是 EdgeInsetsGeometry 的一个子类，定义了一些设置填充的快捷方法.
                                              EdgeInsets 提供的方法：
                                              1: fromLTRB(double left, double top, double right, double bottom) : 分别指定四个方向填充。
                                              2: all(double value) :  所有方向均使用相同数值的填充。
                                              3: only({ left, top, right, bottom }) : 可以设置具体某个方向的填充（可以同时指定多个方向）。
                                              4: symetric({vertical, horizontal}) : 用于设置对称方向的填充， vertical 指 top 和 bottom，
                                                  horizontal 指 left 和 right。
              Widget child,
            })
            */
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 左边添加8像素补白
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'padding one',
                    style: TextStyle(backgroundColor: Colors.red),
                  ),
                ),
                // 上下各添加8像素补白
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'padding two',
                    style: TextStyle(backgroundColor: Colors.green),
                  ),
                ),
                // 分别指定四个方向的补白
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, .0, 20.0, 20.0),
                  child: Text(
                    'padding three',
                    style: TextStyle(backgroundColor: Colors.blue),
                  ),
                )
              ],
            ),
          ),
          /**
           * 尺寸限制类容器
           * 尺寸限制类容器用于限制容器大小， flutter 中 提供了多种容器，如： ConstrainedBox/SizedBox/UnconstrainedBox/AspectRatio等。
           * ConstrainedBox 用于对子部件添加额外的约束，如果想让子部件的最小高度是80像素，
           *    可以使用 const BoxConstrains(minHeight: 80.0)作为子部件的约束。
           */
          ConstrainedBox(
              constraints: BoxConstraints(
                // 宽度尽可能大
                minWidth: double.infinity,
                // 最小高度为50像素
                minHeight: 50.0,
              ),
              child: Container(
                height: 5.0,
                // 注意：虽然将 Container 的高度设置为5像素，但是最终却是50像素，这是因为ConstrainedBox的最小高度生效了(未限制最大高度)。
                child: redBox,
              )),
          /**
           * BoxConstraints 用于设置限制条件
           * BoxConstraints 还定义了一些简便的构造函数，用于快速生成特定限制规则的 BoxConstraints ，如： 
           * BoxConstrains.tight(size, size) 可以生成给定大小的限制。
           * const BoxConstrains.expand() 可以生成一个尽可能大的用以填充一个容器的 BoxConstrains
           * 还有一些其他便捷函数，参考： https://api.flutter.dev/flutter/rendering/BoxConstraints-class.html
           */
          ConstrainedBox(
            constraints: BoxConstraints(
              // 最小宽度
              minWidth: 100.0,
              // 最大宽度
              maxWidth: double.infinity,
              // 最小高度
              minHeight: 100.0,
              // 最大高度
              maxHeight: double.infinity,
            ),
            child: Container(
              // BoxConstraints的minHeight 起作用时此处的 heigit 只能大于等于 minHeight
              height: 5.0,
              child: redBox,
            ),
          ),
          /**
           * SizeBox
           * SizeBox 用于给子元素指定固定宽高。
           * 实际上 SizeBox 只是 ConstrainedBox 的一个定制，下面的代码等价于：
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 80.0, height: 80.0),
              child: redBox
            );
            BoxConstraints.tightFor(width: 80.0, height: 80.0) 等价于
            BoxConstraints(minHeight: 80.0,maxHeight: 80.0,minWidth: 80.0,maxWidth: 80.0);
            * 实际上 ConstrainedBox 和 SizeBox 都是通过 RenderConstrainedBox 来渲染，我们可以看到 ConstrainedBox 和 SizeBox
            * 的 createRenderObject() 方法都返回的是一个 RenderConstrainedBox对象。
            @override
            RenderConstrainedBox createRenderObject(BuildContext context) {
              return new RenderConstrainedBox(
                additionalConstraints:............
              )
            }
            * 注意：如果有多重父级 ConstrainedBox 限制的话，最终的限制结果是，取多个父级 ConstrainedBox 中值比较大的值（无论层级）。
            */
          SizedBox(
            width: 150.0,
            height: 150.0,
            // 如果有 SizeBox 的 width/height 则 redBox 会自动扩大
            child: redBox,
          ),
          /**
           * UnconstrainedBox
           * UnconstrainedBox 不会对子部件产生任何限制，它允许子部件按照其本身大小绘制，一般情况下，我们会很少直接使用此部件，
           * 但在“去除”多重限制的时候也许会有帮助。
           * 注意：1）UnconstrainedBox 对父部件限制的“去除”并非是真正的去除，下面例子虽然红色区域大小显示的是 90*20，但是上方仍然有80的
           *    空白。也就是说父级部件限制的 minHeight(100.0)仍然生效，只不过它不影响最终子元素 redBox 的大小，但仍然还是占有相应的空间，
           *    可以认为此时的父 ConstrainedBox 是作用于子 UnconstrainedBox 上，而 redBox 只受子 ConstrainedBox 限制。
           *    2）是没有方法彻底去除 ConstrainedBox 的限制，所以在定义一个通用部件时，如果要对子部件指定限制，一定要注意，因为
           *    一旦指定限制条件，子部件如果要进行相关自定义大小是将非常困难，因为子部件在不更改父部件的代码的情况下无法彻底去除限制有条件。
           *    3）在时间开发中，当我们发现已经使用 SizeBox 或 ConstrainedBox 给子元素指定了宽高，但是仍然没有效果时，几乎可以断定：
           *    已经有父元素已经设置了限制。
           */
          Row(
            children: <Widget>[
              ConstrainedBox(
                // 父
                constraints: BoxConstraints(minWidth: 60.0, minHeight: 100.0),
                // 去除父级限制。如果没有中间的 UnconstrainedBox 部件，下面的红色框将显示90*100的红框，由于有了这个部件所以显示90*20
                child: UnconstrainedBox(
                  child: ConstrainedBox(
                    // 子
                    constraints: BoxConstraints(
                      minWidth: 90.0,
                      minHeight: 20.0,
                    ),
                    child: redBox,
                  ),
                ),
              )
            ],
          ),
          AppBar(
            title: Text('尺寸限制类容器'),
            actions: <Widget>[
              SizedBox(
                width: 20,
                height: 20,
                // 显示中 CircularProgressIndicator 按钮会被拉伸，这是因为 AppBar 中已经指定了 actions 按钮的限制条件，拉伸了 loading 按钮
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation(Colors.white70),
                ),
              )
            ],
          ),
          AppBar(
            title: Text('尺寸限制类容器'),
            actions: <Widget>[
              UnconstrainedBox(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  // 使用了 UnconstrainedBox 之后 CircularProgressIndicator 按钮的显示不会被拉伸
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation(Colors.white70),
                  ),
                ),
              )
            ],
          ),
          /**
           * 除了上面的常用尺寸限制类容器外还有很多。
           * 比如：AspectRatio 它可以指定子部件的长宽比 LimitedBox 用于指定最大宽高/FractionallySizedBox 可以根据
           *    父容器宽高比来设置子部件宽高等。这些部件据说很简单，可以试试。
           */
          OutlineButton(
            child: Text(
              '点击查看装饰容器及更多的部件',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WidgetDecorated();
              }));
            },
          )
        ],
      ),
    );
  }
}
