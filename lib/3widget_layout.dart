/*
 * 布局类部件
 * 布局类部件都会包含一个或者多个子部件，不同的布局类部件对子部件排版（layout）方式不同。
 * element树才是最终的绘制树，element树是通过Widget树来创建（Widget.createElemene()）的,
 * Widget其实就是Element的配置数据，flutter中根据widget是否需要包含子节点将Widget分为了三类：
  Widget                        对应的element                    用途
  LeafRenderObjectWidget        LeafRenderObjectElement         Widget树的叶子节点，用于没有子节点的widget，通常基础部件都属于这一类，如：Image等。
  SingleChildRenderObjectWidget SingleChildRenderObjectElement  包含一个子Widget，如：ConsrainedBox，DecoratedBox等。
  MultiChildRenderObjectWidget  MultiChildRenderObjectElement   包含多个子Widget，一般都有一个children参数，接受一个Widget数组，如：Row,Stack等。
 * 注意：flutter中的很多Widget是直接继承自StatelessWidget或StatefulWidget，然后在build方法中构建真正的RenderObjectWidget，
 *      如：Text，他其实是继承自StatelessWidget，然后在build()方法中通过RichText来构建其子树，
 *      而RichText才是继承自MultiChildRenderObjectWidget。所以为了方便叙述，我们也可以说Text属于MultiChildRenderObjectWidget(其他部件也可以这样描述)，
 *      所以我们会发现，其实StatelessWidget和StatelessWidget就是两个用于组合Widget的基类，他们本身并不关联最终的渲染对象（RenderObjectWidget）。
 * 布局类部件就是指直接或间接继承（包含）MultichildRenderObjectWidget的widget，他们一般都会有一个 children 属性用于接收子widget。
 * 继承关系： widget > RenderObjectWidget > (Leaf/Siglechild/MultiChild)RenderObjectWidget。
 * RenderObjectWidget 类中定义了创建/更新 RenderObject 的方法，子类必须实现他们，关于 RenderObject 我们现在只需要知道它是最终布局/渲染UI界面的对象即可，
 * 也就是说对于布局类部件来说，对于布局部件来说，其布局算法都是通过对应的 RenderObject 对象来实现的。
 */
import 'package:flutter/material.dart';
import 'package:ju_flutter/3widget_flex.dart';

/*
 * 
 * 线性布局，即延水平或垂直方向排布子部件。
 * 对于线性布局，有主轴和纵轴之分，如果布局是沿水平方向，那主轴就是水平方向，而纵轴就是垂直方向；
 * 如果布局沿垂直方向，那么主轴就是指垂直方向，而纵轴就是水平方向。
 * 在线性布局中，有两个对齐方式的枚举类 MainAsisAlignment 和 CrossAxisAlignment 分别代表 主轴对齐和纵轴对齐。
 */
class WidgetLayout extends StatefulWidget {
  @override
  _WidgetLayoutState createState() => new _WidgetLayoutState();
}

