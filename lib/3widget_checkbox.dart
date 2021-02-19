/*
 * flutter SDK 内置部件介绍
 */
import 'package:flutter/material.dart';
import 'package:ju_flutter/3widget_btn.dart';

class WidgetCheckbox extends StatelessWidget {
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
                OutlineButton(
                  child: Text('表单'),
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
