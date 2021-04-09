/*
 * flutter SDK 内置部件介绍
 */
import 'package:flutter/material.dart';
import 'package:ju_flutter/3widget_checkbox.dart';

class WidgetImg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('flutter SDK内置部件库介绍'),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /**
                 * 图片部件参数
                  const Image({
                    ...
                    this.width,                         // 图片的宽
                    this.height,                        // 图片高度
                    this.color,                         // 图片混合的颜色
                    this.colorBlendMode,                // 混合模式
                    this.fit,                           // 缩放模式
                                                           {
                                                             fill：拉伸填充，图片本身长宽比会发生变化，图片会变形，
                                                             cover：会按图片的长宽比放大后剧中填满，图片不会变形，超出部分会被剪裁，
                                                             contain：图片默认规则，保证长宽比不变的情况下以适应当前空间，
                                                             fitWidth：图片会缩放到显示空间的宽度，高度会按比例缩放，然后居中显示，图片不会变形，
                                                             fitHeight：图片会缩放到显示空间的高度，宽度会阿按比例缩放，然后剧中显示，图片不会变形，
                                                             none：图片没有适应策略，会在显示空间内显示图片，如果图片比空间大，则显示空间只会显示图片中间部分
                                                           }

                    this.alignment = Alignment.center,  // 对齐方式
                    this.repeat = ImageRepeat.noRepeat, // 重复方式【当图片小于显示空间时，图片的重复规则】
                                                           {
                                                             ImageRepeat.noRepeat：不重复，
                                                             ImageRepeat.repeatY：y轴重复，
                                                             ImageRepeat.repeatX：x轴重复，
                                                           }
                    ...
                  })
                 * 注意：flutter 框架对加载的图片是有缓存的（内存），默认最大缓存数量是1000，最大缓存空间为100M，未完待续。
                 */
                Row(children: [
                  Image(
                    image: AssetImage('assets/images/bg.jpg'),
                    width: 100.0,
                  ),
                  // Image(
                  //   image: NetworkImage(
                  //       'http://img.netbian.com/file/20110226/7c9cbcb16f0360e67a25e68b47bac1ab.jpg'),
                  //   width: 100.0,
                  // ),
                  // Image.network(
                  //   'https://image.shutterstock.com/image-photo/colors-rainbow-pattern-multicolored-butterflies-260nw-784675318.jpg',
                  //   width: 100.0,
                  // ),
                ]),
                Image(
                  image: AssetImage("assets/images/bg.jpg"),
                  width: 100.0,
                  color: Colors.red,
                  colorBlendMode: BlendMode.difference,
                ),
                /**
                 * icon 图标
                 * 在字体文件中，每一个字符都对应一个码位，而每一个码位对应一个显示字形，不同的字体就是指字形不同，即字符对应的字形是不同的，
                 * 而在iconfont中，只是将码位对应的字形做成了图标，所以不同的字符最终就会渲染成不同的图标。
                 * iconfont和图片相比的优势：
                 *  1:体积小，可以减小安装包大小。
                 *  2:矢量的，放不会影响清晰度。
                 *  3:可以使用应用文本样式，可以想文本一样改变图标颜色/大小/对齐方式等。
                 *  4:可以通过TextSpan和文本混用。
                 * Material Design字体图标，需要在pubspec.yaml配置：
                    flutter:
                      uses-material-design: true
                 * Material Design 所有图标可以在官网查看：
                    https://material.io/tools/icons/
                 */
                Text(
                  "\uE90D", // &#xE90D 或者 0xE90D 或者 E90D
                  style: TextStyle(
                      fontFamily: "MaterialIcons",
                      fontSize: 24.0,
                      color: Colors.amber),
                ),
                Text(
                  "\uE90a", // 自定义的icon代码。格式："\u"+"四位代码（一般都是e开头，大小写可以忽略）"
                  style: TextStyle(
                      fontFamily: "CustomizeIcon", // 自定义的icon字体名称
                      fontSize: 24.0,
                      color: Colors.amber),
                ),
                Icon(IconData(0xe90a,
                    fontFamily: 'CustomizeIcon', matchTextDirection: true)),
                Row(
                  children: [
                    Icon(MyCustomizeIcon.back, color: Colors.red),
                    Icon(MyCustomizeIcon.exit, color: Colors.green),
                    Icon(MyCustomizeIcon.triangleDown, color: Colors.blue),
                    Icon(MyCustomizeIcon.address, color: Colors.orange),
                    Icon(MyCustomizeIcon.check, color: Colors.pink),
                    Icon(MyCustomizeIcon.close, color: Colors.lightBlueAccent),
                    Icon(MyCustomizeIcon.phone, color: Colors.lightGreen),
                    Icon(MyCustomizeIcon.triangleTop, color: Colors.yellow),
                    Icon(MyCustomizeIcon.add, color: Colors.amber[900]),
                    Icon(MyCustomizeIcon.less, color: Colors.cyan),
                    Icon(MyCustomizeIcon.edit, color: Colors.blueAccent),
                    Icon(MyCustomizeIcon.home, color: Colors.green),
                    Icon(MyCustomizeIcon.search, color: Colors.deepOrange),
                    Icon(MyCustomizeIcon.user, color: Colors.teal),
                    Icon(MyCustomizeIcon.menu, color: Colors.blue),
                  ],
                ),
                OutlineButton(
                  child: Text('点击查看单选/复选框及更多的部件'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return WidgetCheckbox(); // 点击查看单选/复选框及更多的部件
                    }));
                  },
                ),
              ]),
        ));
  }
}

