/*
 * flutter SDK 内置部件介绍
 */
import 'package:flutter/material.dart';

class WidgetImg extends StatelessWidget {
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
                OutlineButton.icon(
                    icon: Icon(Icons.send),
                    label: Text('这是图片'),
                    onPressed: () => {}),
              ]),
        ));
  }
}
