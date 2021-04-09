import 'package:flutter/material.dart';

/// 设备屏幕相关
class UtilScreen {

  /// 定义
  /// 
  /// [_designWidth]      设计图-宽度
  /// [_designHeight]     设计图-高度
  /// [_designPixelsRatio]设计图-像素比率（未缩放状态下，一个设计图像素等于多少设备像素）
  /// [_mediaQueryData]   设备
  /// [_screenWidth]      设备-屏幕宽度
  /// [_screenHeight]     设备-屏幕高度
  /// [_screenPixelRatio] 设备-像素比率（未缩放状态下，一个像素等于多少设备像）【一般从设备信息获取】
  static double _designWidth;
  static double _designHeight;
  static double _designPixelsRatio;
  static MediaQueryData _mediaQueryData;
  static double _screenWidth;
  static double _screenHeight;
  static double _screenPixelRatio;

  /// 初始化屏幕信息【默认信息根据 iphone7 尺寸设计】
  /// 
  /// [context]         应用程序上下文
  /// [designWidth]     默认设计图宽度
  /// [designHeight]    默认设计图高度
  /// [designPixelsRatio]默认像素比率
  static void initScreen(
    BuildContext context, {
    double designWidth = 750.0,
    double designHeight = 1334.0,
    double designPixelsRatio = 2.0,
  }) {
    _designWidth = designWidth / designPixelsRatio;
    _designHeight = designHeight / designPixelsRatio;
    _designPixelsRatio = designPixelsRatio;
    MediaQueryData mediaQueryData = MediaQuery.of(context); // 获取当前设备的信息
    _mediaQueryData = mediaQueryData;
    _screenWidth = mediaQueryData.size.width;
    _screenHeight = mediaQueryData.size.height;
    _screenPixelRatio = mediaQueryData.devicePixelRatio;
  }

  /// 设备屏幕宽度
  static get screenWidth => _screenWidth;

  /// 设备屏幕高度
  static get screenHeight => _screenHeight;

  /// 设备屏幕像素密度
  static get screenPixelRatioRatio => _screenPixelRatio;

  /// 设备宽度和设计图宽度比例（因为适配设备，设备的宽度不一致所以获取的比例不一致）
  static get scaleFactorWidth => (_screenWidth / _designWidth);

  /// 设备高度和设计图高度比例（因为适配设备，设备的高度不一致所以获取的比例不一致）
  static get scaleFactorHeight => (_screenHeight / _designHeight);

  /// 宽度适配：以传入的宽度为原型，适配机型(给定的宽度*屏幕和设计图比例/设计图像素比率)
  static num setWidth(num width) =>
      width * scaleFactorWidth / _designPixelsRatio;

  /// 高度适配：以传入的高度为原型，适配机型(给定的高度*屏幕和设计图比例/设计图像素比率)
  static num setHeight(num height) =>
      height * scaleFactorHeight / _designPixelsRatio;

  /// 字号适配：以参数为基准，适配机型（给定字号*屏幕和设计图比例/设计图像素比率）
  static num setFontSize(num fontsize) =>
      fontsize * scaleFactorWidth / _designPixelsRatio;
}
