import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'tracker_route_observer.dart';

class TrackerRouteObserverProvider extends Provider<TrackerStackObserver<ModalRoute>> {
  TrackerRouteObserverProvider({
    Key key,
    Widget child,
  }) : super(
    create: (context) => TrackerStackObserver<ModalRoute>(),
    key: key,
    child: child,
  );

  static TrackerStackObserver<ModalRoute> of(BuildContext context) =>
      Provider.of<TrackerStackObserver<ModalRoute>>(
        context,
        listen: false,
      );
}
