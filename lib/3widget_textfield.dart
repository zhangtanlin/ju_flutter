/*
 * flutter SDK 内置部件介绍
 */
import 'package:flutter/material.dart';
import 'package:ju_flutter/3widget_form.dart';

class WidgetTextField extends StatefulWidget {
  @override
  _WidgetTextFieldState createState() => new _WidgetTextFieldState();
}

class _WidgetTextFieldState extends State<WidgetTextField> {
  // 定义 controller 方法:获取 TextField 密码输入的值(改变的值)
  final TextEditingController _myControllerPwd = TextEditingController();
  /*
   * 年龄的 Textfield 是否获得焦点
   * FocusNode 管理焦点，代表焦点控制范围；FocusNode 继承自 ChangeNotifier,通过 FocusNode 可以监听焦点的改变事件。
   * 通过 focusScopeNode 在输入框之间移动焦点，设置默认焦点。
   * 可以通过 FocusScope.of(context) 来获取 Widget 树中默认 FocusScopeNode。
   */
  final ageGetFocus = new FocusNode(); // 创建 focusNode
  FocusScopeNode focusScopeNode;

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
             * 输入框
              const TextField({
                ...
                TextEditingController    controller                           // 编辑框的控制器，通过它可以设置/获取编辑框的内容/选择编辑内容/编辑监听文本改变事件，
                                                                                  大多数情况下，我们都需要显示提供一个 controller 来与文本框交互，
                                                                                  如果没有提供 controller ，则 TextField 内部会自动创建一个。
                FocusNode                focusNode                            // 用于控制 TextField 是否占有当前键盘的输入焦点，它是我们和键盘交互的一个句柄(handle)
                InputDecoration          decoration = const InputDecoration() // 
                TextInputType            keyboardType                         // 用于设置该输入框默认的键盘输入类型，取值如下：
                                                                                  multiline  	多行文本，需和maxLines配合使用(设为null或大于1)
                                                                                  number	      数字；会弹出数字键盘
                                                                                  phone	      优化后的电话号码输入键盘；会弹出数字键盘并显示“* #”
                                                                                  datetime  	  优化后的日期输入键盘；Android上会显示“: -”
                                                                                  emailAddress	优化后的电子邮件地址；会显示“@ .”
                                                                                  url	        优化后的url输入键盘； 会显示“/ .”
                TextInputAction          textInputAction                      // 键盘动作按钮图标(即回车位图标)，它是一个枚举值，有多个可选值，
                                                                                  全部的取值列表，可查询文档。
                TextStyle                style                                // 正在编辑的文本的样式
                TextAlign                textAlign = TextAlign.start          // 编辑文本在水平方向上的对齐方式
                bool                     autofocus = false                    // 是否自动获取焦点
                bool                     obscureText = false                  // 是否隐藏正在编辑的文本，如用于输入密码等，文本内容会用·点替换
                int                      maxLines = 1                         // 输入框的最大行数，默认是1，如果为null，则无行数限制
                int                      maxLength                            // 表示输入框文本的最大长度，设置后输入框右下角会显示输入的文本计数
                bool                     maxLengthEnforced = true             // 决定当输入文本长度超过 maxLength 时是否阻止输入，为true时会阻止输入，
                                                                                  为false时不会阻止输入但输入框会变红
                ValueChanged<String>     onChanged                            // 输入框内容改变时的回调，内容改变事件也可以通过 controller 来监听
                VoidCallback             onEditingComplete                    // 输入完成时触发，比如按了键盘的完成键或者搜索键。该回调不接收参数
                ValueChanged<String>     onSubmitted                          // 输入完成时触发，比如按了键盘的完成键或者搜索键。该回调接收指定类型参数
                List<TextInputFormatter> inputFormatters                      // 用于指定输入格式，当用户输入内容改变时，会根据指定格式来校验
                bool                     enabled                              // 如果为 false 则输入框会被禁用，禁用状态下不接收输入和事件，同时显示禁用样式(在 decoration中定义)
                this.cursorWidth =       2.0                                  // 光标宽度
                this.cursorRadius        null                                 // 光标圆角
                this.cursorColor         null                                 // 光标颜色
                ...
              })
             */
            TextField(
              // autofocus: true,
              decoration: InputDecoration(
                labelText: '用户名',
                hintText: '请输入用户名或邮箱',
                prefixIcon: Icon(Icons.person),
              ),
              onChanged: (value) {
                print("输入的值是:$value");
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: '密码',
                hintText: "请输入密码",
                prefixIcon: Icon(Icons.lock),
              ),
              controller: _myControllerPwd,
            ),
            TextField(
              focusNode: ageGetFocus, // 关联是否让年龄获得焦点
              decoration: InputDecoration(
                labelText: '年龄',
                hintText: "请输入年龄",
                prefixIcon: Icon(Icons.looks_6_outlined),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "失去焦点下划线为红色,获得焦点下划线为绿色",
                prefixIcon: Icon(Icons.location_history_sharp),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red), // 失去焦点下划线设为红色
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green), // 获得焦点下划线设为绿色
                ),
              ),
            ),
            FlatButton(
              color: Colors.amber,
              child: Text('点击来测试密码 TextField 的 controller'),
              onPressed: () {
                print('Second text field: ${_myControllerPwd.text}');
              },
            ),
            FlatButton(
              color: Colors.amber,
              child: Text('点击让年龄获得焦点'),
              onPressed: () {
                // 写法一：
                FocusScope.of(context).requestFocus(ageGetFocus);
                // 写法二：(如果在部件中未定义 focusScopeNode【参照第21行】则适用于写法一，反之则适用于写法二)
                // if (null == focusScopeNode) {
                //   focusScopeNode = FocusScope.of(context);
                // }
                // focusScopeNode.requestFocus(ageGetFocus);
              },
            ),
            FlatButton(
              color: Colors.amber,
              child: Text('点击让年龄失去焦点'),
              onPressed: () {
                ageGetFocus.unfocus();
              },
            ),
            OutlineButton(
              child: Text('点击查看表单及更多的部件'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return WidgetForm(); // 点击查看输入框
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
