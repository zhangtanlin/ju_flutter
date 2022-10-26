import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ju_flutter/store/testStatus.dart';
import 'package:ju_flutter/utils/util_language.dart';
import 'package:ju_flutter/route/application.dart';
import 'package:ju_flutter/route/route_list.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';

/// 应用入口
///
/// [main()]函数是应用入口；
/// [debugPaintSizeEnabled]控制是否显示部件边线，使用时需要引入 import 'package:flutter/rendering.dart';
/// [SpUtil.getInstance()]异步初始化 sp_util 插件"数据持久化"[shared_preferences]的一些方法。
/// [runApp()]运行方法；
/// [MyApp()]根部件
/// 注意： 如果要运行异步代码需要引入[WidgetsFlutterBinding.ensureInitialized()]。
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // debugPaintSizeEnabled = true;
  await SpUtil.getInstance();

  /// 跨部件状态共享
  ///
  /// [MultiProvider()]状态共享插件，使用时需要导入 import 'package:provider/provider.dart';
  /// [TestState]是在'./store/testStatus.dart'内定义的共享状态类，注意要引入 import 'package:flutter/foundation.dart';
  /// 参考文档： [https://pub.dev/packages/provider]。
  /// 注意在定义和使用中（context.watch<TestState>().test）都需要引入 import 'package:provider/provider.dart';
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TestState()),
    ],
    child: MyApp(),
  ));

  /// 设置状态栏样式
  ///
  /// [statusBarColor] 状态栏背景色(什么颜色都可以)
  /// [statusBarIconBrightness] 状态栏图标颜色【默认为深色(Brightness.dark)，可选亮色(Brightness.light)】
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.black26,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  /// 强制应用程序竖屏
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
  );
}

/// 根部件（无状态）
///
/// 1:可以理解为将外部传入的数据转化为界面展示的内容，只会渲染一次。
/// 2:继承自Widget类，重写了createElement()方法。
/// 3：通常在build方法中通过嵌套其它Widget来构建UI，在构建过程中会递归的构建其嵌套的Widget。
/// Flutter中真正代表屏幕上显示元素的类是 Element，Widget 只是描述 Element 的配置数据。
/// [@override]从该函数在祖先类中定义过的（继承来的），但是正在被重新定义以在当前类中执行其他操作。它还用于注释抽象方法的实现。它是可选的，建议使用，可以提高可读性。
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 引入路由
    ///
    /// [router]新建 fluro
    /// [RouteList]自定义路由
    /// [Application]实例化路由。
    /// 如果使用[StatelessWidget]构建[MyApp]，可以使用下面两种方法引入路由，
    /// 第一种方法是使用[initState()]来引入，第二种方法是使用[MyApp()]方法引入：
    /// ```
    /// void initState() {
    ///  final router = FluroRouter();
    ///  RouteList.configureRoutes(router);
    ///  Application.fluroRouter = router;
    ///  super.initState();
    /// }
    /// 或者
    /// MyApp() {
    ///   final router = FluroRouter();
    ///   RouteList.configureRoutes(router);
    ///   Application.fluroRouter = router;
    /// }
    /// ```
    final router = FluroRouter();
    RouteList.configureRoutes(router);
    Application.fluroRouter = router;

    /// Material UI 库中提供的UI架构
    ///
    /// flutter 提供了一套丰富的 Material 部件，他可以帮助我们构建遵循 Material Design 设计规范，
    /// Material 应用程序以 MaterialApp 部件开始，该部件在应用程序的根部创建一些必要的部件，
    /// 比如 Theme 部件用于配置应用主题。
    /// 是否使用 MaterialApp完全是可选的，但是使用它是一个很好的做法，我们已经使用了多个 Material 部件，例如：
    /// Scaffold,AppBar,FlatButton等，注意要使用Material 部件，需要先引入它： import 'package:flutter/material.dart';
    /// [title]应用标题
    /// [UtilLanguage.appName]表示标题根据设置的语言使用对应的简繁字体
    return MaterialApp(
      title: UtilLanguage.appName,

      /// [theme]应用主题
      ///
      /// 参考文档：[https://medium.com/flutter-community/themes-in-flutter-part-1-75f52f2334ea]
      /// [ThemeData()]设置主题方法
      /// [primaryColor]应用程序主要部分（例如工具栏，标签栏，appbar等）的背景色。【不能使用使用透明色】
      /// [primaryColorBrightness]放置在基色顶部的文本和图标的颜色。
      /// [primaryColorLight]primaryColor的较浅版本
      /// [primaryColorDark]primaryColor的较暗版本
      /// [accentColor]强调色也称为辅助色。这是小部件（如旋钮，文本，过度滚动边缘效果等）的前景色。
      /// [accentColorBrightness]它是accentColor的亮度。用于确定放置在强调颜色顶部的文本和图标的颜色（例如，浮动操作按钮上的图标）
      /// [bottomAppBarColor]它是BottomAppBar color的默认颜色。可以通过在BottomAppBar中指定颜色来覆盖它，例如BottomAppBar（color：#color）
      /// [canvasColor]MaterialType.canvas的默认颜色（使用默认主题画布颜色的矩形）
      /// [cardColor]这是用作卡片时材料的颜色，即卡片小部件的默认颜色
      /// [dividerColor]这是在ListTiles之间，DataTables中的行之间等等使用的Dividers和PopMenuDividers的颜色。
      /// [focusColor]这是一种焦点颜色，用于指示组件具有输入焦点
      /// [visualDensity]密度（可选-4到4之间的值，越小表示越密集/更紧凑。此处的值表示。此处的值表示：台式机平台使用紧凑型，其他平台按规范来）
      /// [fontFamily]字体
      /// [textTheme]文本主题
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.transparent,
        canvasColor: Colors.transparent,
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Georgia',
        textTheme: TextTheme(),
      ),

      /// 路由钩子【重点】
      ///
      /// 注意这里使用的是 fluro 插件来构建路由的，以下说明是 flutter 原生路由的一些注意事项。
      /// MaterialApp 的 onGenerateRoute 属性，在打开命名路由时可能会被调用，
      /// 之所以说可能，是因为当调用 Navigator.pushNamed() 打开命名路由时，
      /// 如果指定的路由名在路由表中已注册，则会调用路由表中的 builder 函数来生成路由组件；
      /// 如果路由表中没有注册，才会调用 onGenerateRoute 来生成路由。
      /// 注意1: onGenerateRoute 的使用和注册路由及路由打开方式相关。
      /// 注意2:其他路由钩子，比如: navigatorObservers 和 onUnknownRoute两个回调属性，前者可以监听所有路由跳转动作，后者在打开一个不存在的命名路由时会被调用。
      /// 建议:命名路由只是一种可选的路由管理方式，在实际开发中，建议最好统一使用命名路由的管理方式。
      ///      原因1:语义化更明确。
      ///      原因2:代码更好维护；如果使用匿名路由，则必须在调用 Navigator.push() 的地方创建新路由页，这样不仅需要 import 新路由页的 dart 文件，而且这样的代码将会非常分散。
      ///      原因3:可以通过 onGenerateRoute 做一些全局的路由跳转前置处理逻辑。
      onGenerateRoute: Application.fluroRouter.generator,
    );
  }
}
