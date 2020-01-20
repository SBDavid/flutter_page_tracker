import 'package:flutter/material.dart';
import 'tracker_page_mixin.dart';
import 'page_tracker_aware.dart';

class TrackerDialogWrapper extends StatefulWidget {

  final Widget child;
  final VoidCallback didPageView;
  final VoidCallback didPageExit;

  const TrackerDialogWrapper({
    Key key,
    this.child,
    this.didPageView,
    this.didPageExit,
  }):
        assert(child != null),
        super(key: key);

  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<TrackerDialogWrapper> with PageTrackerAware, TrackerPageMixin {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void didPageView() {
    super.didPageView();

    if (widget.didPageView != null) {
      widget.didPageView();
    }
  }

  @override
  void didPageExit() {
    super.didPageExit();

    if (widget.didPageExit != null) {
      widget.didPageExit();
    }
  }
}