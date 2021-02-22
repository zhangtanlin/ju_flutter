/*
 * flutter SDK 内置部件介绍
 */
import 'package:flutter/material.dart';

class WidgetLayout extends StatefulWidget {
  @override
  _WidgetLayoutState createState() => new _WidgetLayoutState();
}

class _WidgetLayoutState extends State<WidgetLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('flutter SDK内置部件库介绍'),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              OutlineButton(
                child: Text('点击查看进度指示器-进度色动画及更多的部件'),
                textColor: Colors.red,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return WidgetLayout(); // 点击查看进度指示器-进度色动画及更多的部件
                  }));
                },
              ),
            ])));
  }
}
