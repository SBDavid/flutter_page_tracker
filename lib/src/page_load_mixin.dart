import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'page_tracker_aware.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'page_load_provider.dart';

// 监控页面加载时长
mixin PageLoadMixin<T extends StatefulWidget> on State<T>, PageTrackerAware {
  // 增加页面加载时间统计
  DateTime _firstCreateTime;  // 初始化时间
  DateTime _firstBuildTIme;   // 首次build时间，通常为布局解析时间
  DateTime _beginRequestTime; // 发起网络请求
  DateTime _endRequestTime;   // 网络请求结束
  DateTime _rebuildStartTime; // 得到请求结果后二次刷新开始的时间
  DateTime _nextFrameTime;    // 二次刷新后，完成渲染的时间

  StreamSubscription<int> _httpRequestSS;

  @protected
  String get httpRequestKey => null;

  void _didPageloaded() {

    // 总时间
    Duration totalTime = _nextFrameTime.difference(_firstCreateTime);
    // 页面初始化时间
    Duration buildTime = _firstBuildTIme.difference(_firstCreateTime);
    // 网络请求时间
    Duration requestTime = httpRequestKey == null ? null : _endRequestTime.difference(_beginRequestTime);
    // 渲染时间
    Duration renderTime = _nextFrameTime.difference(_rebuildStartTime);

    if (PageLoadProvider.of(context) != 'pro') {
      Fluttertoast.showToast(msg: "加载时长：${totalTime.inMilliseconds}");
    }

    didPageLoaded(totalTime, buildTime, requestTime, renderTime);
  }

  void beginRequestTime() {
    _beginRequestTime ??= DateTime.now();
  }

  void endRequestTime() {
    _endRequestTime ??= DateTime.now();
  }

  @override
  void setState(fn) {
    if (httpRequestKey != null && _endRequestTime != null && _rebuildStartTime == null) {
      _rebuildStartTime = DateTime.now();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _nextFrameTime ??= DateTime.now();
        _didPageloaded();
      });
    }
    super.setState(fn);
  }

  void _handleHttpRequestEvent(int type) {
    if (type == 0) {
      beginRequestTime();
    }

    if (type == 1) {
      endRequestTime();
    }
  }

  @override
  void initState() {
    super.initState();
    _firstCreateTime ??= DateTime.now();

    // 监听网络开始加载
    if (httpRequestKey != null) {
      _httpRequestSS = PageLoadHttpRequestObserver.on(httpRequestKey).listen(_handleHttpRequestEvent);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _firstBuildTIme ??= DateTime.now();
    rebuildStartTime();
  }

  void rebuildStartTime() {
    if (httpRequestKey == null) { // 没有网络请求
      if (_rebuildStartTime == null) {
        _rebuildStartTime = DateTime.now();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _nextFrameTime ??= DateTime.now();
          _didPageloaded();
        });
      }
    } else { // 使用网络请求
      if (_endRequestTime != null && _rebuildStartTime == null) {
        _rebuildStartTime = DateTime.now();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _nextFrameTime ??= DateTime.now();
          _didPageloaded();
        });
      }
    }
  }

  @override
  void dispose() {
    _httpRequestSS?.cancel();
    super.dispose();
  }
}

// 监控网络请求
class PageLoadHttpRequestObserver {
  static StreamController<Map> _streamController = StreamController.broadcast(sync: true);

  static void fireHttpRequestStart(String key) {
    _streamController.add({
      "key": key,
      "type": 0
    });
  }

  static void fireHttpRequestComplete(String key) {
    _streamController.add({
      "key": key,
      "type": 1
    });
  }

  static Stream<int> on(String key) {
    return _streamController.stream
      .where((Map event) => event['key'] == key)
      .map<int>((Map event) => event['type']);
  }

  static void destroy() {
    _streamController.close();
  }
}