class _WidgetLayoutState extends State<WidgetLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('布局类部件'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /// 水平方向排列其子Widget。
            /// ```
            /// Row({
            /// ...
            /// // 表示水平方向子部件的布局顺序（从左往右还是从右往左），
            /// // 默认为系统当前 Locale 环境的文本方向，
            /// // 如中文英文都是从左往右，而阿拉伯语是从右往左。
            /// TextDirection textDirection,
            /// // MainAxisSize 表示 Row 在主轴（水平）方向上占用的空间，
            /// // 默认是 max ，表示尽可能多的占用水平风向的空间，
            /// // 此时无论子Widgets实际占用多少水平空间，
            /// // Row的宽度始终等于水平方向的最大宽度；当子组建没有占满水平剩余空间，
            /// // 则Row的实际宽度等于所有子部件占用的水平空间。
            /// MainAxisSize mainAxisSize = MainAxisSize.max,
            /// // MainAxisAlignment 表示子部件在Row所占用的水平空间内对齐方式，
            /// // 如果 mainAxisSize值为 MainAxisSize.min，则此属性无意义,
            /// // 只有 mainAxisSize 值为MainAxisSize.max时，此属性才有意义。
            /// // MainAxisAlignment.start 表示沿 textDirection 的初始方向对齐，
            /// // 如果 textDirection 取值为 TextDirection.ltr 时，
            /// // 则 MainAxisAlignment.start 表示左对齐，
            /// // 如果 textDirection 取值为 TextDirection.rtl 时，
            /// // 则 MainaxisAlignment.start 表示右对齐。
            /// // MainAxisAlignment.end 和 MainAxisAlignment.start 正好相反。
            /// // MainAxisAlignment.center 表示居中对齐。
            /// // 注意：textDirection 是 mainAxisAlignment的参考系。
            /// MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
            /// // VerticalDirection 表示Row纵轴（垂直）的对齐方向，
            /// // 默认默认是 VerticalDirection.down 表示从上到下。
            /// VerticalDirection verticalDirection = VerticalDirection.down,
            /// // CrossAxisAlignment 表示子部件在纵轴方向的对齐方式，
            /// // Row 的高度等于子部件中最高的子元素高度，
            /// // 他们的取值和 MainAxis一样，包含start/end/center三个值，
            /// // 不同的是 crossAxisAlignment 的参考系是 VerticalDirection，
            /// // 即 verticalDirection 值为 verticalDirection.down 时
            /// // crossAxisAlignment.start 指顶部对齐，
            /// // verticalDirection 值为 verticaalDirection.up 时，
            /// // crossAxisAlignment.start指底部对齐，
            /// // 而 crossAxisALignment.end 和crossAxisAlignment.start 正好相反。
            /// CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
            /// // 子部件数组。
            /// List<Widget> children = const <Widget>[],
            /// })
            /// ```
            Column(
              // 测试Row对齐方式，排除Column默认居中对齐的干扰
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('第一'),
                    Text('第二'),
                    Text('第三'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('第一'),
                    Text('第二'),
                    Text('第三'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('第一'),
                    Text('第二'),
                    Text('第三'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    Text(
                      'one',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    Text('two'),
                    Text('three'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Text(
                      'one',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    Text('two'),
                    Text('three'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    Text(
                      'one',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    Text('two'),
                    Text('three'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Text(
                      'one',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    Text('two'),
                    Text('three'),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'first',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    Text(
                      'second',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text('third'),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'first',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    Text(
                      'second',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text('third'),
                  ],
                ),
              ],
            ),

            /// colum 是在垂直方向上排列子组建，参数和 Row 一样，
            /// 不同的是布局方向为垂直，主轴纵轴正好相反。
            /// 将 Colum 的宽度指定为屏幕宽度，如果想则样做，
            /// 可以通过ConstrainedBox或SizeBox，来强制更改宽度限制，后面补充。
            /// 注意：如果 Column/Row 里面再嵌套 Column/Row 那么只有最外面的
            /// Column/Row 会占用尽可能大的空间，里面的 Column/Row所占用的空间为实际大小。
            /// 如果要让里面的 Column 占满外部 Column 可以使用 Expanded 部件。
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('垂直1'),
                Text('垂直2'),
              ],
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                // 将minWidth设为double.infinity，可以使宽度占用尽可能多的空间
                minWidth: double.infinity,
              ),
              child: Column(children: <Widget>[
                Text('垂直1'),
                Text('垂直2'),
              ]),
            ),
            Container(
              height: 200.0,
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // 有效，外层Colum高度为整个屏幕
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      color: Colors.red,
                      child: Column(
                        // 无效，内层 Colum 高度为实际高度
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text("hello world "),
                          Text("I am Jack "),
                        ],
                      ),
                    ),

                    /// 使用 Expanded 部件可以让 Column/Row 内部的 Column/Row 可以充满外部 Column/Row。
                    Expanded(
                      child: Container(
                        color: Colors.red,
                        child: Column(
                          // 垂直方向居中对齐
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("1111"),
                            Text("I am Jack "),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            OutlineButton(
              child: Text('点击查看弹性布局及更多的部件'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  // 点击查看弹性布局及更多的部件
                  return WidgetFlex();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
