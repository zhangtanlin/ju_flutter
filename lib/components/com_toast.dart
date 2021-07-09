import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ju_flutter/utils/util_screen.dart';
import 'package:ju_flutter/utils/util_theme.dart';

/// 轻提示
class ComToast {
  /// 成功提示
  ///
  /// [text]提示文字,[toastLength]轻提示长度,[gravity]显示位置,[timeInSecForIos]多少秒之后隐藏。
  static success(
    String text, {
    Toast toastLength = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.TOP,
    int timeInSecForIos = 2,
  }) {
    return Fluttertoast.showToast(
      msg: text ?? '成功',
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIos,
      backgroundColor: UtilColor.ColorSuccess,
      textColor: Color(0xff67c23a),
      fontSize: UtilScreen.setFontSize(32),
    );
  }

  /// 失败提示
  ///
  /// [text]提示文字,[toastLength]轻提示长度,[gravity]显示位置,[timeInSecForIos]多少秒之后隐藏。
  static error(
    String text, {
    Toast toastLength = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.TOP,
    int timeInSecForIos = 2,
  }) {
    return Fluttertoast.showToast(
      msg: text ?? '失败',
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIos,
      backgroundColor: UtilColor.ColorDanger,
      textColor: Color(0xff67c23a),
      fontSize: UtilScreen.setFontSize(32),
    );
  }

  /// 消息提示
  ///
  /// [text]提示文字,[toastLength]轻提示长度,[gravity]显示位置,[timeInSecForIos]多少秒之后隐藏。
  static info(
    String text, {
    Toast toastLength = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.TOP,
    int timeInSecForIos = 2,
  }) {
    return Fluttertoast.showToast(
      msg: text ?? '警告',
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIos,
      backgroundColor: UtilColor.ColorWarning,
      textColor: Color(0xff67c23a),
      fontSize: UtilScreen.setFontSize(32),
    );
  }
}
