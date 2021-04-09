import 'package:flutter/material.dart';
import 'package:ju_flutter/http/http_api.dart';
import 'package:ju_flutter/store/testStatus.dart';
import 'package:provider/provider.dart';

class WidgetScaffold extends StatefulWidget {
  @override
  _WidgetScaffoldState createState() => new _WidgetScaffoldState();
}

/*
 * 实现一个页面
 * 1:一个导航栏。
 * 2:导航栏右边一个分享按钮。
 * 3:有一个左侧抽屉菜单。
 * 4:有一个底部菜单。
 * 5:右下角有一个悬浮的动作按钮。
 * 其中：AppBar               是导航栏骨架
 *      MyDrawer             是抽屉菜单
 *      BottomNavigationBar  底部导航栏
 *      FloatingActionButton 漂浮安努
 * 注意：因为 TabController 参数有 vsync: this 所以使用 with SingleTickerProviderStateMixin 的方法才能不报错。
 */
class _WidgetScaffoldState extends State<WidgetScaffold>
    with SingleTickerProviderStateMixin {
  // 选项卡
  int _tabsCheckedIndex = 0; // 选项卡默认选中值
  TabController _tabController; // 需要定义一个Controller
  final List<String> _tabsNameList = ["新闻", "历史", "图片"]; // 选项卡菜单
  List<Widget> tabsHeader = []; // 选项卡头部部件数组

  @override
  void initState() {
    super.initState();
    //头部选项卡
    _tabController = TabController(length: _tabsNameList.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _tabsCheckedIndex = _tabController.index;
      });
    });
  }

  // 选项卡头部列表部件
  List<Widget> setTabsNav(List<String> list) {
    List<Widget> tempList = [];
    for (int i = 0; i < list.length; i++) {
      tempList.add(Tab(
          child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Text(list[i]),
          ),
          i == _tabsCheckedIndex
              ? Positioned(
                  top: 0,
                  right: 0,
                  width: 13,
                  height: 13,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15.0),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(255, 0, 48, 1.0),
                              Color.fromRGBO(255, 255, 255, 1.0),
                            ])),
                  ))
              : Container()
        ],
      )));
    }
    return tempList;
  }

  // 选项卡菜单列表
  Widget setTabsList(String key) {
    return Column(
      children: [
        Text(key),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /**
       * AppBar 是一个 Materical 风格的导航栏，通过它可以设置导航栏标题/导航栏菜单/导航栏底部的Tab标题。
        AppBar({
          Key key,
          this.leading,                          // 导航栏最左侧Widget，常见为抽屉菜单按钮或返回按钮。
          this.automaticallyImplyLeading = true, // 如果leading为null，是否自动实现默认的leading按钮
          this.title,                            // 页面标题
          this.actions,                          // 导航栏右侧菜单
          this.bottom,                           // 导航栏底部菜单，通常为Tab按钮组
          this.elevation = 4.0,                  // 导航栏阴影
          this.centerTitle,                      // 标题是否居中 
          this.backgroundColor,
          ...   //其它属性见源码注释
        })
       * 注意：如果给 Scaffold 添加了抽屉菜单，默认情况下 Scaffold 会自动将 AppBar 的 leading 设置为菜单按钮，
       *    点击它便可以打开抽屉菜单。如果我们想自定义菜单按钮，可以手动来设置 leading。
       */
      appBar: AppBar(
          title: Text('标题'), // 标题名称
          centerTitle: true, // 标题是否居中显示
          // 自定义左侧图标
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context); // 返回上一页
              },
            );
          }),
          actions: <Widget>[HeaderRight()],
          // 生成 Tab 菜单
          bottom: TabBar(
            indicator: const BoxDecoration(), // 清空指示器样式
            controller: _tabController, // 控制器
            tabs: setTabsNav(_tabsNameList), // 自定义的选项卡头部
          )),
      body: TabBarView(
        controller: _tabController,
        children: [setTabsList('第一个'), setTabsList('第二个'), setTabsList('第三个')],
      ),
      // 左侧侧边栏
      drawer: new LeftNav(),
      // 底部导航
      bottomNavigationBar: BottomNav(),
    );
  }
}

// 头像
Widget avatar = Image.asset('name');

// 左侧侧边栏部件
class LeftNav extends StatelessWidget {
  const LeftNav({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Text('${context.watch<TestState>().test.toString()}'),
          RaisedButton(
              child: Text('点击测试跨部件获取公共状态'),
              onPressed: () {
                context.read<TestState>().setTest();
              })
        ],
      ),
    );
  }
}

// 头部右侧
class HeaderRight extends StatelessWidget {
  const HeaderRight({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
          icon: Text('打开侧边栏'),
          onPressed: () {
            Scaffold.of(context).openDrawer(); // 打开侧边栏
          }),
    );
  }
}

// 底部菜单
class BottomNav extends StatefulWidget {
  BottomNav({Key key}) : super(key: key);
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0; // 默认选中值
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '第一',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '第二',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '第三',
          ),
        ],
        selectedItemColor: Colors.black, // 选中的选项颜色
        unselectedItemColor: Colors.black26, // 未选中的选项颜色
        backgroundColor: Colors.grey[300], // 背景色
        type: BottomNavigationBarType.fixed, // 如果超过3个item 要设置背景色，需要设置为 fixed
        currentIndex: _selectedIndex, // 设置选中的序列号
        showUnselectedLabels: true, // 是否显示未选中的 item
        onTap: _bottomNavTap,
      ),
    );
  }

  // 切换底部菜单
  void _bottomNavTap(int index) {
    setState(() {
      _selectedIndex = index; // 设置选中的序列号
    });
  }
}
