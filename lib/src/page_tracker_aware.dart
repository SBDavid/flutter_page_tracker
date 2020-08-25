abstract class PageTrackerAware {

  // 判断当前路由是否是被浏览的路由
  bool isActive = false;

  void didPageView() {
    isActive = true;
  }

  void didPageExit() {
    isActive = false;
  }

  void didPageLoaded(Duration totalTime, Duration buildTime, Duration requestTime, Duration renderTime) { }

}