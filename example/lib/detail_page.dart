import 'package:flutter/material.dart';
import 'package:xm_flutter_tracker/xm_flutter_tracker.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DetailPage> with PageTrackerAware, TrackerPageMixin {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Detail Page',
            ),
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void didPageView() {
    super.didPageView();

    print("tracker pageview detail");
  }

  @override
  void didPageExit() {
    super.didPageExit();

    print("tracker pageExit detail");
  }
}
