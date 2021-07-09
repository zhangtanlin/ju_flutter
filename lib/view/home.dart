import 'package:flutter/material.dart';
import 'package:ju_flutter/components/echo.dart';
import 'package:ju_flutter/route/application.dart';

/// 首页界面（有状态）
///
/// 1:可以理解为具有动态可交互的内容界面，会根据数据的变化进行多次渲染。
/// 2:继承自Widget类，重写了createElement()方法。
/// 3:添加了一个新的接口createState()。
/// 4:与无状态部件的区别是=>返回的 Element 对象并不相同。
/// 状态在widget生命周期中是可以变的
@immutable
class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  State createState() => _HomeState();
}

/// Home 类对应的状态类
///
/// [_counter]需要维护的状态
/// [_incrementCounter]设置状态的自增函数
/// [setState]先自增再通知 flutter 框架状态更改 => flutter 框架会执行下面的 build 方法重新构建。
class _HomeState extends State<Home> {
  int _counter = 0;

  void initState() {
    _initData();
    super.initState();
  }

  /// 获取数据
  void _initData() async {}

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  /// 部件构建/重新构建（每次调用 setState 方法都会重新运行此方法）
  @override
  Widget build(BuildContext context) {
    // MaterialUI库中提供的UI架构
    return Scaffold(
      // 标题导航栏
      appBar: AppBar(
        title: Text('欢迎'), // 从App.build方法创建的MyHomePage对象中获取值，设置应用栏标题。
      ),
      // body（包含一个 center 小部件， Center 部件可以将其子部件树对齐到屏幕中心）
      body: Center(
        // 子部件（ Column 布局部件的作用是将其所有子部件沿屏幕垂直方向依次排列，默认左对齐）
        child: Column(
          // 在控制台中按“ p”可以查看每个小部件的线框。列具有各种属性，可控制其自身大小以及子元素的位置。
          mainAxisAlignment: MainAxisAlignment.center, // 垂直居中
          children: <Widget>[
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            // 路由学习
            RaisedButton(
              child: Text("路由学习"),
              textColor: Colors.red,
              onPressed: () {
                Application.fluroRouter.navigateTo(context, 'customizeRouter');
              },
            ),
            // 错误处理方法调用
            RaisedButton(
              child: Text("别点我！点我程序就报错"),
              textColor: Colors.cyan[600],
              onPressed: () {
                try {
                  throw '错误提示'; // 主动抛出错误，调试模式下代码会在此处暂停
                } catch (e) {
                  print("catch的错误:$e");
                }
              },
            ),
            // 打开自定义 Echo 部件（新部件内部使用自定义弹出框部件弹出数据
            RaisedButton(
              child: Text("点击打开自定义 Echo 部件"),
              textColor: Colors.deepOrange[900],
              onPressed: () {
                Application.fluroRouter.navigateTo(context, 'customizeEcho');
              },
            ),
            // 子树中获取父级widget
            RaisedButton(
              child: Text("子树中获取父级 widget"),
              textColor: Colors.black,
              onPressed: () {
                Application.fluroRouter.navigateTo(context, 'childGetParent');
              },
            ),
            // 部件内 state 的生命周期
            RaisedButton(
              child: Text("点击查看部件 CounterWidget 生命周期"),
              textColor: Colors.blue[900],
              onPressed: () {
                Application.fluroRouter.navigateTo(context, 'lifeCycle');
              },
            ),
            // flutter SDK内置部件介绍
            RaisedButton(
              child: Text("点击查看 flutter SDK 内置部件介绍"),
              textColor: Colors.amber[900],
              onPressed: () {
                Application.fluroRouter.navigateTo(context, 'textWidget');
              },
            ),
            // flutter Cupertino ui 的部件介绍
            RaisedButton(
              child: Text("flutter Cupertino ui 的部件介绍"),
              textColor: Colors.deepPurple[900],
              onPressed: () {
                Application.fluroRouter.navigateTo(context, 'cupertinoList');
              },
            ),
          ],
        ),
      ),
      // 右下角按钮
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter, // 点击回调函数（点击之后的处理器）
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

// 自定义 echo 部件
class ShowEcho extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Echo(text: "自定义的 Echo 部件");
  }
}