// 自定义图标
class MyCustomizeIcon {
  // 返回
  static const IconData back = const IconData(0xe90e,
      fontFamily: 'CustomizeIcon', matchTextDirection: true);
  // 退出
  static const IconData exit = const IconData(0xe90d,
      fontFamily: 'CustomizeIcon', matchTextDirection: true);
  // 倒三角
  static const IconData triangleDown = const IconData(0xe90c,
      fontFamily: 'CustomizeIcon', matchTextDirection: true);
  // 地址
  static const IconData address = const IconData(0xe907,
      fontFamily: 'CustomizeIcon', matchTextDirection: true);
  // 勾选
  static const IconData check = const IconData(0xe908,
      fontFamily: 'CustomizeIcon', matchTextDirection: true);
  // 关闭
  static const IconData close = const IconData(0xe909,
      fontFamily: 'CustomizeIcon', matchTextDirection: true);
  // 电话
  static const IconData phone = const IconData(0xe90a,
      fontFamily: 'CustomizeIcon', matchTextDirection: true);
  // 正三角
  static const IconData triangleTop = const IconData(0xe90b,
      fontFamily: 'CustomizeIcon', matchTextDirection: true);
  // 加
  static const IconData add = const IconData(0xe901,
      fontFamily: 'CustomizeIcon', matchTextDirection: true);
  // 减
  static const IconData less = const IconData(0xe904,
      fontFamily: 'CustomizeIcon', matchTextDirection: true);
  // 编辑
  static const IconData edit = const IconData(0xe902,
      fontFamily: 'CustomizeIcon', matchTextDirection: true);
  // 首页
  static const IconData home = const IconData(0xe903,
      fontFamily: 'CustomizeIcon', matchTextDirection: true);
  // 搜索
  static const IconData search = const IconData(0xe905,
      fontFamily: 'CustomizeIcon', matchTextDirection: true);
  // 用户
  static const IconData user = const IconData(0xe906,
      fontFamily: 'CustomizeIcon', matchTextDirection: true);
  // 菜单
  static const IconData menu = const IconData(0xe900,
      fontFamily: 'CustomizeIcon', matchTextDirection: true);
}
