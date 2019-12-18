import 'package:flutter/material.dart';
import 'package:flutter_page_tracker/flutter_page_tracker.dart';

import 'pageview_page.dart';

class PageviewInTabviewPage extends StatefulWidget {
  PageviewInTabviewPage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _State createState() => _State();
}

class _State extends State<PageviewInTabviewPage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<PageviewInTabviewPage> {

  @override
  bool get wantKeepAlive => true;

  TabController tabController;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              PageViewWrapper(
                pageAmount: 3,
                initialPage: 0,
                changeDelegate: TabViewChangeDelegate(tabController),
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: <Widget>[
                    Builder(
                      builder: (BuildContext context) {

                        return PageViewListenerWrapper(
                          0,
                          onPageView: () {
                            // print("tabbar pageview 0");
                          },
                          onPageExit: () {
                            // print("tabbar pageexit 0");
                          },
                          child: PageViewWrapper(
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
                                    color: Colors.pink,
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
                                    color: Colors.pink,
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
                                    color: Colors.pink,
                                    child: Center(
                                      child: Text("Page 2"),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        );
                      },
                    ),
                    Builder(
                      builder: (_) {

                        return PageViewListenerWrapper(
                          1,
                          onPageView: () {
                            print("tabbar pageview 1");
                          },
                          onPageExit: () {
                            print("tabbar pageexit 1");
                          },
                          child: Container(
                            color: Colors.amber,
                            child: Center(
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed("detail");
                                  },
                                  child: Text("Page 1 -> detail page")
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Builder(
                      builder: (_) {

                        return PageViewListenerWrapper(
                          2,
                          onPageView: () {
                            print("tabbar pageview 2");
                          },
                          onPageExit: () {
                            print("tabbar pageexit 2");
                          },
                          child: Container(
                            color: Colors.amber,
                            child: Center(
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed("detail");
                                  },
                                  child: Text("Page 1 -> detail page")
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: TabBar(
                  controller: tabController,
                  tabs: <Widget>[
                    Tab(text: "tab11",),
                    Tab(text: "tab22",),
                    Tab(text: "tab33",),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
