import 'package:flutter/material.dart';

/// 登陆界面
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('登陆'),
        ),
        body: Center(child: Text('登陆界面')));
  }
}
