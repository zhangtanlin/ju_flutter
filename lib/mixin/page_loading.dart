import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum PageLoadStateType { noNet, loading, empty, success, error }

/// 整体界面加载
mixin PageLoadMixin<W extends StatefulWidget> on State<W> {
  PageLoadStateType _loadStateType = PageLoadStateType.loading;

  onLoadData();

  Widget successView();

  setPageState(bool isNotEmptyData) {
    if (mounted) {
      setState(() {
        if (isNotEmptyData) {
          _loadStateType = PageLoadStateType.success;
        } else {
          _loadStateType = PageLoadStateType.empty;
        }
      });
    }
  }

  setPageErrorState(error) {
    if (mounted) {
      setState(() {
        if (error.code) {
          _loadStateType = PageLoadStateType.noNet;
        } else {
          _loadStateType = PageLoadStateType.error;
        }
      });
    }
  }

  Widget handlePageStateView() {
    return getPageStateView(_loadStateType);
  }

  retryLoadData() {
    setState(() {
      _loadStateType = PageLoadStateType.loading;
    });
    onLoadData();
  }

  /// 根据类型显示不同的加载状态
  Widget getPageStateView(PageLoadStateType type) {
    Widget showWidget;
    switch (type) {
      case PageLoadStateType.noNet:
        // showWidget = LoadSateWidget.noNetWorkView(retryLoadData);
        break;
      case PageLoadStateType.loading:
        // showWidget = LoadSateWidget.loadingView();
        break;
      case PageLoadStateType.empty:
        // showWidget = LoadSateWidget.noDataView(retryLoadData);
        break;
      case PageLoadStateType.success:
        showWidget = successView();
        break;
      case PageLoadStateType.error:
        // showWidget = LoadSateWidget.errorView(retryLoadData);
        break;
    }
    return showWidget;
  }
}
