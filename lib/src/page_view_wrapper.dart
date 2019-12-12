import 'package:flutter/material.dart';
import 'dart:async';

import 'tracker_page_mixin.dart';
import 'page_tracker_aware.dart';

enum PageTrackerEvent {PageView, PageExit}

class PageViewWrapper extends StatefulWidget {

  final int pageAmount;
  final Widget child;
  final PageController pageController;

  const PageViewWrapper({
    Key key,
    this.pageAmount = 0,
    this.child,
    this.pageController,
  }):
        assert(pageAmount != null),
        super(key: key);

  @override
  PageViewWrapperState createState() {

    return PageViewWrapperState();
  }

  static Stream<PageTrackerEvent> of(BuildContext context, int index) {
    assert(index >= 0);
    List<Stream<PageTrackerEvent>> broadCaseStreams = (context.ancestorStateOfType(TypeMatcher<PageViewWrapperState>()) as PageViewWrapperState).broadCaseStreams;
    assert(index < broadCaseStreams.length);

    return broadCaseStreams[index];
  }
}

class PageViewWrapperState extends State<PageViewWrapper> with PageTrackerAware, TrackerPageMixin {

  List<StreamController<PageTrackerEvent>> controllers = [];
  List<Stream<PageTrackerEvent>> broadCaseStreams = [];
  // 上一次打开的Page
  int currPageIndex;

  @override
  void initState() {
    super.initState();

    currPageIndex = widget.pageController.initialPage;

    // 创建streams
    controllers = List(widget.pageAmount);
    for(int i=0; i<controllers.length; i++) {
      controllers[i] = StreamController<PageTrackerEvent>();
    }

    broadCaseStreams = controllers.map((controller) {
      return controller.stream.asBroadcastStream();
    }).toList();

    // 发送首次PageView事件
    controllers[currPageIndex].sink.add(PageTrackerEvent.PageView);

    // 发送后续Page事件
    widget.pageController.addListener(_onPageChange);
  }

  void _onPageChange() {

    if (0 != widget.pageController.page % 1.0) {
      return;
    }

    if (currPageIndex == widget.pageController.page.toInt()) {
      return;
    }

    // 发送PageExit
    if (currPageIndex != null) {
      controllers[currPageIndex].sink.add(PageTrackerEvent.PageExit);
    }

    currPageIndex = widget.pageController.page.toInt();

    // 发送PageView
    controllers[currPageIndex].sink.add(PageTrackerEvent.PageView);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void didPageView() {
    super.didPageView();
    controllers[currPageIndex].sink.add(PageTrackerEvent.PageView);
  }

  @override
  void didPageExit() {
    super.didPageExit();
    // 发送tab中的page离开
    controllers[currPageIndex].sink.add(PageTrackerEvent.PageExit);
  }

  @override
  void dispose() {
    super.dispose();
  }

}
