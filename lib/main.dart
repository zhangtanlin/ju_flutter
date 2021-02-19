// 倒入 ui
import 'package:flutter/material.dart';
import 'package:ju_flutter/2statefullWidget.dart';
import 'package:ju_flutter/2statelessWidget.dart';
import 'package:ju_flutter/3widget_text.dart';
import 'package:ju_flutter/4cupertino.dart';

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
    /**
     * MaterialUI库中提供的UI架构。
     * flutter 提供了一套丰富的 Material 部件，他可以帮助我们构建遵循 Material Design 设计规范，
     * Material 应用程序以 MaterialApp 部件开始，该部件在应用程序的根部创建一些必要的部件，比如 Theme 部件用于配置应用主题。
     * 是否使用 MaterialApp完全是可选的，但是使用它是一个很好的做法，我们已经使用了多个 Material 部件，例如：
     * Scaffold,AppBar,FlatButton等，注意要使用Material 部件，需要先引入它： import 'package:flutter/material.dart';
     */
    return MaterialApp(
        title: 'Flutter 示例',
        theme: ThemeData(
          // 应用的主题
          primarySwatch: Colors.blue, // 可选颜色 Colors.green等
          visualDensity: VisualDensity
              .adaptivePlatformDensity, // 密度（可选-4到4之间的值，越小表示越密集/更紧凑。此处的值表示。此处的值表示：台式机平台使用紧凑型，其他平台按规范来）
        ),
        // home: MyHomePage(title: 'flutter 首页'), // 首页部件（也可以使用注册路由的方式来注册 MyHomePage 部件）
        // 注册路由
        routes: {
          '/': (context) => MyHomePage(title: "flutter 首页"), // 首页部件
          'route_name': (context) => RouteName(), // 命名路由
          'show_echo': (context) => ShowEcho(),
          'child_get_parent': (context) => ChildGetParent(),
          'counter_widget': (context) => CounterWidget(),
          'widget_text': (context) => WidgetText(),
          'cupertino_list': (context) => CupertinoList(),
          'route_name_param': (context) {
            return RouteNameParam(
                text: ModalRoute.of(context).settings.arguments);
          }, // 命名路由传参
        },
        /*
         * 路由钩子【重点】
         * MaterialApp 的 onGenerateRoute 属性，在打开命名路由时可能会被调用，
         * 之所以说可能，是因为当调用 Navigator.pushNamed() 打开命名路由时，
         * 如果指定的路由名在路由表中已注册，则会调用路由表中的 builder 函数来生成路由组件；
         * 如果路由表中没有注册，才会调用 onGenerateRoute 来生成路由。
         * 注意1: onGenerateRoute 的使用和注册路由及路由打开方式相关。
         * 注意2:其他路由钩子，比如: navigatorObservers 和 onUnknownRoute两个回调属性，前者可以监听所有路由跳转动作，后者在打开一个不存在的命名路由时会被调用。
         * 建议:命名路由只是一种可选的路由管理方式，在实际开发中，建议最好统一使用命名路由的管理方式。
         *      原因1:语义化更明确。
         *      原因2:代码更好维护；如果使用匿名路由，则必须在调用 Navigator.push() 的地方创建新路由页，这样不仅需要 import 新路由页的 dart 文件，而且这样的代码将会非常分散。
         *      原因3:可以通过 onGenerateRoute 做一些全局的路由跳转前置处理逻辑。
         */
        onGenerateRoute: (RouteSettings settings) {
          if (settings.name == 'route_hook') {
            return MaterialPageRoute(builder: (context) {
              return Login();
            });
          }
          return null;
        });
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
              'clumn 的文字部件，我是文字部件，我还是第一个文字部件哟第一一一一一一一一一一一一一一一一一一一一',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
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
                Navigator.pushNamed(context, "show_echo");
              },
            ),
            // 子树中获取父级widget
            RaisedButton(
              child: Text("子树中获取父级 widget"),
              textColor: Colors.black,
              onPressed: () {
                Navigator.pushNamed(context, "child_get_parent");
              },
            ),
            // 部件内 state 的生命周期
            RaisedButton(
              child: Text("点击查看部件 CounterWidget 生命周期"),
              textColor: Colors.blue[900],
              onPressed: () {
                Navigator.pushNamed(context, "counter_widget");
              },
            ),
            // flutter SDK内置部件介绍
            RaisedButton(
              child: Text("点击查看 flutter SDK 内置部件介绍"),
              textColor: Colors.amber[900],
              onPressed: () {
                Navigator.pushNamed(context, "widget_text");
              },
            ),
            // flutter Cupertino ui 的部件介绍
            RaisedButton(
              child: Text("flutter Cupertino ui 的部件介绍"),
              textColor: Colors.deepPurple[900],
              onPressed: () {
                Navigator.pushNamed(context, "cupertino_list");
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

// 创建新路由
class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Container 背景图模块
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/bg.jpg"), fit: BoxFit.cover)),
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

// 登陆界面
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('登陆'),
        ),
        body: Center(child: Text('登陆界面')));
  }
}

// 自定义 echo 部件
class ShowEcho extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Echo(text: "自定义的 Echo 部件");
  }
}