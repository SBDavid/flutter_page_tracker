import 'package:flutter/material.dart';
import 'package:xm_flutter_tracker/xm_flutter_tracker.dart';
import 'dart:async';

class TabViewPage extends StatefulWidget {
  TabViewPage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _State createState() => _State();
}

class _State extends State<TabViewPage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<TabViewPage> {

  @override
  bool get wantKeepAlive => true;

  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 3, vsync: this);
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
                  controller: tabController,
                  children: <Widget>[
                    Builder(
                      builder: (_) {

                        return PageViewListenerWrapper(
                          0,
                          onPageView: () {
                            print("tabbar pageview 0");
                          },
                          onPageExit: () {
                            print("tabbar pageexit 0");
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
                    Tab(text: "tab1",),
                    Tab(text: "tab2",),
                    Tab(text: "tab3",),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
