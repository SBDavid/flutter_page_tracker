import 'package:flutter/widgets.dart';

class PageLoadProvider extends InheritedWidget {

  final String env;

  PageLoadProvider({
    Key key,
    this.env = 'pro',
    @required Widget child,
  }): super(key: key, child: child);

  @override
  bool updateShouldNotify(PageLoadProvider oldWidget) {
    return env != oldWidget.env;
  }

  static String of(BuildContext context) {
    try {
      return context.dependOnInheritedWidgetOfExactType<PageLoadProvider>().env;
    } catch (err) {
      return "pro";
    }
  }
}