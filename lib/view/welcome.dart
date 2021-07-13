import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:ju_flutter/components/com_img.dart';
import 'package:ju_flutter/components/com_toast.dart';
import 'package:ju_flutter/http/http_dio.dart';
import 'package:ju_flutter/model/config.dart';
import 'package:ju_flutter/route/application.dart';
import 'package:ju_flutter/utils/util_check_line.dart';
import 'package:ju_flutter/utils/util_device.dart';
import 'package:ju_flutter/utils/util_encrypt.dart';
import 'package:ju_flutter/utils/util_img_cache.dart';
import 'package:ju_flutter/utils/util_package.dart';
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
  /// [_isCheckLine]路线是否检测中
  /// [_inited]是否已经初始化
  /// [_bannerList] 轮播列表
  bool _isCheckLine = true;
  bool _inited = false;
  List<Map<String, String>> _bannerList = [
    {
      "url": "assets/images/welcome/banner1.jpg",
      "header": "assets/images/header/1.jpg",
    },
    {
      "url": "assets/images/welcome/banner2.jpg",
      "header": "assets/images/header/2.jpg",
    },
    {
      "url": "assets/images/welcome/banner3.jpg",
      "header": "assets/images/header/3.jpg",
    },
  ];

  /// [_currentTime]倒计时时间（倒计时时间 >= 0 时显示广告和倒计时封面）
  /// [_timer]倒计时事件
  /// [_adThumb]广告图
  /// [_adLink]广告图链接地址
  int _currentTime = 10;
  Timer _timer;
  String _adThumb = '';
  String _adLink = '';

  /// 部件初始化时
  /// [countdown]倒计时
  /// [UtilDevice()]设备信息初始化
  /// [UtilPackage()]版本信息初始化
  /// [_httpDio]初始化 httpdio
  /// [_httpDio.initBaseOptions()]初始化 _httpdio 的参数
  /// [detectionLine]检测路线接口调用
  void initState() {
    super.initState();
    countdown();
    UtilDevice();
    UtilPackage();
    final _httpDio = HttpDio();
    _httpDio.initBaseOptions(host: ''); // 初始化 httpdio
    detectionLine();
  }

  /// 初始化
  /// [UtilImageCache.initCacheImg()]初始化图片缓存目录
  Future<void> init() async {
    try {
      await UtilImageCache.initCacheImg();
    } catch (e) {}
  }

  /// 检测线路
  /// [isCheckLine]是否检测线路中
  /// [UtilCheckLine.checkLine()]选择路线方法
  detectionLine() {
    setState(() {
      _isCheckLine = true;
    });
    UtilCheckLine.checkLine(onIpError: () {
      ComToast.error('ip错误');
    }, onSuccess: (ModelConfig _modelConfig) async {
      await updateConifg(_modelConfig);
      setState(() {
        _isCheckLine = false;
      });
    }, onFailed: (e) {
      ComToast.error(e);
    });
  }

  /// 广告
  Widget ad() {
    return Container(
      child: Stack(
        children: [
          GestureDetector(
            child: Container(
              width: UtilScreen.screenWidth,
              height: UtilScreen.screenHeight,
              // child: Image.asset('assets/images/common/open-ad.jpg'),
              child: _adThumb == ''
                  ? Container()
                  : ComImg(
                      bg: _adThumb,
                      link: _adLink,
                    ),
            ),
            onTap: () => {_adLink == '' ? null : print('1111111')},
          ),
          Positioned(
            width: UtilScreen.setWidth(50.0),
            height: UtilScreen.setWidth(50.0),
            top: UtilScreen.setWidth(20.0),
            right: UtilScreen.setWidth(20.0),
            child: Container(
              width: UtilScreen.setWidth(20.0),
              height: UtilScreen.setWidth(20.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                borderRadius: BorderRadius.circular(UtilScreen.setWidth(25.0)),
              ),
              child: Text(
                _currentTime.toString(),
                style: UtilText.font14White,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 广告-倒计时
  countdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_currentTime <= 0) {
        setState(() {
          _timer.cancel();
        });
        return;
      }
      setState(() {
        _currentTime--;
      });
    });
  }

  /// 更新整合接口
  updateConifg(ModelConfig _modelConfig) {
    if (_modelConfig == null) {
      ComToast.error('获取用户信息失败～');
      return;
    }
    if (_modelConfig.status == 200) {
      setState(() {
        _adThumb = _modelConfig.data.ads[0].src;
        _adLink = _modelConfig.data.ads[0].link;
      });
    } else {
      ComToast.error('获取用户信息失败2～');
    }
  }

  /// 构建
  /// [Application.fluroRouter.navigateTo()]路由跳转方法
  @override
  Widget build(BuildContext context) {
    /// 如果未初始化（初始化一些公共方法）
    ///
    /// [UtilScreen.initScreen(context)]初始化设备信息（屏幕/宽高等公共方法）
    /// 注意：[initScreen]初始化需要在[webcome]部件的[build()]方法内初始化，不能在[main]内初始化。
    if (!_inited) {
      _inited = true;
      UtilScreen.initScreen(context);
    }

    return SafeArea(
      child: _currentTime > 0
          ? ad()
          : Stack(
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
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(),
                    );
                  },
                  autoplay: false,
                  loop: false,
                  itemCount: _bannerList.length,
                  pagination: SwiperCustomPagination(builder: (
                    BuildContext context,
                    SwiperPluginConfig config,
                  ) {
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
                            border:
                                Border.all(width: 1, color: Color(0xFFBE9D8C)),
                            color: active
                                ? Colors.white
                                : Color.fromRGBO(255, 255, 255, 0.5),
                            borderRadius: active
                                ? BorderRadius.circular(
                                    UtilScreen.setWidth(10.0),
                                  )
                                : BorderRadius.circular(
                                    UtilScreen.setWidth(10.0)),
                          ),
                          width: active ? 50.0 : 20.0,
                          height: UtilScreen.setWidth(20.0),
                        ),
                      );
                    }
                    return Container(
                      alignment: Alignment.bottomCenter,
                      padding:
                          EdgeInsets.only(bottom: UtilScreen.setWidth(50.0)),
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
                  child: _isCheckLine
                      ? Text(
                          '线路检测中...',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: UtilFontsize.size30,
                            decoration: TextDecoration.none,
                            color: UtilColor.ColorWarning,
                          ),
                        )
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
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding:
                                      EdgeInsets.all(UtilScreen.setWidth(20.0)),
                                  child: Text(
                                    '进入首页',
                                    style: TextStyle(
                                      color: UtilColor.ColorWarning,
                                      fontSize: UtilScreen.setWidth(27.5),
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Application.fluroRouter
                                      .navigateTo(context, 'home');
                                },
                              ),
                            )
                          ],
                        ),
                )
              ],
            ),
    );
  }
}
