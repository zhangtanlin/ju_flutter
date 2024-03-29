# ju_flutter
一个新的 Flutter 项目.

## 文档
- [demo](https://flutter.dev/docs/get-started/codelab)
- [Flutter 示例](https://flutter.dev/docs/cookbook)
- [在线文档](https://flutter.dev/docs)提供教程，示例，移动开发指南以及完整的 API 参考。
- [很全面的文档](https://github.com/flutterchina/flutter-in-action/blob/master/docs/SUMMARY.md)
- [flutter代码解惑文档](https://juejin.cn/post/7157297867236278308)
- [计算机基础-学习路径](https://zhuanlan.zhihu.com/p/405628414)
- [flutter单例学习](https://codeantenna.com/a/Yjpf18RZqV)

## 目录介绍
* pubspec.yaml Flutter包管理工具
    >1. **name**：应用或包名称。
    >2. **description**：应用或包的描述、简介。
    >3. **version**：应用或包的版本号。
    >4. **dependencies**：应用或包依赖的其它包或插件。
    >5. **dev_dependencies**：开发环境依赖的工具包（而不是 Flutter 应用本身依赖的包）。
    >6. **flutter**：Flutter 相关的配置选项。

## Flutter 相关操作
1. sdk降级、回退、升级降级到指定的版本方法:
    >* 到 Flutter sdk 所在的目录下(自己找 Flutter 的安装目录到 Flutter 文件夹里面那一层即可)执行 ：
    >* git reset --hard fabeb2a16f1d008ab8230f450c49141d35669798
    >* fabeb2a16f1d008ab8230f450c49141d35669798 字符串是commit版本号如下，可以到 Flutter Git源码里面去找https://github.com/flutter/flutter（Releas--tags--找到具体的版本号，点击--fabeb2a即可看到commit号）
2. 添加新的依赖
    >* 命令行输入 **flutter pub add** 来添加新的依赖。

## 克隆之后需要执行的操作
1. 检查 Flutter 是否正确安装，若没正确安装，自己找资料解决
    ### 使用**flutter doctor**检查 Flutter 是否已正确安装
    ### VSCode 开发 Flutter 的准备工作
    >* 打开 VSCode 的插件安装界面，安装 Flutter/Flutter Widget Snippets/Dart 插件。
    >* 使用 cmd+shift+p 打开 VSCode 插件命令， 输入 Fluter:Select Device 再选择设备，进行运行。【注意：在 window 上需要把360助手那些关闭】
    >* 默认 VSCode 
2. 检查是否有设备已经连接
  **flutter devices**
3. 运行。<br>
    >(1).打开 ios 模拟器(或者开启别的模拟器): **open -a Simulator**<br/>
    >(2).安装依赖: **flutter packages get**<br/>
    >(3).启动程序: **flutter run**<br/>
    >注意1： Flutter 应用程序只有在调试模式下才能被热重载。<br/>
    >注意2：如果使用  **flutter run** 运行应用程序，在终端运行状态下输入 **r** 可以进行热重载。<br/>
    >注意3：如果使用  **flutter run** 运行应用程序，在终端运行状态下输入 **p** 可以打开布局线条，再次按 **p** 取消显示布局线条。
4. 使用 fvm 运行,如果安装了 fvm 可以在上面的 flutter 代码运行命令前面添加 fvm 同样可以运行,例如:
```bash
  # 安装依赖
  fvm flutter packages get
  # 运行
  fvm flutter run
```

## 编辑代码之后执行的代码检查
1. 代码检查: **flutter analyze**

## 代码调试
- [参考文档](https://github.com/flutterchina/flutter-in-action/blob/master/docs/chapter2/flutter_app_debug.md)

## VSCode打开开发者工具并且连接目标app
1. 打开 VSCode 命令行工具 **com+shift+p**。
2. 输入 **>Dart: Open DevTools** 运行.<br/>
  注意：运行成功之后会在浏览器打开 http://127.0.0.1:9100 的页面，即开发者工具页面(Dart DevTools).
    >* 当第一次运行时（以及未来更新开发工具包时），系统会提醒你激活或升级开发工具，所以不用担心更新问题。
    >* 当开发工具激活后，可以在 VSCode 的状态栏中看到它们。如果关闭浏览器选项卡，只要还有可用的 Dart/Flutter 调试程序，可以通过单击 VSCode 底部状态栏（Dart DevTools）来重新启动浏览器。
3. 启动一个 Flutter 程序 **flutter run** （注意：运行成功之后会在命令行中生成一个运行地址，例如: http://127.0.0.1:49556/tbwvZ53MJLc=/）
4. 在浏览器打开的开发者页面中输入 Flutter 启动程序的运行地址。

## Xcode 打开开发者工具并且连接目标app
1. 打开 Xcode 编辑器。
2. 导入 Flutter 项目。
3. 使用 Xcode 调试项目，并在各个水果设备上验证。

## 安卓升级安装问题
修改android目录的build.gradle中applicationId需要同时修改updateModel.dart文件299行中的applicationId

## pull_to_refresh_notification.dart
改造_show方法
1. 当拉动距离小于触发刷新的情况下，直接回弹不刷新
<pre>
if(_dragOffset < widget.maxDragOffset) {
  _dismiss(RefreshIndicatorMode.canceled);
  return;
} 
</pre>
2. 使用Future.delayed(const Duration(milliseconds: 2000), () { ... } 包裹回弹代码，让下拉回弹停顿一会儿发生，时间可自己设置

## 公共库路径
/Users/mac/development/flutter/.pub-cache/hosted/pub.dartlang.org/

flutter build apk --target-platform  android-arm --split-per-abi

## 线上疑难杂症
1.启动广告会影响进入APP

## 选择线路需要执行的操作：
1:设置超时事件

2-1:初始化 dio 模块
2-2:初始化设备信息

3-1:初始化 shared_preferences
3-2:定义 shared_preferences 存储的配置线路地址

4-1:定义错误线路数组 errorLines = []；
4-2:定义错误线路个数 errorCount = 0；

5-1:定义选择路线方法 doCheck；
5-2:定义探测备用线路的方法 checkBackUpLine；
5-2-1: 请求 github 备用地址。使用 Uri.parse('http://github.com/****')方法解析备用地址。

## 代码优化
1.三元运算符的替换。
三元运算符往往不能够对齐,影响代码美观度,建议使用一个函数进行条件判定.

