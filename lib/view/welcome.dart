import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:ju_flutter/route/application.dart';
import 'package:ju_flutter/route/route_list.dart';
import 'package:ju_flutter/utils/util_check_line.dart';
import 'package:ju_flutter/utils/util_screen.dart';
import 'package:ju_flutter/utils/util_theme.dart';

/// 欢迎界面（有状态）
@immutable
class Welcome extends StatefulWidget {
  Welcome({Key key}) : super(key: key);
  @override
  State createState() => _WelcomeState();
}

/// Welcome类对应的状态类
class _WelcomeState extends State<Welcome> {
  /// 定义
  /// [isCheckLine]路线是否检测完毕
  /// [_bannerList] 轮播列表
  bool isCheckLine;
  List<Map<String, String>> _bannerList = [
    {
      "url": "assets/images/welcome/banner1.jpeg",
      "header": "assets/images/welcome/header1.jpeg",
    },
    {
      "url": "assets/images/welcome/banner2.jpeg",
      "header": "assets/images/welcome/header2.jpeg",
    },
    {
      "url": "assets/images/welcome/banner3.jpeg",
      "header": "assets/images/welcome/header3.jpeg",
    },
  ];

  /// 部件初始化时
  /// [detectionLine]检测路线接口调用
  void initState() {
    super.initState();
    detectionLine();
  }

  /// 检测线路
  /// [isCheckLine]是否检测线路中
  /// [UtilCheckLine.checkLine()]选择路线方法
  /// [Application.fluroRouter.navigateTo()]路由跳转方法
  /// [RouteList.home]首页路由
  detectionLine() {
    setState(() {
      isCheckLine = true;
    });
    UtilCheckLine.checkLine(onIpError: () {
      print('ip错误');
    }, onSuccess: (data) {
      setState(() {
        isCheckLine = false;
      });
    }, onFailed: (e) {
      print('错误$e');
    });
  }

  /// 构建
  @override
  Widget build(BuildContext context) {
    /// [initScreen]初始化设备信息（屏幕/宽高等公共方法）
    /// 注意：[initScreen]初始化需要在[webcome]部件的[build()]方法内初始化，不能在[main]内初始化。
    UtilScreen.initScreen(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        /// 滚动部件 flutter_swiper
        /// 参考文档：[https://github.com/best-flutter/flutter_swiper]
        /// [itemBuilder]构建方法
        Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(_bannerList[index]['url']),
                        alignment: Alignment.center,
                        fit: BoxFit.cover)),
                child: Container(
                    padding: EdgeInsets.only(top: UtilScreen.setWidth(300.0)),
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: UtilScreen.setWidth(275.0),
                      height: UtilScreen.setWidth(275.0),
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.all(UtilScreen.setWidth(10.0)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(275.0),
                          color: Colors.amber[900]),
                      child: ClipOval(
                        child: Image.asset(
                          _bannerList[index]['header'],
                          width: UtilScreen.setWidth(250.0),
                          height: UtilScreen.setWidth(250.0),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    )));
          },
          autoplay: false,
          loop: false,
          itemCount: _bannerList.length,
          pagination: SwiperCustomPagination(
              builder: (BuildContext context, SwiperPluginConfig config) {
            /// 自定义指示器
            /// [list]指示器部件列表，[itemCount]指示器个数，[activeIndex]当前选中的指示器的序列号。
            List<Widget> list = [];
            int itemCount = config.itemCount;
            int activeIndex = config.activeIndex;
            for (int i = 0; i < itemCount; ++i) {
              bool active = i == activeIndex;
              list.add(
                Container(
                    key: Key("pagination_$i"), // 设置唯一的 key
                    margin: EdgeInsets.all(UtilScreen.setWidth(3.0)),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Color(0xFFBE9D8C)),
                        color: active
                            ? Colors.white
                            : Color.fromRGBO(255, 255, 255, 0.5),
                        borderRadius: active
                            ? BorderRadius.circular(UtilScreen.setWidth(10.0))
                            : BorderRadius.circular(UtilScreen.setWidth(10.0))),
                    width: active ? 50.0 : 20.0,
                    height: UtilScreen.setWidth(20.0)),
              );
            }
            return Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: UtilScreen.setWidth(50.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: list,
              ),
            );
          }),
        ),

        /// 底部操作行
        /// [isCheckLine]线路是否检测中
        Positioned(
          width: UtilScreen.screenWidth,
          left: 0,
          bottom: UtilScreen.setWidth(150.0),
          child: isCheckLine
              ? Text('线路检测中...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: UtilFontsize.size30,
                      decoration: TextDecoration.none,
                      color: UtilColor.ColorWarning))
              : Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text('检测路线',
                                style: TextStyle(
                                  color: UtilColor.ColorWarning,
                                  fontSize: UtilScreen.setWidth(27.5),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          onTap: detectionLine,
                        )),
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(UtilScreen.setWidth(20.0)),
                            child: Text('进入首页',
                                style: TextStyle(
                                  color: UtilColor.ColorWarning,
                                  fontSize: UtilScreen.setWidth(27.5),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          onTap: () {
                            Application.fluroRouter.navigateTo(context, 'home');
                          },
                        ))
                  ],
                ),
        )
      ],
    );
  }
}
