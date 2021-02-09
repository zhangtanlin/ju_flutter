# ju_flutter
一个新的 flutter 项目.

## 文档
- [demo](https://flutter.dev/docs/get-started/codelab)
- [flutter 示例](https://flutter.dev/docs/cookbook)
- [在线文档](https://flutter.dev/docs)提供教程，示例，移动开发指南以及完整的 API 参考。
- [很全面的文档](https://github.com/flutterchina/flutter-in-action/blob/master/docs/SUMMARY.md)

## 目录介绍
* pubspec.yaml flutter包管理工具
  >1. **name**：应用或包名称。
  >2. **description**：应用或包的描述、简介。
  >3. **version**：应用或包的版本号。
  >4. **dependencies**：应用或包依赖的其它包或插件。
  >5. **dev_dependencies**：开发环境依赖的工具包（而不是 flutter 应用本身依赖的包）。
  >6. **flutter**：flutter 相关的配置选项。

## 克隆之后需要执行的操作
1. 检查 flutter 是否正确安装，若没正确安装，自己找资料解决<br>
    ### 使用**flutter doctor**检查 flutter 是否已正确安装
    ### vscode 开发 flutter 的准备工作
      >* 打开 vscode 的插件安装界面，安装 Flutter/Flutter Widget Snippets/Dart 插件。
      >* 使用 cmd+shift+p 打开 vscode 插件命令， 输入 Fluter:Select Device 再选择设备，进行运行。【注意：在 window 上需要把360助手那些关闭】
      >* 默认 vscode 
2. 检查是否有设备已经连接<br>
  **flutter devices**
3. 运行。<br>
  (1).打开 ios 模拟器(或者开启别的模拟器): **open -a Simulator**<br>
  (2).安装依赖: **flutter packages get**<br>
  (3).启动程序: **flutter run**<br>
  注意：flutter 应用程序只有在调试模式下才能被热重载。如果使用 flutter run 运行应用程序，在终端运行状态下输入 **r** 可以进行热重载。<br>

## 编辑代码之后执行的代码检查
1. 代码检查<br>
  flutter analyze<br>

## 代码调试
- [参考文档](https://github.com/flutterchina/flutter-in-action/blob/master/docs/chapter2/flutter_app_debug.md)

## vscode 打开开发者工具并且连接目标app
1. 打开 vscode 命令行工具 com+shift+p 。
2. 输入 >Dart: Open DevTools 运行 （注意：运行成功之后应该会在浏览器打开一个 http://127.0.0.1:9100 的页面，即开发者页面）<br>
    >* 当第一次运行时（以及未来更新开发工具包时），系统会提醒你激活或升级开发工具，所以不用担心更新问题。
    >* 当开发工具激活后，可以在 VS Code 的状态栏中看到它们。如果关闭浏览器选项卡，只要还有可用的 Dart/Flutter 调试程序，可以通过单击vscode底部状态栏（Dart DevTools）来重新启动浏览器。
3. 启动一个 flutter 程序 flutter run （注意：运行成功之后会在命令行中生成一个运行地址，例如: http://127.0.0.1:49556/tbwvZ53MJLc=/）
4. 在浏览器打开的开发者页面中输入 flutter 启动程序的运行地址。
