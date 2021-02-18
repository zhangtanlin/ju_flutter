/*
 * flutter SDK 内置部件介绍
 */
import 'package:flutter/material.dart';
import 'package:ju_flutter/5state.dart';

class WidgetList2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('flutter SDK内置部件库介绍2'),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            /**
               * 按钮
               * Material 部件库提供了多种按钮部件，如：RaisedButton/FlatButton/OutlineButton等，
               * 他们都是直接或间接对 RawMaterialButton 部件的包装定制，所以他们大多数属性都和 RawMaterialButton一样。
               * Material 库按钮相同点：
               * 1:按下时都会有水波动画（又称‘涟漪动画’，就是按钮点击时会出现水波荡漾的动画）。
               * 2:有一个 onPressed属性来设置点击回调，当按钮按下时会执行该回调，如果不提供该回调则按钮处于禁用状态，禁用状态不相应用户点击。
               */
            // 漂浮按钮（默认带有阴影和灰色背景，按下后，阴影会变大）
            RaisedButton(
              child: Text('点击查看 Widget 管理自己的 State 状态'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SelfState(); // 点击查看 Widget 管理自己的 State 状态
                }));
              },
            ),
            // 扁平按钮（默认背景透明并不带阴影，按下后会有背景色）
            FlatButton(
              child: Text('击查看父 Widget 管理State 状态'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ParentState(); // 点击查看父 Widget 管理State 状态
                }));
              },
            ),
            // 带有边框，不带阴影且背景透明的按钮，按下之后边框颜色会变亮，同时出现北京和阴影（较弱）。
            OutlineButton(
              child: Text('点击查看混合管理管理State 状态'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Mixingwidget(); // 点击查看混合管理管理State 状态
                }));
              },
            ),
            // 可点击的Icon按钮，不包括文字/默认没有背景，点击之后会出现背景。
            IconButton(icon: Icon(Icons.thumb_up), onPressed: null),
            // 带图标的按钮
            RaisedButton.icon(
                icon: Icon(Icons.send),
                label: Text('带图标的-漂浮按钮'),
                onPressed: () => {}),
            FlatButton.icon(
                icon: Icon(Icons.send),
                label: Text('带图标的-扁平按钮'),
                onPressed: () => {}),
            OutlineButton.icon(
                icon: Icon(Icons.send),
                label: Text('带图标的-边框按钮'),
                onPressed: () => {}),
            /**
             * 自定义按钮外观参数
              const FlatButton({
                Key key,
                @required VoidCallback onPressed,               // 点击按钮的回调函数
                @required Widget       child                    // 子节点
                ValueChanged<bool>     onHighlightChanged,      // 高亮变化的回调
                ButtonTextTheme        textTheme,               // 按钮的字体主题
                Color                  textColor,               // 字体颜色
                Color                  disabledTextColor,       // 禁用时的字体颜色
                Color                  color,                   // 按钮背景色【没有去除背景色的设置，若要去除背景需要把背景色设置为全透明 color: Color(0x000000)】
                Color                  disabledColor,           // 禁用时的背景色
                Color                  focusColor,              // 联动节点获得焦点时的颜色
                Color                  hoverColor,              // 鼠标悬停时的颜色
                Color                  highlightColor,          // 按下背景颜色（长按，不是点击）
                Color                  splashColor,             // 点击时，水波动画中水波的颜色
                Brightness             colorBrightness,         // 按钮亮度，默认是浅色主题 
                double                 elevation,               // 阴影尺寸
                double                 focusElevation,          // 联动节点获得焦点时的阴影尺寸
                double                 hoverElevation,          // 鼠标悬停时阴影尺寸
                double                 highlightElevation,      // 长按阴影尺寸
                double                 disabledElevation,       // 禁用时的阴影尺寸
                EdgeInsetsGeometry     padding,                 // 内边距
                ShapeBorder            shape,                   // 按钮的形状/外形
                Clip                   clipBehavior: Clip.none, // 裁剪
                FocusNode              focusNode,               // 联动节点
                MaterialTapTargetSize  materialTapTargetSize,   // 有效的点击区域大小
                Duration               animationDuration,       // 动画时间  
                double                 minWidth,                // 最小宽
                double                 hight,                   // 高度
              })
              详细参数，参考文档地址：https://www.jianshu.com/p/f851f045f81c
             */
            RaisedButton(
              color: Colors.blue, // 可以设置背景色
              highlightColor: Colors.red,
              splashColor: Colors.grey,
              child: Text("蓝色背景+点击背景为红色+圆角按钮+漂浮按钮"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {},
            ),
            FlatButton(
              textColor: Colors.red,
              highlightColor: Color(0x000000), // 按下时-背景色
              splashColor: Color(0x000000), // 按下时-水波动画为透明
              child: Text("透明背景+点击背景透明+圆角按钮+红色文字+扁平按钮"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {},
            ),
            OutlineButton(
              color: Colors.orange[900],
              textColor: Colors.green,
              highlightColor: Color(0x000000), // 按下时-背景色
              splashColor: Color(0x000000), // 按下时-水波动画为透明
              borderSide: new BorderSide(color: Colors.black), // 边框颜色
              highlightedBorderColor: Colors.red, // 按下时-边框颜色
              child: Text("透明背景+按下透明效果+圆角按钮+红色文字+扁平按钮"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {},
            )
          ]),
        ));
  }
}
