/*
 * flutter SDK 内置部件介绍
 */
import 'package:flutter/material.dart';
import 'package:ju_flutter/3widget_btn.dart';

class WidgetText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Text 组件可创建一个带格式的文本。
          title: Text('flutter SDK内置部件库介绍'),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Text部件
                Text('Text部件(基础使用方法)'),
                Text(
                  'Text部件(控制最大行数为2，超出使用省略号显示)' * 4,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Text部件(放大字体1.5倍)',
                  textScaleFactor:
                      1.5, // 默认值通过 MediaQueryData.textScaleFactor 获得，如果没有 MediaQuery 默认值为1.0
                ),
                Text(
                  'Text部件(修改字体样式)',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 18.0,
                      height: 1.2, // 行高,不是一个绝对值，等于 fontSize * height
                      fontFamily: 'Courier',
                      background: new Paint()..color = Colors.yellow,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.dashed),
                ),
                // Text部件-通过 Text.rich 方法将 TextSpan 添加到 Text 中，之所以可以这样做，是因为 Text 其实就是 TichText的一个包装，而RichText是可以显示多种样式(富文本)的Widget。
                Text.rich(TextSpan(children: [
                  TextSpan(text: '第一部分', style: TextStyle(color: Colors.red)),
                  TextSpan(
                    text: 'www.google.com',
                    // recognizer: _tapRecognizer // 是点击链接后的一个处理器(代码省略)，关于手势识别的更多内容，后面补充。
                  ),
                  TextSpan(
                    text: '第二部分',
                    style: TextStyle(color: Colors.purple),
                  )
                ])),
                // Text部件-文本样式的继承
                DefaultTextStyle(
                  style: TextStyle(color: Colors.green[800], fontSize: 20.0),
                  textAlign: TextAlign.right,
                  child: Column(children: <Widget>[
                    Text('颜色和字体继承自默认样式'),
                    Text(
                      '颜色和字体不继承默认样式',
                      style:
                          TextStyle(fontSize: 12.0, color: Colors.yellow[900]),
                    )
                  ]),
                ),
                /*
            * Row、Column这些具有弹性空间的布局类部件可在水平（Row）和垂直（Column）方向上创建灵活的布局。
            * 其设计是基于Web开发中的Flexbox布局模型。
            */
                Row(
                  children: <Widget>[
                    Expanded(child: Center(child: Text('左侧'))),
                    Expanded(child: Center(child: Text('中部'))),
                    Expanded(child: Center(child: Text('右侧'))),
                  ],
                ),
                /*
            * Stack 堆叠布局（理解为定位布局）。Stack允子许 Widget 进行堆叠
            * 可以使用 Positioned 来定位他们相对于 Static 的上下左右四条边的位置。
            */
                Stack(
                  children: <Widget>[
                    /*
                * Container 可以创建矩形视觉元素。
                * Container 可以装饰一个 BoxDecoration，如：background/一个边框/或者一个阴影。
                * Container 也可以具有外边距（margin）/内边距（padding）和应用于其大小的约束（constraints），
                * 另外 Container 可以使用矩阵在三维空间中对其进行变换。
                */
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.red,
                    ),
                    Container(
                      width: 90,
                      height: 90,
                      color: Colors.green,
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      color: Colors.blue,
                    ),
                  ],
                ),
                OutlineButton(
                  child: Text('点击查看按钮及更多的部件'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return WidgetBtn(); // 点击查看按钮及更多的部件
                    }));
                  },
                ),
              ]),
        ));
  }
}
