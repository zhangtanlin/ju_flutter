/*
 * flutter SDK 内置部件介绍
 */
import 'package:flutter/material.dart';

class WidgetProgress extends StatefulWidget {
  @override
  _WidgetProgressState createState() => new _WidgetProgressState();
}

class _WidgetProgressState extends State<WidgetProgress> {
  /*
   * Form 部件相关参数
   * _formNameController Form表单用户名的 controller 方法
   * _formNameController Form表单密码的 controller 方法
   */
  GlobalKey _formKey = new GlobalKey<FormState>();
  final TextEditingController _formNameController = TextEditingController();
  final TextEditingController _formPwdController = TextEditingController();

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
               * form  部件继承自 StatefulWidget对象，它对应的状态类为 FormState。
                Form({
                  @required Widget child,    // 
                  bool autovalidate = false, // 是否自动校验输入内容，
                                                当为 true 时，每一个自 FormField 内容发动变化时都会自动校验合法性，并直接显示错误信息，
                                                否则，需要通过调用 FormState.validate()来手动校验。
                  WillPopCallback onWillPop, // 决定 Formu 所在的路由是否可以直接返回（如点击返回按钮），该回调返回一个 Future 对象，
                                                如果 Future 的最终结果是 false，则当前路由不会返回；如果为 true 则会返回到上一个路由。
                                                此属性通常用于拦截返回按钮。
                  VoidCallback onChanged,    // Form 的任意一个子 FormField 内容发生变化时会触发此回调。
                })
               * Foem 的子孙元素必须是 FormField 类型，FormField 是一个抽象类，定义几个属性， FormState 内部通过他们来完成操作。
                const FormField({
                  ...
                  FormFieldSetter<T> onSave,       // 保存回调
                  FormFieldValidator<T> validator, // 验证回调
                  T initialValue,                  // 初始值
                  bool autovalidate = false,       // 是否自动校验
                })
               * 为了方便使用， Flutter 提供了 TextFormField 组建，它继承自 FormField 类，也是 TextField 的一个包装类，所以除了FormField 定义的属性之外，它还包括 Textfield 属性。
               * FormState 为 Form 的 State类，可以通过 Form.of 或 GlobalKey 获得。可以通过它来对 Form 的子孙 FormField 进行统一操作。常用方法有：
               * 1:FormState.validate：调用此方法后，会调用 Form 子孙 FormField 的 validate 回调，如果有一个校验失败则返回false，所有校验失败项都会返回用户返回的错误提示。
               * 2:FormState.save()：调用此方法后，会调用 Form 子孙 FormField 的 save 回调，用于保存表单内容。
               * 2:FormState.reset()：调用此方法后，会将子孙 FormField 的内容清空。
               */
              Form(
                key: _formKey, // 设置 GlobalKey 用于后面获取 FormState
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      // autofocus: true, // 自动获取焦点
                      controller: _formNameController,
                      decoration: InputDecoration(
                          labelText: '表单用户名',
                          hintText: '请输入用户名',
                          icon: Icon(Icons.ac_unit)),
                      validator: (v) {
                        return v.trim().length > 0 ? null : '用户名不能为空';
                      }, // 校验用户名
                    ),
                    TextFormField(
                      controller: _formPwdController,
                      decoration: InputDecoration(
                          labelText: '表单密码',
                          hintText: '请输入表单密码',
                          icon: Icon(Icons.access_alarm)),
                      obscureText: true,
                      validator: (v) {
                        return v.trim().length > 5 ? null : '密码不能少于6位';
                      }, // 校验密码
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Row(children: <Widget>[
                        Expanded(
                            child: RaisedButton(
                                child: Text('登陆'),
                                color: Colors.amber[900],
                                textColor: Colors.white,
                                onPressed: () {
                                  /**
                                   * 注意：这里不能通过 Form.of(context) 方法获取，此处会得到 null。
                                   * 原因是：此处的 context 为 WidgetProgress 的 context，而 Form.of(context) 是根据所指定的 context 向根去查找，
                                   * 而 FormState 是在 WidgetProgress 的子树中，所以不行。
                                   * 正确的做法是通过 Build来构建登陆按钮，Build 会将 widget 节点的 context 作为回调函数(参考下一个 Expanded 的写法)。
                                   * 注意：context 正是操作 Widget 所对应的 Element 的一个接口，由于 Widget 树对应的 Element 都是不同的，
                                   * 所以 context 也都是不同的，有关 context 的更多内容后面补充。
                                   * flutter 中有很多"of(context)"这种方法，使用时一定要注意 context 是否正确。
                                   */
                                  print(Form.of(context)); // 此处会得到 null
                                  // 通过 _formKey.currentState 获取 FormState后，调用 validate() 方法校验用户名密码是否合法，校验通过后再提交数据
                                  if ((_formKey.currentState as FormState)
                                      .validate()) {
                                    print('验证通过提交数据');
                                  } else {
                                    print('验证未通过');
                                  }
                                })),
                        Expanded(child: Builder(
                          builder: (context) {
                            return RaisedButton(
                                child: Text('获取 Form.of(context)状态值'),
                                color: Colors.amber[900],
                                textColor: Colors.white,
                                onPressed: () {
                                  print(Form.of(context)); // 此处会得到 null
                                  if ((_formKey.currentState as FormState)
                                      .validate()) {
                                    print('验证通过提交数据');
                                  } else {
                                    print('验证未通过');
                                  }
                                });
                          },
                        ))
                      ]),
                    ),
                  ],
                ),
              )
            ])));
  }
}
