import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'page_tracker_aware.dart';
import 'tracker_route_observer.dart';
import 'page_view_listener_mixin.dart';
import 'tracker_route_observer_provider.dart';

mixin TrackerPageMixin<T extends StatefulWidget> on State<T>, PageTrackerAware {
  TrackerStackObserver<ModalRoute> _routeObserver;
  PageViewListenerWrapperState _pageViewListenerWrapperState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_pageViewListenerWrapperState != null) {
      return;
    }

    _pageViewListenerWrapperState = PageViewListenerWrapper.of(context);
    if (_pageViewListenerWrapperState != null) {
      _pageViewListenerWrapperState.subscribe(this);
      return;
    }


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
    _pageViewListenerWrapperState?.unsubscribe(this);
    super.dispose();
  }
}
