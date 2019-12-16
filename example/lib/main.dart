import 'package:flutter/material.dart';
import 'package:flutter_page_tracker/flutter_page_tracker.dart';

// 页面
import 'home_page.dart';
import 'detail_page.dart';
import 'pageview_page.dart';
import 'tabview_page.dart';

void main() => runApp(
  TrackerRouteObserverProvider(
    child: MyApp(),
  )
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: [TrackerRouteObserverProvider.of(context)],
      home: MyHomePage(title: 'Flutter代码埋点Demo'),
      routes: {
        "home": (_) => MyHomePage(title: 'Flutter代码埋点Demo'),
        "detail": (_) => DetailPage(title: 'Flutter代码埋点Demo'),
        "pageview": (_) => PageViewPage(title: 'Flutter代码埋点Demo'),
        "tabview": (_) => TabViewPage(title: 'Flutter代码埋点Demo'),
      },
    );
  }
}
