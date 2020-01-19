// 监控路由状态，并保存路由栈
import 'package:flutter/material.dart';
import 'page_tracker_aware.dart';

class TrackerStackObserver<R extends Route<dynamic>> extends NavigatorObserver {

  // 存放路由堆栈
  final List<Route> routes = [];
  final List<Route> routesPopup = [];
  // 每个页面对应的监听
  final Map<R, Set<PageTrackerAware>> _listeners = <R, Set<PageTrackerAware>>{};
  final Map<R, Set<PageTrackerAware>> _listenersPopup = <R, Set<PageTrackerAware>>{};

  void subscribe(PageTrackerAware pageTrackerAware, R route) {
    assert(pageTrackerAware != null);
    assert(route != null);

    if (route is PageRoute) {
      final Set<PageTrackerAware> subscribers = _listeners.putIfAbsent(
          route, () => Set<PageTrackerAware>());
      if (subscribers.add(pageTrackerAware)) {
        pageTrackerAware.didPageView();
      }
    } else if (route is PopupRoute) {
      final Set<PageTrackerAware> subscribers = _listenersPopup.putIfAbsent(
          route, () => Set<PageTrackerAware>());
      if (subscribers.add(pageTrackerAware)) {
        pageTrackerAware.didPageView();
      }
    }
  }

  void unsubscribe(PageTrackerAware pageTrackerAware) {
    assert(pageTrackerAware != null);

    for (R route in _listeners.keys) {
      final Set<PageTrackerAware> subscribers = _listeners[route];
      subscribers?.remove(pageTrackerAware);
    }

    for (R route in _listenersPopup.keys) {
      final Set<PageTrackerAware> subscribers = _listenersPopup[route];
      subscribers?.remove(pageTrackerAware);
    }
  }

  @override
  void didPush(Route route, Route previousRoute) {
    super.didPush(route, previousRoute);

    // 之后正常页面（非弹窗）入栈之后，才会触发前一个页面的离开
    if (route is PageRoute) {
      // 触发PageExit事件
      if (routes.length > 0) {
        R previousRoute = routes.last;
        final Set<PageTrackerAware> previousSubscribers = _listeners[previousRoute];
        if (previousSubscribers != null) {
          for (PageTrackerAware pageTrackerAware in previousSubscribers) {
            pageTrackerAware.didPageExit();
          }
        }
      }

      // 存储在路由栈上
      routes.add(route);

      // 触发相关PageView事件，在订阅的时候触发
      /*final Set<PageTrackerAware> subscribers = _listeners[route];
      if (subscribers != null) {
        for (PageTrackerAware pageTrackerAware in subscribers) {
          pageTrackerAware.didPageView();
        }
      }*/
    } else if (route is PopupRoute) {
      // 存储在路由栈上
      routesPopup.add(route);
    }
  }

  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);

    if (route is PageRoute) {
      // 触发PageExit
      final Set<PageTrackerAware> subscribers = _listeners[route];
      if (subscribers != null) {
        for (PageTrackerAware pageTrackerAware in subscribers) {
          pageTrackerAware.didPageExit();
        }
      }

      // 清除路由栈
      routes.removeLast();

      // 触发PageView
      if (routes.length > 0) {
        R previousRoute = routes.last;
        final Set<PageTrackerAware> previousSubscribers = _listeners[previousRoute];
        if (previousSubscribers != null) {
          Future.microtask(() {
            for (PageTrackerAware pageTrackerAware in previousSubscribers) {
              pageTrackerAware.didPageView();
            }
          });
        }
      }
    } else if (route is PopupRoute) {
      // 触发PageExit
      final Set<PageTrackerAware> subscribers = _listenersPopup[route];
      if (subscribers != null) {
        for (PageTrackerAware pageTrackerAware in subscribers) {
          pageTrackerAware.didPageExit();
        }
      }

      // 清除路由栈
      routesPopup.remove(route);
    }
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    super.didRemove(route, previousRoute);

    if (route is PageRoute) {
      routes.remove(route);
    } else if (route is PopupRoute) {
      routesPopup.remove(route);
    }
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);

    if (oldRoute is PageRoute) {
      int index = routes.indexOf(oldRoute);
      assert(index != -1);
      routes.removeAt(index);

      routes.insert(index, newRoute);
    } else if (oldRoute is PopupRoute) {
      int index = routesPopup.indexOf(oldRoute);
      assert(index != -1);
      routesPopup.removeAt(index);

      routesPopup.insert(index, newRoute);
    }
  }

}