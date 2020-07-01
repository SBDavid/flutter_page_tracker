## [0.0.1] - first publish
## [1.0.0] - add doc
## [1.0.1] - 完善文档
## [1.0.2] - 修正文档中的错误
## [1.0.3] - 添加图片
## [1.0.4] - 添加图片
## [1.1.0] - 支持在TabView中嵌套PageView
## [1.1.1] - - 修改provider版本到3.2.0
## [1.2.0] - 支持弹窗埋点
## [1.2.1] - bugfix: 弹窗埋点可以不传didPageView/didPageExit
## [1.2.2] - 升级demo和文档
## [1.2.3] - 更具pub.dev的提示修改文档和代码
## [2.0.0] - 去除对provider的依赖，并支持最新版本flutter1.9.1
## [2.0.1] - 修改文档，增加flutter_sliver_tracker的外链
## [2.0.2] - 修改文档，增加flutter_sliver_tracker的图片
## [2.1.0] - PageView/TabView推荐直接使用mixin，但是StatelessWidget只能使用Wrapper
## [2.1.1] - bugfix: 使用PageViewListenerMixin上的of发放
## [2.1.2] - bugfix: tab曝光埋点使用asBroadcastStream，支持多次事件绑定
## [2.1.3] - bugfix: 控制数据的范围
## [2.1.4] - bugfix: 在生产环境不抛出异常
## [2.1.5] - readme: 添加文档，绑定RouteObserver
## [2.1.6] - readme: 弹窗埋点demo修改
## [2.1.7] - bugfix: PageView组件，应该在首次注册回调事件的时候触发首次页面曝光。这样即使PageView组件随着焦点离开被销毁，也能发页面曝光事件
## [2.1.8] - bugfix: 在dispose中捕获异常
## [2.2.0] - feature: 统计页面加载时长
## [2.2.1] - bugfix: rebuildStartTime