import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'page_tracker_aware.dart';
import 'tracker_route_observer.dart';
import 'tracker_route_observer_provider.dart';

mixin TrackerPageMixin<T extends StatefulWidget> on State<T>, PageTrackerAware {
  TrackerStackObserver<ModalRoute> _routeObserver;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_routeObserver != null) {
      return;
    }
    _routeObserver = TrackerRouteObserverProvider.of(context)
      ..subscribe(
        this,
        ModalRoute.of(context),
      );
  }

  @override
  void dispose() {
    _routeObserver?.unsubscribe(this);
    super.dispose();
  }
}
