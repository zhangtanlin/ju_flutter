import 'package:flutter/material.dart';

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
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAdd() {}
  // 头部选项卡
  TabController _tabController; //需要定义一个Controller
  List tabs = ["新闻", "历史", "图片"];

  @override
  void initState() {
    super.initState();
    //头部选项卡 Controller
    _tabController = TabController(length: tabs.length, vsync: this);
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
        title: Text('容器类部件'),
        // 方法一：默认 action 方法
        // actions: <Widget>[ //导航栏右侧菜单
        //   IconButton(icon: Icon(Icons.share), onPressed: () {}),
        // ],
        // 方法二：添加手动打开左测抽屉菜单方法
        leading: Builder(
          builder: (context) {
            return IconButton(
                icon: Icon(
                  Icons.dashboard,
                  color: Colors.white,
                ), // 自定义图标
                onPressed: () {
                  Scaffold.of(context)
                      .openDrawer(); // 注意：这里是通过 Scaffold.of(context) 可以获取父级最近的 Scaffold 部件的 state 对象。
                });
          },
        ),
        // 生成 Tab 菜单
        bottom: TabBar(
            //生成Tab菜单
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList()),
      ),
      drawer: new MyDrawer(), // 抽屉
      bottomNavigationBar: BottomNavigationBar(
        // 底部导航
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), title: Text('Business')),
          BottomNavigationBarItem(
              icon: Icon(Icons.school), title: Text('School')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
          //悬浮按钮
          child: Icon(Icons.add),
          onPressed: _onAdd),
    );
  }
}

// /*
//  * Material 部件库中提供了一个 TabBar部件，它可以快速生成 Tab 菜单。
//  */
// class _ScaffoldRouteState extends State<WidgetScaffold>
//     with SingleTickerProviderStateMixin {
//   TabController _tabController; //需要定义一个Controller
//   List tabs = ["新闻", "历史", "图片"];

//   @override
//   void initState() {
//     super.initState();
//     // 创建Controller
//     _tabController = TabController(length: tabs.length, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//       bottom: TabBar(
//           //生成Tab菜单
//           controller: _tabController,
//           tabs: tabs.map((e) => Tab(text: e)).toList()),
//     ));
//   }
// }

// 抽屉菜单Drawer
class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        "imgs/avatar.png",
                        width: 80,
                      ),
                    ),
                  ),
                  Text(
                    "Wendux",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add account'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Manage accounts'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
