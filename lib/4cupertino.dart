// cupertino ui 部件
import 'package:flutter/cupertino.dart';

class CupertinoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('cupertino 示例'),
      ),
      child: Center(
        child: CupertinoButton(
          color: CupertinoColors.activeGreen,
          child: Text('cupertino 的按钮')
        )
      ),
    );
  }
}
