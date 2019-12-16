import 'package:flutter/material.dart';
import 'package:xm_flutter_tracker/xm_flutter_tracker.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with PageTrackerAware, TrackerPageMixin {


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
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("detail");
              },
              child: Text(
                '跳转普通页面，产生埋点事件',
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return Container(
                      height: 200,
                      width: 200,
                      color: Colors.amber,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("打开弹窗，不产生埋点事件")
                        ),
                      ),
                    );
                  }
                );
              },
              child: Text(
                '打开弹窗，不产生埋点事件',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("pageview");
              },
              child: Text(
                'PageView页面，产生埋点事件',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("tabview");
              },
              child: Text(
                'TapView页面，产生埋点事件',
              ),
            ),
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void didPageView() {
    super.didPageView();

    print("tracker pageview home");
  }

  @override
  void didPageExit() {
    super.didPageExit();

    print("tracker pageExit home");
  }
}
