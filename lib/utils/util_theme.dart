import 'package:flutter/material.dart';
import 'package:ju_flutter/utils/util_screen.dart';

/// 字号
class UtilFontsize {
  static get size30 => UtilScreen.setFontSize(30); // 默认
}

/// 颜色
class UtilColor {
  static const Color ColorBase = Color(0xFF0B2D64); // 基础色
  static const Color ColorTitle = Color(0xFF1E1E1E); // 文本标题色
  static const Color ColorText = Color(0xFF1E1E1E); // 文本内容色
  static const Color ColorDanger = Color(0xFFFF4B00); // 危险
  static const Color ColorWarning = Color(0xFFF6AA00); // 警告
  static const Color ColorInfo = Color(0xFFF2E700); // 注意
  static const Color ColorSuccess = Color(0xFF00B06B); // 成功
}

/// 文字
///
/// 注意：字号是被*2的，需要注意
class UtilText {
  static TextStyle font14White = TextStyle(
    color: Color.fromRGBO(255, 255, 255, 1),
    fontSize: UtilScreen.setFontSize(28.0),
    decoration: TextDecoration.none,
  );
}
