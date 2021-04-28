import 'package:flutter/material.dart';
import 'package:ju_flutter/utils/util_screen.dart';
import 'package:ju_flutter/utils/util_theme.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class CustomizeTab extends StatefulWidget {
  CustomizeTab({Key key}) : super(key: key);

  @override
  _CustomizeTabState createState() => _CustomizeTabState();
}

class _CustomizeTabState extends State<CustomizeTab>
    with SingleTickerProviderStateMixin {
  /// 定义
  ///
  /// [_tabController] 选项卡控制器，[_tabList] 选项卡标签名。
  TabController _tabController;
  List<String> _tabList = [
    '选项卡一',
    '选项卡二',
    '选项卡三',
    '选项卡四',
    '选项卡五',
    '选项卡六',
    '选项卡七',
    '选项卡八',
    '选项卡九',
    '选项卡十'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabList.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              height: UtilScreen.setWidth(80.0),
              child: TabBar(
                indicator: RectangularIndicator(
                  strokeWidth: 0,
                  topLeftRadius: UtilScreen.setWidth(32),
                  topRightRadius: UtilScreen.setWidth(32),
                  bottomLeftRadius: UtilScreen.setWidth(32),
                  bottomRightRadius: UtilScreen.setWidth(32),
                  color: Colors.grey,
                ),
                isScrollable: true,
                labelColor: Colors.white,
                controller: _tabController,
                unselectedLabelColor: UtilColor.ColorSuccess,
                labelStyle: UtilText.font14White,
                tabs: _tabList.map((item) {
                  return Tab(
                    text: item,
                  );
                }).toList(),
              ),
            ),
            Expanded(
              flex: 1,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Text(_tabList[0]),
                  Text(_tabList[1]),
                  Text(_tabList[2]),
                  Text(_tabList[3]),
                  Text(_tabList[4]),
                  Text(_tabList[5]),
                  Text(_tabList[6]),
                  Text(_tabList[7]),
                  Text(_tabList[8]),
                  Text(_tabList[9]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
