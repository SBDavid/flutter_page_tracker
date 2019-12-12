import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'tracker_route_observer.dart';

class TrackerRouteObserverProvider extends Provider<TrackerStackObserver<PageRoute>> {
  TrackerRouteObserverProvider({
    Key key,
    Widget child,
  }) : super(
    create: (context) => TrackerStackObserver<PageRoute>(),
    key: key,
    child: child,
  );

  static TrackerStackObserver<ModalRoute> of(BuildContext context) =>
      Provider.of<TrackerStackObserver<PageRoute>>(
        context,
        listen: false,
      );
}
