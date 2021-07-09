/*
 * 路由
 */
import 'package:flutter/material.dart';

// 部件
class WidgetRoute extends StatefulWidget {
  WidgetRoute({Key key}) : super(key: key);
  @override
  _WidgetRoute createState() => _WidgetRoute();
}

// 状态
class _WidgetRoute extends State<WidgetRoute> {
  @override
  Widget build(BuildContext context) {
    // MaterialUI库中提供的UI架构
    return Scaffold(
      // 标题导航栏
      appBar: AppBar(
        title: Text('路由'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 垂直居中
          children: <Widget>[
            // 跳转新路由的按钮
            FlatButton(
              child: Text("打开新路由"),
              textColor: Colors.blue, // 文字为蓝色
              onPressed: () {
                /*
                 * 导航到新路由
                 * Navigator 是一个路由管理的组件，它提供了打开和退出路由页方法。
                 * Navigator 通过一个栈来管理活动路由集合。通常当前屏幕显示的页面就是栈顶的路由。
                 * 常用方法1: Navigator.push(BuildContext context, Route route) 将给定的路由入栈（即打开新的页面），返回值是一个 future 对象，用以接收新路由出栈（即关闭）时的返回数据。
                 * 常用方法2: Navigator.pop(BuildContext context, [result]) 将栈顶路由出栈， result 为页面关闭时返回给上一个页面的数据。
                 * Navigator 还有很多其它方法，如 Navigator.replace 、 Navigator.popUntil 等。
                 */
                Navigator.push(context,
                    /*
                   * MaterialPageRoute 方法继承自抽象类 PageRoute ，是 Material 组件库提供的组件，它可以针对不同平台，实现与平台页面切换动画风格一致的路由切换动画。
                   * 使用方法: MaterialPageRoute(WidgetBuilder builder, RouteSettings settings, bool maintainState = true, bool fullscreenDialog = false,) 
                   * 参数 builder          是一个 WidgetBuilder 类型的回调函数，它的作用是构建路由页面的具体内容，返回值是一个 widget 。我们通常要实现此回调，返回新路由的实例。
                   * 参数 settings         包含路由的配置信息，如路由名称、是否初始路由（首页）。
                   * 参数 maintainState    默认情况下，当入栈一个新路由时，原来的路由仍然会被保存在内存中，如果想在路由没用的时候释放其所占用的所有资源，可以设置 maintainState 为 false 。
                   * 参数 fullscreenDialog 表示新的路由页面是否是一个全屏的模态对话框，在 iOS 中，如果 fullscreenDialog 为 true ，新页面将会从屏幕底部滑入（而不是水平方向）。
                   */
                    MaterialPageRoute(builder: (context) {
                  return NewRoute();
                }));
              },
            ),
            // 非命名路由传参
            RaisedButton(
              child: Text("打开接收参数的非命名路由"),
              textColor: Colors.orange[900], // 文字为橙色
              onPressed: () async {
                // 通过等待 Navigator.push() 返回的 future 来获取非命名路由的返回数据。
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ParamRoute(
                        text: "我是非命名路由传的参数文本", // 路由参数文本
                      );
                    },
                  ),
                ); // 打开`ParamRoute`，并等待返回结果
                print("非命名路由返回值是: $result"); // 输出 ParamRoute 非命名路由出栈时返回的结果
              },
            ),
            // 命名路由
            RaisedButton(
              child: Text("命名路由"),
              textColor: Colors.green[900],
              onPressed: () {
                Navigator.pushNamed(context, "route_name");
              },
            ),
            // 命名路由传参
            RaisedButton(
              child: Text("命名路由传参"),
              textColor: Colors.pink,
              onPressed: () async {
                var result = await Navigator.of(context)
                    .pushNamed("route_name_param", arguments: "我是命名路由传递的参数");
                print("命名路由返回值是: $result");
              },
            ),
            // 路由钩子（当点击时会触发路由前置判定，如果点击就跳转“新路由页面”）
            RaisedButton(
              child: Text("路由钩子（路由前置判定）"),
              textColor: Colors.purpleAccent[400],
              onPressed: () {
                Navigator.pushNamed(context, "route_hook");
              },
            ),
          ],
        ),
      ),
    );
  }
}

// 创建新路由
class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Container 背景图模块
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/common/bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

/*
 * 非命名路由传参
 * 在 ParamRoute 页中有两种方式可以返回到上一页；第一种方式是直接点击导航栏返回箭头（不会返回数据给上一个路由），第二种方式是点击页面中的“返回”按钮（会返回数据给上一个路由）。
 */
class ParamRoute extends StatelessWidget {
  ParamRoute({
    Key key,
    @required this.text, // 接收一个传递过来的 text 参数
  }) : super(key: key);
  final String text; // 定义一个 final 类型的字符串（把传递过来的 text 参数赋值给这个字符串）
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('非命名路由传参'),
        ),
        body: Padding(
            padding: EdgeInsets.all(18),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(text),
                  RaisedButton(
                    child: Text('返回'),
                    textColor: Colors.orange[900], // 文字为橙色
                    onPressed: () => Navigator.pop(context, '1参数2路由3返回值4'),
                  ),
                  Text('非命名路由出栈时传递的参数：1参数2路由3返回值4')
                ],
              ),
            )));
  }
}

// 命名路由
class RouteName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('命名路由的页面'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('返回'),
                textColor: Colors.green[900],
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ));
  }
}

// 命名路由传参
class RouteNameParam extends StatelessWidget {
  RouteNameParam({
    Key key,
    @required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('命名路由传参'),
        ),
        body: Padding(
            padding: EdgeInsets.all(18),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(text),
                  RaisedButton(
                    child: Text('返回'),
                    textColor: Colors.green[900],
                    onPressed: () => Navigator.pop(context, '5参数6路由7返回值8'),
                  ),
                  Text('命名路由出栈时传递的参数：5参数6路由7返回值8')
                ],
              ),
            )));
  }
}
