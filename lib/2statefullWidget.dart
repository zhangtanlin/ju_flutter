/*
 * 一个 StatefullWidget 类对应一个 State 类，State 表示与其对应的 StatefullWidget 要维护的状态。
 * 1:在 widget 构建时 State 状态值可以被同步读取。
 * 2:在 widget 生命周期中 State 状态值可以被改变，当 State被改变时，可以手动调用 setState()方法通知 flutter framework 状态发生改变了，
 *    flutter framework 在收到消息后，会重新调用其 build 方法重新构建 wodget 树，从而达到更新 ui 的目的。
 * State 有两个常用属性:
 * 1: widget 他表示与该 State 实例关联的 widget 实例，这种关联并非永久，因为在应用生命周期中，
 *    ui 树上的某一个节点的 widget 实例在重新构建时可能会变化，
 *    但 State 实例只会在第一次插入 widget 树中时被创建，
 *    当在重新构建时，如果 widget 被修改，flutter framework 会动态设置 State.widget 为新的 widget 实例。
 * 2: context, StatefullWidget对应的 BuildContext ，作用和 StatelessWidget 的 BuildContext 一样。
 * State 生命周期演示:
 */

/*
 * 一个计数器 widget,点击它可以使计数器加1。
 * CounterWidget 接收一个 initValue 整型参数，它表示计数器的初始值。下面我们看一下State的代码
 */
import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({Key key, this.initValue: 0});
  final int initValue;
  @override
  _CounterWidgetState createState() => new _CounterWidgetState();
}

// 计数器（生命周期）
class _CounterWidgetState extends State<CounterWidget> {
  int _counter;

  /*
   * 当 Widget 第一次插入到 Widget 树时会被调用，对于每一个 State 对象， flutter framework 只会调用一次，
   * 所以通常在该回调中做一些一次性的操作，如状态初始化/订阅子树的事件通知等。
   * 不能在该回调中调用 BuildContext.dependOnInheritedWidgetOfExactType,
   * 该方法用于在 Widget 树上获取离当前 widget 最近的一个父级 InheritFromWidget,原因是初始化完成后，Widget树中的 InheritFromWidget 也可能发生变化，
   * 所以正确的做法应该在 build() 方法或者 didChangeDependencies() 中调用它。 
   */
  @override
  void initState() {
    super.initState();
    // 初始化状态
    _counter = widget.initValue;
    print('initState');
  }

  /*
   * 构建 Widget 子树，一下场景会被调用
   * 1:在调用 initState() 之后。
   * 2:在调用 disUpdateWidget() 之后。
   * 3:在调用 setState() 之后。
   * 4:在调用 didChangeDepencies() 之后。
   * 5:在 State 对象从 Widget 树中的一个位置移除后（会调用 deactivate）又重新插入到 Widget 树的其他位置之后。
   */
  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
        body: Center(
            child: FlatButton(
                child: Text('$_counter'),
                // 点击后计数器自增
                onPressed: () => setState(() => ++_counter))));
  }

  /*
   * Widget 重新构建时，
   * flutter framework 会调用 Widget.canUpdate 来检测 Widget 树中同一位置的新旧节点，然后决定是否需要更新，
   * 如果 Widget.canUpdate 返回 true 则会调用此函数。
   * 正如之前所述，Widget.canUpdate 会在新旧 widget 的 key 和 runtimeType同时相等时会返回 true，
   * 也就是说在新旧 widget 的 key 和 runtimeType 同时相等时 didUpdateWidge 就会被调用。 
   */
  @override
  void didUpdateWidget(CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  /*
   * 当 State 对象从树中被移除时，会调用此回调。
   * 在一些场景下 flutter framework 会将 State 对象重新插到树中，如包含此 State 对象的子树在树的一个位置移动到另一个位置时（可以通过GlobalKey来实现）。
   * 如果移除后没有重新插入到树中则紧接着会调用 dispose()方法。
   */
  @override
  void deactivate() {
    super.deactivate();
    print('deactivate');
  }

  // 当 State 对象从树中被永久移除时调用，通常在此会调用释放资源。
  @override
  void dispose() {
    super.dispose();
    print('dispose');
  }

  // 为开发调试提供的，在热重载（hot reload）时会被调用，此回调在 Release 模式下永远不会被调用。
  @override
  void reassemble() {
    super.reassemble();
    print('reassemble');
  }

  /*
   * 当 State 对象的依赖发生变化时会被调用，例如：
   * 在之前 build() 中包含了一个 InheritedWidget，然后在之后的 build() 中 InheritedWidget 发生变化，
   * 那么此时 InheritedWidget 的子 Widget 的 didChangeDependencies() 回调都会被调用。
   * 典型的场景是当系统语言 Locale 或应用主题改变时，flutter framework 会通知 widget 调用此回调。 
   */
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }
}