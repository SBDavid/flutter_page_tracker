import 'package:flutter/material.dart';
import 'package:flutter_page_tracker/flutter_page_tracker.dart';

class PageViewWrapperPage extends StatefulWidget {
  PageViewWrapperPage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PageViewWrapperPage> with AutomaticKeepAliveClientMixin<PageViewWrapperPage> {

  @override
  bool get wantKeepAlive => true;

  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  Widget _buildPage(int index, int color) {
    return PageViewListenerWrapper(
      index,
      onPageView: () {
        print("pageview $index");
      },
      onPageExit: () {
        print("pageexit $index");
      },
      onPageLoaded: (_, __, ___, ____) {
      },
      child: SafeArea(
        child: Container(
          color: Colors.blue[color],
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Page $index", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),),
                    Container(height: 50,),
                    Text("For PageView and TabView, PageView and PageExit will be trigged when you "
                    "switch between views."),
                    Container(height: 15,),
                    Text("You can see 'PageView $index' and 'PageExit $index' in the console."),
                    Container(height: 15,),
                    Text("PageExit event will also be trigged when you push a new PageRoute on current stack. "
                        "Try it by clicking the buttom show below. "),
                    Container(height: 15,),
                    Text("When you pop a PageRoute, the previous "
                        "focused page will receive a PageView event. "),
                    Container(height: 50,),
                    Text("Try slide", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600))
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("detail");
                },
                child: Container(
                  color: Colors.amber,
                  height: 50,
                  child: Center(
                    child: Text("Go to another PageRoute"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
            _buildPage(0, 300),
            _buildPage(1, 600),
            _buildPage(2, 900),
          ],
        ),
      )
    );
  }
}
