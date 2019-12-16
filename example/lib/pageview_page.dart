import 'package:flutter/material.dart';
import 'package:xm_flutter_tracker/xm_flutter_tracker.dart';

class PageViewPage extends StatefulWidget {
  PageViewPage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PageViewPage> with AutomaticKeepAliveClientMixin<PageViewPage> {

  @override
  bool get wantKeepAlive => true;

  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: PageViewWrapper(
        changeDelegate: PageViewChangeDelegate(pageController),
        pageAmount: 3,
        initialPage: pageController.initialPage,
        child: PageView(
          controller: pageController,
          children: <Widget>[
            PageViewListenerWrapper(
              0,
              onPageView: () {
                print("pageview pageview 0");
              },
              onPageExit: () {
                print("pageview pageexit 0");
              },
              child: Container(
                child: Center(
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed("detail");
                      },
                      child: Text("Page 0 -> detail page")
                  ),
                ),
              ),
            ),
            PageViewListenerWrapper(
              1,
              onPageView: () {
                print("pageview pageview 1");
              },
              onPageExit: () {
                print("pageview pageexit 1");
              },
              child: Container(
                child: Center(
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed("detail");
                      },
                      child: Text("Page 1 -> detail page")
                  ),
                ),
              ),
            ),
            PageViewListenerWrapper(
              2,
              onPageView: () {
                print("pageview pageview 2");
              },
              onPageExit: () {
                print("pageview pageexit 2");
              },
              child: Container(
                child: Center(
                  child: Text("Page 2"),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
