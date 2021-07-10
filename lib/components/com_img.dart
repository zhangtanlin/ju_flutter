import 'package:flutter/material.dart';

/// 图片模块
class ComImg extends StatefulWidget {
  /// 参数
  /// [url]图片地址
  /// [width]图片宽度
  /// [height]图片高度
  /// [fit]图片填充方式
  /// [filterQuality]图片质量
  /// [bg]背景图
  /// [bgColor]背景色
  /// [callback]点击图片回调函数
  final String url;
  final double width;
  final String height;
  final BoxFit fit;
  final FilterQuality filterQuality;
  final String bg;
  final String bgColor;
  final Function callback;
  ComImg({
    Key key,
    this.url,
    this.width,
    this.height,
    this.fit,
    this.filterQuality,
    this.bg,
    this.bgColor,
    this.callback,
  }) : super(key: key);

  @override
  _ComImgState createState() => _ComImgState();
}

class _ComImgState extends State<ComImg> {
  /// 定义

  /// 背景图

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}
