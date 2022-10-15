import 'package:flutter/material.dart';
import 'package:ju_flutter/config/network.dart';
import 'package:ju_flutter/utils/util_crypto.dart';

/// 上拉下拉刷新列表
class ComPullRefresh extends StatefulWidget {
  /// [url]图片地址
  /// [width]图片宽度
  /// [height]图片高度
  /// [fit]图片填充方式
  /// [filterQuality]图片质量
  /// [bg]背景图
  /// [link]链接
  /// [bgColor]背景色
  /// [callback]点击图片回调函数
  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final FilterQuality filterQuality;
  final String bg;
  final String link;
  final String bgColor;
  final Function callback;
  ComPullRefresh({
    Key key,
    this.url,
    this.width,
    this.height,
    this.fit,
    this.filterQuality,
    this.bg,
    this.link,
    this.bgColor,
    this.callback,
  }) : super(key: key);

  @override
  _ComPullRefreshState createState() => _ComPullRefreshState();
}

class _ComPullRefreshState extends State<ComPullRefresh> {
  /// 定义
  /// [_imageUrl]图片背景图
  String _imageUrl = '';

  @override
  void initState() {
    super.initState();
    decryptImg();
  }

  /// 解密背景图
  decryptImg() {
    if (widget.bg.isNotEmpty) {
      String content = UtilCrypto.decodeBase64(widget.bg);
      _imageUrl = content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity, // double.infinity 和父元素一样大
      height: widget.height ?? double.infinity,
      decoration: BoxDecoration(
        color: widget.bgColor ?? Colors.black38,
        image: DecorationImage(
          image: AssetImage('assets/images/common/logo.png'),
          fit: BoxFit.scaleDown,
        ),
      ),
      child:
          _imageUrl == '' ? null : Image.network(Network.imageHost + _imageUrl),
    );
  }
}
