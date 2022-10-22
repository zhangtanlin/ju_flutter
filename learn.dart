/// 整体架构思路参考文档:https://hastebin.com/ilapixerel.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyProviders(
      child: MaterialApp(home: MyHome()),
    );
  }
}

class MyProviders extends StatelessWidget {
  /// 工程中用到的所有 provider
  const MyProviders({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: MetaProvider.fromContext),
        Provider(create: NetProvider.fromContext),
        Provider(create: Repository.fromContext),
        ChangeNotifierProvider(create: LogicProvider.fromContext),
      ],
      child: child,
    );
  }
}

/// 元数据提供者
class MetaProvider {
  const MetaProvider({this.isDebug = false});
  MetaProvider.fromContext(BuildContext context) : this(isDebug: true);

  final bool isDebug;

  String baseUrl() => isDebug ? _debugUrl : _releaseUrl;

  static const _debugUrl = "http://localhost:8080/api";
  static const _releaseUrl = "http://www.xx.com/api";
}

/// 网络功能提供者
class NetProvider {
  const NetProvider({required this.dio});
  NetProvider.fromContext(BuildContext context) : this(dio: _create(context));

  final Dio dio;

  static Dio _create(BuildContext context) {
    final MetaProvider meta = context.read();
    return Dio(BaseOptions(baseUrl: meta.baseUrl()));
  }
}

/// 请求提供者
abstract class Repository {
  factory Repository.fromContext(BuildContext context) {
    final isDebug = context.read<MetaProvider>().isDebug;
    if (isDebug) {
      return MockRepoProvider.fromContext(context);
    }
    return RepoProvider.fromContext(context);
  }

  Future<String?> getState();
}

/// 网络业务请求提供者
class RepoProvider implements Repository {
  const RepoProvider({required NetProvider net}) : _net = net;
  RepoProvider.fromContext(BuildContext context) : this(net: context.read());

  final NetProvider _net;

  @override
  Future<String?> getState() async {
    try {
      final resp = await _net.dio.get('/state');
      return resp.data?.toString();
    } catch (e) {
      debugPrint('http error: $e');
      return null;
    }
  }
}

/// 模拟业务请求提供者
class MockRepoProvider implements Repository {
  MockRepoProvider.fromContext(BuildContext context);

  @override
  Future<String?> getState() async => 'mock state';
}

// 业务逻辑提供者
class LogicProvider extends ChangeNotifier {
  LogicProvider({required Repository repo}) : _repo = repo;
  LogicProvider.fromContext(BuildContext context) : this(repo: context.read());

  final Repository _repo;

  String _state = '';
  String get state => _state;

  void _updateState(String value) {
    _state = value;
    notifyListeners();
  }

  Future<void> update() async {
    final data = await _repo.getState();
    if (data == null) {
      _updateState('null');
    } else {
      _updateState(data);
    }
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    final btn = TextButton(
      onPressed: _onPressed,
      child: const Text('click'),
    );

    final state = Consumer<LogicProvider>(
      builder: (ctx, vm, child) => Text('current state: ${vm.state}'),
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            btn,
            state,
          ],
        ),
      ),
    );
  }

  Future<void> _onPressed() async {
    final vm = context.read<LogicProvider>();
    await vm.update();
  }
}
