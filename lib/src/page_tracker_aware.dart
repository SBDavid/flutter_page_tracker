abstract class PageTrackerAware {

  void didPageView() { }

  void didPageExit() { }

  void didPageLoaded(Duration totalTime, Duration buildTime, Duration requestTime, Duration renderTime) { }

}