import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'page_tracker_aware.dart';
import 'tracker_route_observer.dart';
import 'page_view_listener_mixin.dart';
import 'tracker_route_observer_provider.dart';

mixin PageLoadMixin<T extends StatefulWidget> on State<T>, PageTrackerAware {
  // 增加页面加载时间统计
  DateTime _firstCreateTime;  // 初始化时间
  DateTime _firstBuildTIme;   // 首次build时间，通常为加载页面
  DateTime _beginRequestTime; // 发起网络请求
  DateTime _endRequestTime;   // 网络请求结束
  DateTime _rebuildStartTime; // 得到请求结果后二次刷新的时间
  DateTime _nextFrameTime;    // 二次刷新后显示的时间
  @protected
  get hasRequest => false;

  void _didPageloaded(Duration duration) {
    didPageLoaded(duration);
  }

  void beginRequestTime() {
    _beginRequestTime ??= DateTime.now();
  }

  void endRequestTime() {
    _endRequestTime ??= DateTime.now();
  }

  @override
  void setState(fn) {
    if (hasRequest && _endRequestTime != null && _rebuildStartTime == null) {
      _rebuildStartTime = DateTime.now();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _nextFrameTime ??= DateTime.now();
        _didPageloaded(_nextFrameTime.difference(_firstBuildTIme));
      });
    }
    super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    _firstCreateTime ??= DateTime.now();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _firstBuildTIme ??= DateTime.now();
    if (!hasRequest) {
      if (_rebuildStartTime == null) {
        _rebuildStartTime = DateTime.now();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _nextFrameTime ??= DateTime.now();
          _didPageloaded(_nextFrameTime.difference(_firstBuildTIme));
        });
      }
    } else {
      if (_endRequestTime != null && _rebuildStartTime == null) {
        _rebuildStartTime = DateTime.now();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _nextFrameTime ??= DateTime.now();
          _didPageloaded(_nextFrameTime.difference(_firstBuildTIme));
        });
      }
    }
  }
}
