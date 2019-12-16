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
  _State createState() {
    return _State();
  }

}

class _State extends State<PageViewListenerWrapper> with PageTrackerAware, PageViewListenerMixin {
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
  }

  @override
  void didPageExit() {
    super.didPageExit();
    widget.onPageExit != null ? widget.onPageExit() : '';
  }
}