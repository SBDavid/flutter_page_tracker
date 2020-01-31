import 'package:flutter/widgets.dart';
import 'tracker_route_observer.dart';

class TrackerRouteObserverProvider extends InheritedWidget {

  final TrackerStackObserver<ModalRoute> trackerStackObserver = TrackerStackObserver<ModalRoute>();

  TrackerRouteObserverProvider({
    Key key,
    @required Widget child,
  }): super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static TrackerStackObserver<ModalRoute> of(BuildContext context) {
    try {
      return (context.inheritFromWidgetOfExactType(
          TrackerRouteObserverProvider) as TrackerRouteObserverProvider)
          .trackerStackObserver;
    } catch (err) {
      return null;
    }
  }
}
