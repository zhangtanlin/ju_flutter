/*
 * flutter SDK 内置部件介绍
 */
import 'package:flutter/material.dart';
import 'package:ju_flutter/3widget_textfield.dart';

class WidgetCheckbox extends StatefulWidget {
  @override
  _WidgetCheckboxState createState() => new _WidgetCheckboxState();
}

class _WidgetCheckboxState extends State<WidgetCheckbox> {
  // 单选框状态
  bool _switchSelected = true;
  // 复选框状态
  bool _checkboxSelected = true;
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
            Text('单选框的值是$_switchSelected'),
            Text('多选框的值是$_checkboxSelected'),
            /**
             * 单选框
             * value       当前状态 bool 值
             * activeColor 选中时的颜色，包含句柄和后面块状背景色
             */
            Switch(
              value: _switchSelected, // 当前状态
              activeColor: Colors.teal[900],
              onChanged: (value) {
                setState(() {
                  _switchSelected = value;
                });
              },
            ),
            /**
             * 多选框
             * value       当前状态 bool 值。
             * activeColor 选中时的背景色，不包含边框色。
             * tristate    默认 checkBox 只有选中(true)和未选中(false),
             * 但是当 tristate为true时，value 的值会增加一个 null 的状态(类似树状结构的未全选状态)。
             */
            Checkbox(
              value: _checkboxSelected,
              activeColor: Colors.redAccent,
              tristate: true,
              onChanged: (value) {
                setState(() {
                  _checkboxSelected = value;
                });
              },
            ),
            OutlineButton(
              child: Text('点击查看输入框/表单及更多的部件'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  // 点击查看输入框
                  return WidgetTextField();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
