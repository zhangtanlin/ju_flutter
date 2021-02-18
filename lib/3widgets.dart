/*
 * flutter SDK 内置部件介绍
 */
import 'package:flutter/material.dart';
import 'package:ju_flutter/5state.dart';

class WidgetList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Text 组件可创建一个带格式的文本。
          title: Text('flutter SDK内置部件库介绍'),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
              /**
             * Stack 堆叠布局（理解为定位布局）。Stack允子许 Widget 进行堆叠
             * 可以使用 Positioned 来定位他们相对于 Static 的上下左右四条边的位置。
             */
              Stack(
                children: <Widget>[
                  /**
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
              // 点击查看 Widget 管理自己的 State 状态
              OutlineButton(
                child: Text('点击查看 Widget 管理自己的 State 状态'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SelfState();
                  }));
                },
              ),
              // 点击查看父 Widget 管理State 状态
              OutlineButton(
                child: Text('击查看父 Widget 管理State 状态'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ParentState();
                  }));
                },
              )
            ]));
  }
}
