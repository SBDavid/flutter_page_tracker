import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'page_tracker_aware.dart';
import 'tracker_route_observer.dart';

mixin TrackerPageMixin<T extends StatefulWidget> on State<T>, PageTrackerAware {
  TrackerStackObserver<PageRoute> _routeObserver;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_routeObserver != null) {
      return;
    }
    _routeObserver = Provider.of(context, listen: false)
      ..subscribe(
        this,
        ModalRoute.of(context),
      );
  }

  @override
  void dispose() {
    _routeObserver.unsubscribe(this);
    super.dispose();
  }
}
