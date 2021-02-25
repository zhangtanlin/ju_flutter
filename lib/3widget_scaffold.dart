import 'package:flutter/material.dart';

class WidgetScaffold extends StatefulWidget {
  @override
  _WidgetScaffoldState createState() => new _WidgetScaffoldState();
}

class _WidgetScaffoldState extends State<WidgetScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('容器类部件'),
        ),
        body: ListView(
          children: <Widget>[
            /**
             * Material 部件库提供丰富多样的部件，
             */
            OutlineButton(
              child: Text('点击查看对齐与相对定位及更多的部件',
                  style: TextStyle(
                    color: Colors.red,
                  )),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return WidgetScaffold();
                }));
              },
            ),
          ],
        ));
  }
}
