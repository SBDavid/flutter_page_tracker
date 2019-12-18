import 'package:flutter/material.dart';
import 'dart:async';

import 'page_tracker_aware.dart';
import 'page_view_wrapper.dart';

mixin PageViewListenerMixin<T extends StatefulWidget> on State<T>, PageTrackerAware {

  StreamSubscription<PageTrackerEvent> sb;
  bool isPageView = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (sb == null) {
      sb = PageViewWrapper.of(context, pageViewIndex).listen(
          _onPageTrackerEvent);
    }
  }

  void _onPageTrackerEvent(PageTrackerEvent event) {
    if (event == PageTrackerEvent.PageView) {
      if (!isPageView) {
        didPageView();
        isPageView = true;
      }
    } else {
      if (isPageView) {
        didPageExit();
        isPageView = false;
      }
    }
  }

  int get pageViewIndex => null;

  @override
  void didPageView() {
    super.didPageView();
  }

  @override
  void didPageExit() {
    super.didPageExit();
  }

  @override
  void dispose() {
    if (isPageView)
      didPageExit();
    sb?.cancel();
    super.dispose();
  }
}


// 列表项中还可以再次嵌套列表，所以[PageViewListenerWrapper]需要把
class PageViewListenerWrapper extends StatefulWidget {

  final int index;
  final Widget child;
  final VoidCallback onPageView;
  final VoidCallback onPageExit;

  const PageViewListenerWrapper(this.index, {
    Key key,
    this.child,
    this.onPageView,
    this.onPageExit,
  }): super(key: key);

  @override
  PageViewListenerWrapperState createState() {
    return PageViewListenerWrapperState();
  }

  static PageViewListenerWrapperState of(BuildContext context) {
    return context.ancestorStateOfType(TypeMatcher<PageViewListenerWrapperState>());
  }
}

class PageViewListenerWrapperState extends State<PageViewListenerWrapper> with PageTrackerAware, PageViewListenerMixin {

  // 向列表中的列表转发页面事件
  Set<PageTrackerAware> subscribers;

  @override
  void initState() {
    super.initState();

    subscribers = Set<PageTrackerAware>();
  }

  // 子列表页面订阅页面事件
  void subscribe(PageTrackerAware pageTrackerAware) {
    subscribers.add(pageTrackerAware);
  }

  void unsubscribe(PageTrackerAware pageTrackerAware) {
    subscribers.remove(pageTrackerAware);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }


  @override
  int get pageViewIndex => widget.index;

  @override
  void didPageView() {
    super.didPageView();
    widget.onPageView != null ? widget.onPageView() : '';
    subscribers.forEach((subscriber) {
      subscriber.didPageView();
    });
  }

  @override
  void didPageExit() {
    super.didPageExit();
    widget.onPageExit != null ? widget.onPageExit() : '';
    subscribers.forEach((subscriber) {
      subscriber.didPageExit();
    });
  }
}