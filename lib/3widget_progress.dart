/*
 * flutter SDK 内置部件介绍
 */
import 'package:flutter/material.dart';
import 'package:ju_flutter/3widget_progress_animate.dart';

class WidgetProgress extends StatefulWidget {
  @override
  _WidgetProgressState createState() => new _WidgetProgressState();
}

class _WidgetProgressState extends State<WidgetProgress> {
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
               * 进度指示器
               * Material 组建提供了两种进度指示器 LinearProgressIndicctor 和 CircularProgressIndicator, 
               * 他们都可以同时用于精确的进度指示和模糊的进度指示。
               * 精确进度通常用于任务进度可以计算和预估的情况，比如文件下载；
               * 模糊进度通常用于人物进度无法准确获得的情况，常用语下拉刷新和数据提交等。
               * LinearProgressIndicator 线性/条状进度条用法：
                LinearProgressIndicator({
                  double value,                // 表示当前进度，取值范围为[0,1],如果 value 为 null 时，指示器会执行一个循环动画（模糊进度）
                                                  当 value 不为 null 时，指示器为一个具体进度的进度条。
                  Color backgroundColor,       // 指示器的背景色
                  Animation<Color> valueColor, // 指示器的进度条颜色，值得注意的是，该值类型是 Animation<Color>，这允许我们对进度条的颜指定动画。
                                                  如果我们不需要对进度条颜色执行动画，换言之，我们想对进度条应用一种固定颜色，此时我们可以通过
                                                  AlwaysStoppedAnimation来指定。
                  ...
                })
                */
              LinearProgressIndicator(
                backgroundColor: Colors.amber[900],
                valueColor: AlwaysStoppedAnimation(Colors.blue[900]),
              ),
              LinearProgressIndicator(
                backgroundColor: Colors.cyanAccent,
                valueColor: AlwaysStoppedAnimation(Colors.black),
                value: .6,
              ),
              /**
               * CircularProgressIndicator 圆形进度条，用法
                CircularProgressIndicator({
                  double value,
                  Color backgroundColor,
                  Animation<Color> valueColor,
                  this.strokeWidth = 4.0, // 表示圆形进度条的粗细。
                  ...   
                }) 
                */
              CircularProgressIndicator(
                backgroundColor: Colors.yellowAccent[900],
                valueColor: AlwaysStoppedAnimation(Colors.blue),
                strokeWidth: 6.0,
              ),
              CircularProgressIndicator(
                backgroundColor: Colors.amber,
                valueColor: AlwaysStoppedAnimation(Colors.red),
                value: .4,
                strokeWidth: 3.0,
              ),
              /**
               * LinearProgressIndicator 和 CircularProgressIndicator 都没有设置尺寸大小的参数。
               * 其实进度指示器都是取父容器的尺寸作为绘制的边界的。我没可以通过尺寸限制类 widget，如： ConstrainedBox，SizeBox 来指定尺寸。
               * 主意： 圆形进度条如果显示空间的宽度和高度不一致时，则会显示为椭圆。
               */
              SizedBox(
                height: 10,
                child: LinearProgressIndicator(
                    backgroundColor: Colors.blueAccent,
                    valueColor: AlwaysStoppedAnimation(Colors.cyanAccent),
                    value: .5),
              ),
              SizedBox(
                height: 200,
                width: 200,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blueAccent,
                  valueColor: AlwaysStoppedAnimation(Colors.cyanAccent),
                  value: .5,
                  strokeWidth: 5,
                ),
              ),
              OutlineButton(
                child: Text('点击查看进度指示器-进度色动画及更多的部件'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return WidgetProgressAimate(); // 点击查看进度指示器-进度色动画及更多的部件
                  }));
                },
              ),
            ])));
  }
}
