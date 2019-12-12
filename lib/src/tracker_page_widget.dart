import 'package:flutter/material.dart';
import 'tracker_page_mixin.dart';
import 'page_tracker_aware.dart';

// 废弃
class TrackerPageWidget extends StatefulWidget {

  final Widget child;

  const TrackerPageWidget({Key key, this.child}):
      assert(child != null),
      super(key: key);

  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<TrackerPageWidget> with PageTrackerAware, TrackerPageMixin {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void didPageView() {
    super.didPageView();

    print("pageview");
  }

  @override
  void didPageExit() {
    super.didPageExit();
    print("didPageExit");
  }
}