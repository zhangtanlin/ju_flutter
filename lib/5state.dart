/*
 * 响应式编程框架都会有一个主题-状态管理，无论是在react/vue（两者都是支持响应式编程的web开发框架）还是在 flutter 中。
 * StatefullWidget 的状态被谁管理？Widget本身？父Widget？都会？还是另一个对象？答案是取决于实际情况。
 * 官方给的一些规则：
 * 1:如果状态是用户数据，如复选框的选中状态/滑块的位置，则该状态最好由父Widget管理。
 * 2:如果状态是有关界面外观效果的，例如颜色/动画/那么状态由 Widget本身管理。
 * 3:如果某个状态是不同的Widget共享的，则最好是由他们共同的父Widget管理。
 * 4:在widget内部管理状态封装性会好一些，而在父widget中管理会比较灵活。有些时候如果不确定到底该怎么管理状态，那么推荐的首选是父Widget中管理。
 */
import 'package:flutter/material.dart';

// Widget 管理本身状态
class SelfState extends StatefulWidget {
  SelfState({Key key}) : super(key: key);
  @override
  _SelfStateState createState() => new _SelfStateState();
}

// Widget 管理本身状态-管理 SelfState 类的状态ß
class _SelfStateState extends State<SelfState> {
  bool _active = false; //定义当前初始化状态
  void _handleTap() {
    // 更新_active，并调用setState()更新UI
    setState(() {
      _active = !_active;
    });
  }

  Widget build(BuildContext context) {
    return new GestureDetector(
      // 不懂这个部件，后面再补充
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            _active ? '执行（颜色为绿色）' : '未执行（颜色为灰色）',
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

/*
 * 父 widget 管理子 Widget 的状态。
 * 对于父widget 来说管理状态并告诉子widget 何时更新通常是比较好的方式。例如：
 * IconButton 是一个图标按钮，但它是一个无状态的Widget ，因为我们认为父 Widget 需要知道该按钮是否被点击来采取相应处理。
 */
class ParentState extends StatefulWidget {
  @override
  _ParentWidgetState createState() => new _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentState> {
  bool _active = false;
  void _handleStateChange(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new ChildA(
        active: _active,
        onChange: _handleStateChange
      ),
    );
  }
}

class ChildA extends StatelessWidget {
  ChildA({Key key, this.active: false, @required this.onChange})
      : super(key: key);
  final bool active;
  final onChange;

  void _handle() {
    onChange(!active);
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handle,
      child: new Container(
        child: new Center(
          child: new Text(
            active ? '执行（颜色为绿色）': '色为灰色）',
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          )
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color: active ? Colors.lightGreen[700]: Colors.grey[600],
        ),
      )
    );
  }
}
