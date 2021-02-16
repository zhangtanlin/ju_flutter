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

  //定义一个globalKey, 由于 GlobalKey 要保持全局唯一性，我们使用静态变量存储。
  static GlobalKey<ScaffoldState> _globalKey = GlobalKey();

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
   * 注意：把 build（）方法放在 state 中主要是为了开发的灵活性，如果放在 stateful了Widget 会出现两个问题：
   *      （1）：状态访问不便。如果 statefullwidget 有很多状态，而每次状态改变都要调用 build方法，由于状态是保存在 state中，
   *       如果build方法在 statefullwidget 中，那么构建时读取状态不便。
   *       例如由于构建用户界面，过程需要依赖state，所以build方法将必须加一个 state参数。如：
   *          Widget build(BuildContext context, State state){...}
   *       这样的话，就只能将state的所有状态申明为公开，这样才能在state类外部访问状态。但是状态将不具有私密性，这样会导致状态的修改将会变的不可控，
   *       如果将build方法放在state中，构建过程不仅可以直接访问，而且也无需公开私有状态。
   *      （2）：继承 statefullwidget 不便。 例如：
   *       flutter 中有一个动画widget的基类 AnimatedWidget，它继承自 StatefullWidget 类。
   *       AnimatedWidget 中引入一个抽象方法 build(BuildContext context),继承自 AnimatedWidget 的动画都要实现这个 build 方法。
   *       现在设想如果 StatefullWidget 类中已经有了一个 build方法，正如上面所述，此时 build方法需要接收一个 state 对象，这就意味着
   *       AnimatedWidget 必须将自己的 State 对象（记为_animatedWidgetState）提供给其子类，因此子类需要在其 build 方法中调用父类的 build 方法。如：
   *          class MyAnimationWidget exteneds AnimatedWidget{
   *            @override
   *            Widget build(BuildContext context, State state){
   *              super.build(context, _animatedWidgetState)
   *            }
   *          }
   *       但是这样很显然不合理，因为：
   *       a: AnimatedWidget 的状态对象是 AnimatedWidget 内部实现细节，不应该暴露给外部。
   *       b: 如果要将父类状态暴露给子类，那么必须得有一种传递机制，而做这一套传递机制是无意义的，因为父子类之间状态的传递和子类本身逻辑是无关的。
   */
  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
        key: _globalKey, // 设置 GlobalKey 的 key
        appBar: AppBar(
          title: Text('StatefullWidget'),
        ),
        body: Center(child: Builder(builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                  child: Text('$_counter'),
                  textColor: Colors.red[900],
                  // 点击后计数器自增
                  onPressed: () => setState(() => ++_counter)),
              RaisedButton(
                child: Text("点击显示 SnackBar 部件"),
                textColor: Colors.pink,
                onPressed: () async {
                  /**
                   * 查找父级最近的Scaffold对应的ScaffoldState对象。
                   * context 对象有一个 findAncestorStateOfType() 方法，
                   * 该方法可以从当前节点沿着widget树向上查找指定类型的StatefulWidget对应的State对象。
                   * 注意：
                   * 如果 StatefullWidget 的状态是私有的（不应该向外暴露），那么我们的代码中就不应该去直接获取其 state 对象，如果 StatefullWidget 的状态是希望暴露出的（通常还有一些组件的操作方法）我们则可以去直接获取其 state 对象。
                   * 但是通过 context.findAncestorStateOfType获取 StatefullWidget 的状态的方法是通用的，我们并不能在语法层面指定 statefullWidet 的状态是否私有，所以在flutter 开发中便有了一个默认的约定：
                   * 如果 StatefullWidget 的状态时希望暴露的，应当在 StatefullWidget 中提供一个 of 静态方法来获取其 State 对象，开发者便可直接通过该方法来获取。
                   * 如果 State 不希望暴露，则不提供 of 方法，这个约定在 flutter SDK 里随处可见。
                   */
                  // 方法一：
                  // ScaffoldState _state =
                  //     context.findAncestorStateOfType<ScaffoldState>();
                  // _state.showSnackBar(SnackBar(
                  //     content: Text(
                  //         '我是 SnackBar 部件'))); //调用ScaffoldState的showSnackBar来弹出SnackBar
                  // 方法二：（等价于上面的方法）
                  // ScaffoldState _state = Scaffold.of(context);
                  // _state
                  //     .showSnackBar(SnackBar(content: Text('我是 SnackBar 部件')));
                  /**
                   * 方法三：（通过GlobalKey来获取 State 对象的方法）
                   * GlobalKey 是 Flutter 提供的一种在整个APP中引用element的机制。
                   * 如果一个widget设置了GlobalKey，那么我们便可以通过globalKey.currentWidget获得该widget对象、
                   * globalKey.currentElement来获得widget对应的element对象，如果当前widget是StatefulWidget，
                   * 则可以通过globalKey.currentState来获得该widget对应的state对象。
                   * 注意：GlobalKey开销较大，如果有其他可选方案，应尽量避免使用它。另外同一个GlobalKey在整个widget树中必须是唯一的，不能重复。
                   */
                  ScaffoldState _state = _globalKey.currentState;
                  _state
                      .showSnackBar(SnackBar(content: Text('我是 SnackBar 部件')));
                },
              ),
            ],
          );
        })));
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
