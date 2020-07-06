import 'package:flutter/material.dart';
import 'package:flutter_page_tracker/flutter_page_tracker.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DetailPage> with PageTrackerAware, TrackerPageMixin, PageLoadMixin {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("PageRoute Demo"),
      ),
      body: Container(
        color: Colors.blue,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "When a PageRoute is added to navigation stack, a PageExit event "
                  "will be trigged on previous route and you can override didPageExit method"
                  "by using TrackerPageMixin. ",
            ),
            Container(
              height: 10,
            ),
            Text(
              "After PageExit event, a PageView event will be trigged on current route.",
            ),
            Container(
              height: 10,
            ),
            Text("Vice versa for the pop of PageRoute."),
            Container(
              height: 50,
            ),
            Text("You can see 'PageExit: PageRoute' and 'PageView: PageRoute' in the "
                "console panel.")
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void didPageView() {
    super.didPageView();

    print("PageView: PageRoute");
  }

  @override
  void didPageExit() {
    super.didPageExit();

    print("PageExit: PageRoute");
  }

  @override
  void didPageLoaded(_, __, ___, ____) {
    // DoSomething
  }
}
