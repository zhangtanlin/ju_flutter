# ju_flutter
一个新的 flutter 项目.

## 文档
- [demo](https://flutter.dev/docs/get-started/codelab)
- [flutter 示例](https://flutter.dev/docs/cookbook)
- [在线文档](https://flutter.dev/docs)提供教程，示例，移动开发指南以及完整的 API 参考。
- [很全面的文档](https://github.com/flutterchina/flutter-in-action/blob/master/docs/SUMMARY.md)

## 目录介绍
* pubspec.yaml flutter包管理工具
  > 1. **name**：应用或包名称。
  > 2. **description**：应用或包的描述、简介。
  > 3. **version**：应用或包的版本号。
  > 4. **dependencies**：应用或包依赖的其它包或插件。
  > 5. **dev_dependencies**：开发环境依赖的工具包（而不是 flutter 应用本身依赖的包）。
  > 6. **flutter**：flutter 相关的配置选项。

## 克隆之后需要执行的操作
1. 检查 flutter 是否正确安装，若没正确安装，自己找资料解决<br>
  **flutter doctor**
2. 检查是否有设备已经连接<br>
  **flutter devices**
3. 运行。<br>
  (1)打开 ios 模拟器: **open -a Simulator**<br>
  (2)安装依赖: **flutter packages get**<br>
  (3)启动程序: **flutter run**<br>
  注意：flutter 应用程序只有在调试模式下才能被热重载。如果使用 flutter run 运行应用程序，在终端运行状态下输入 **r** 可以进行热重载。<br>