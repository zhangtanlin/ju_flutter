// 倒入 ui
import 'package:flutter/material.dart';

// 应用入口：个人感觉main函数是应用入口；runApp是运行方法；MyApp是根部件
void main() {
  runApp(MyApp());
}

/*
 * 根部件（无状态）
 * 1:可以理解为将外部传入的数据转化为界面展示的内容，只会渲染一次。
 * 2:继承自Widget类，重写了createElement()方法。
 * 3：通常在build方法中通过嵌套其它Widget来构建UI，在构建过程中会递归的构建其嵌套的Widget。
 * Flutter中真正代表屏幕上显示元素的类是 Element，Widget 只是描述 Element 的配置数据。
 */
class MyApp extends StatelessWidget {
  @override // 指出该函数在祖先类中定义过的（继承来的），但是正在被重新定义以在当前类中执行其他操作。它还用于注释抽象方法的实现。它是可选的，建议使用，可以提高可读性。
  // 部件开始构建
  Widget build(BuildContext context) {
    // MaterialUI库中提供的UI架构
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // 应用的主题
        primarySwatch: Colors.blue, // 可选颜色 Colors.green等
        visualDensity: VisualDensity
            .adaptivePlatformDensity, // 密度（可选-4到4之间的值，越小表示越密集/更紧凑。此处的值表示。此处的值表示：台式机平台使用紧凑型，其他平台按规范来）
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'), // 首页部件
    );
  }
}

/*
 * 首页部件（有状态）
 * 1:可以理解为具有动态可交互的内容界面，会根据数据的变化进行多次渲染。
 * 2:继承自Widget类，重写了createElement()方法。
 * 3:添加了一个新的接口createState()。
 * 4:与无状态部件的区别是=>返回的 Element 对象并不相同。
 * 状态在widget生命周期中是可以变的
 */
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title; // title状态值（final表示赋值之后不再改变）
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

/*
 * MyHomePage 类对应的状态类
 * _counter          需要维护的状态
 * _incrementCounter 设置状态的自增函数
 * setState          先自增再通知 flutter 框架状态更改 => flutter 框架会执行下面的 build 方法重新构建。
 */
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  @override
  // 部件构建/重新构建（每次调用 setState 方法都会重新运行此方法）
  Widget build(BuildContext context) {
    // MaterialUI库中提供的UI架构
    print(widget);
    return Scaffold(
      // 标题导航栏
      appBar: AppBar(
        title: Text(widget.title), // 从App.build方法创建的MyHomePage对象中获取值，设置应用栏标题。
      ),
      // body（包含一个 center 小部件， Center 部件可以将其子部件树对齐到屏幕中心）
      body: Center(
        // 子部件（ Column 布局部件的作用是将其所有子部件沿屏幕垂直方向依次排列，默认左对齐）
        child: Column(
          // 在控制台中按“ p”可以查看每个小部件的线框。列具有各种属性，可控制其自身大小以及子元素的位置。
          mainAxisAlignment: MainAxisAlignment.center, // 垂直居中
          children: <Widget>[
            Text(
              'You have pushed the buttonbuttonbuttonbuttonbuttonbuttonbuttonbuttonbuttonbutton this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
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
