## 使用

### 安装
```yaml
dependencies:
  xm_flutter_tracker: ^1.0.0
```


## 原理篇
###  1.概述

页面的埋点追踪通常处于业务开发的最后一环，留给埋点的开发时间通常并不充裕，但是埋点数据对于后期的产品调整有重要的意义，所以一个稳定高效的埋点框架是非常重要的。

### 2. 我们期望埋点框架所具备的功能

#### 2.1 PageView，PageExit事件
我们期望当调用`Navigator.of(context).pushNamed("XXX Page");`时，首先对之前的页面发送`PageExit`，然后对当前页面发送`PageView`事件。当调用`Navigator.of(context).pop();`时则，首先发送当前页面的`PageExit`事件，再发送之前页面的`PageView`事件。

我们首先想到的是使用[RouteObserver](https://github.com/flutter/flutter/blob/c06bf6503a8b6690b2740a7101852fcc8f133057/packages/flutter/lib/src/widgets/routes.dart#L1426)，但是`PageView`和`PageExit`发送的顺序相反。并且[PopupRoute](https://github.com/flutter/flutter/blob/c06bf6503a8b6690b2740a7101852fcc8f133057/packages/flutter/lib/src/widgets/routes.dart#L1510)类型的路由会影响前一个页面的埋点事件发送，例如我们入栈的顺序是 A页面 -> A页面上的弹窗 -> B页面，但是在这个过程中A页面的`PageExit`事件没有发送。

所以我们必须自己管理路由栈，这样判断不同路由的类型，并控制事件的顺序。详细实现方案在后面展开。

#### 2.2 TagView组件于PageView组件
这两个组件虽然与Flutter的路由无关，但是在产品经理眼中它们任属于页面。并且当Tab发生首次曝光和切换的时候我们都需要发送埋点事件。

例如当Tab页A首次曝光时，我们首先发送上一个页面的`PageExit`事件，然后发送TabA的`PageView`事件。当我们从TabA切换到TabB的时候，先发送TabA的`PageExit`事件，然后发送TabB的`PageView`事件。当我们push一个新的路由时，需要发送TabB的`PageExit`事件。

这套流程需要Tab页和普通页面之间通过事件机制来交互，如果直接把这套机制搬到业务代码中，那么业务代码中就会包含大量与业务无关并且重复的代码。详细的抽象方案见后文。

### 3. 解决这些问题

#### 3.1 解决PageView，PageExit的顺序问题
[RouteObserver](https://github.com/flutter/flutter/blob/c06bf6503a8b6690b2740a7101852fcc8f133057/packages/flutter/lib/src/widgets/routes.dart#L1426)给了我们一个不错的起点，我们重写其中的`didPop`和`didPush`方法就并调整事件发送的顺序就可以解决这个问题。详见[TrackerStackObserver](https://github.com/SBDavid/flutter_tracker/blob/4fb20ad03fd63300f5b33a92fc38fcd4f7a8fa45/lib/src/tracker_route_observer.dart#L59)，在`didpop`方法中我们先触发上一个路由的`PageExit`事件，然后再触发当前路由的`PageView`事件。

#### 3.2 避免弹窗的干扰（例如Dialog）
在[RouteObserver.didPop(Route<dynamic> route, Route<dynamic> previousRoute)](https://github.com/flutter/flutter/blob/c06bf6503a8b6690b2740a7101852fcc8f133057/packages/flutter/lib/src/widgets/routes.dart#L1456)中，我们可以通过previousRoute找到上一个路由，并更具它来发送上一个路由的PageView事件。但是如果上一个路由是`Dialog`，就会造成错误，因为我们实际想要的是包含这个`Dialog`的路由。

要解决这个问题我们必须自己维护一个路由栈，这样当`didPop`触发时我们就可以找到真正的上一个路由。请参考这一段[代码](https://github.com/SBDavid/flutter_tracker/blob/4fb20ad03fd63300f5b33a92fc38fcd4f7a8fa45/lib/src/tracker_route_observer.dart#L36)，这里的`routes`是当前的路由栈。

#### 3.3 如何上报TabView中的埋点事件，并和其它页面串联起来
这个问题可以分解为两个小问题：
- 1. 如何把TabView页面和普通的路由进行串联？
- 2. 当Tab发生切换时如何发送埋点事件？

为了解决这两个问题，我们需要一个容器来管理tab页面的状态并且承载事件转发的任务。详见下图:
![管理TabView中的事件](./tabview_event.jpg)。

其中TabsWrapper会监听来自Flutter的路由事件，并转发给当前曝光的Tab，这就可以解决了问题一。

同时TabsWrappe也会包含一个`TabController`和上一个被打开的Tab索引，TabsWrappe会监听来自`TabController`的onChange(index)事件，并把事件转发给对应的tab，这就解决了问题二。
