/// mixin 学习文档:https://juejin.cn/post/6844903908293214221
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 列表加载中
mixin ListLoadingMixin on State {
  bool _startRefresh = false;
  bool _startLoading = false;
  List<dynamic> _refreshList = [];
  List<dynamic> get _getRefreshList => _refreshList;
  int _currentPage = 1;
  RefreshController refreshController;
  int get getCurrentPage => _currentPage;
  int get getPageSize => setPageSize();
  int setPageSize() {
    return 10;
  }

  Timer _timerOut;

  /// 广告
  int _adPosition = 7;
  int get getAdPosition => _adPosition;
  set setAdPosition(int adPosition) {
    _adPosition = [5, adPosition].reduce(
      (max, element) {
        if (max > element) {
          return max;
        } else {
          return element;
        }
      },
    );
  }

  /// 初始化刷新
  RefreshController getCustomRefreshContorller() {
    return RefreshController(initialRefresh: false);
  }

  /// 设置列表状态
  setListStatus(
    bool isRefresh,
    bool isNotEmptyData,
    VoidCallback callback,
  ) {
    if (isRefresh) {}
  }

  @override
  void initState() {
    super.initState();
    refreshController = getCustomRefreshContorller();
  }

  @override
  void dispose() {
    try {
      if (refreshController != null) {
        refreshController.dispose();
      }
      if (_timerOut != null) {
        _timerOut.cancel();
      }
    } catch (e) {
      e.toString();
    }
    super.dispose();
  }
}
