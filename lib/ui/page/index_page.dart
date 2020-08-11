import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanflutter/entity/article_top_bean_entity.dart';
import 'package:wanflutter/entity/banner_bean_entity.dart';
import 'package:wanflutter/model/home_model.dart';
import 'package:wanflutter/provider/provider_widget.dart';
import 'package:wanflutter/provider/view_state_model.dart';
import 'package:wanflutter/provider/view_state_widget.dart';
import 'package:wanflutter/ui/helper/refresh_helper.dart';
import 'package:wanflutter/ui/widget/animated_provider.dart';
import 'package:wanflutter/ui/widget/article_item_widget.dart';
import 'package:wanflutter/ui/widget/banner_widget.dart';
import 'package:wanflutter/view_model/scroll_controller_model.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new IndexState();
  }
}

class IndexState extends State<IndexPage> {
  BannerBeanEntity bannerBeanEntity;

  @override
  Widget build(BuildContext context) {
//    super.build(context);
    /// iPhoneX 头部适配
    double bannerHeight = 120 + MediaQuery.of(context).padding.top;
    return ProviderWidget<HomeModel, TopToTopModel>(
      model1: HomeModel(),
      model2: TopToTopModel(PrimaryScrollController.of(context),
          height: bannerHeight - kToolbarHeight),
      onModelReady: (homeModel, topToTopModel) {
        homeModel.initData();
        topToTopModel.init();
      },
      builder: (context, homeModel, topToTopModel, child) {
        return Scaffold(
          body: MediaQuery.removePadding(
            context: context,
            removeTop: false,
            child: Builder(
              builder: (_) {
                if (homeModel.viewState == ViewState.error) {
                  return ViewStateWidget(onPressed: homeModel.initData);
                }
                return SmartRefresher(
                  enableTwoLevel: false,
                  controller: homeModel.refreshController,
                  header: RefreshHeader(),
                  footer: RefreshFooter(),
//                  header: ClassicHeader(
//                    idleText: "下拉可刷新",
//                    releaseText: "释放可刷新",
//                    refreshingText: "刷新中",
//                    completeText: "刷新完成",
//                  ),

                  onRefresh: homeModel.refresh,
                  onLoading: homeModel.loadMore,
                  enablePullUp: homeModel.list.isNotEmpty,
                  child: CustomScrollView(
                    controller: topToTopModel.scrollController,
                    slivers: <Widget>[
                      //这里的控件必须是slivers系列的控件，所以如果你想将一个普通组件塞进CustomScrollView，那么务必将该组件用SliverToBoxAdapter包裹。
//                      SliverToBoxAdapter(),
                      SliverAppBar(
                        actions: <Widget>[
                          EmptyAnimatedSwitcher(
                            display: topToTopModel.showTopBtn,
                            child: IconButton(
                              icon: Icon(
                                IconData(0xe634, fontFamily: 'iconfont'),
                                color: Colors.blue[300],
                              ),
                              onPressed: () {
                                Fluttertoast.showToast(msg: "搜索");
                              },
                            ),
                          )
                        ],
                        flexibleSpace: FlexibleSpaceBar(
                          background: BannerWidget(),
                          centerTitle: true,
                          title: GestureDetector(
                            onDoubleTap: topToTopModel.scrollToTop,
                            child: EmptyAnimatedSwitcher(
                              display: topToTopModel.showTopBtn,
                              child: Text(
                                "FunAndroid",
                                style: TextStyle(
                                    fontSize: 26, color: Colors.blue[300]),
                              ),
                            ),
                          ),
                        ),
                        expandedHeight: bannerHeight,
                        pinned: true,
                      ),
                      HomeTopArticleList(),
                      HomeArticleList(),
                    ],
                  ),
                );
              },
            ),
          ),
          floatingActionButton: EmptyAnimatedSwitcher(
            display: topToTopModel.showTopBtn,
            child: FloatingActionButton(
              backgroundColor: Colors.blue[300],
              onPressed: () {
                topToTopModel.scrollToTop();
              },
              child: Icon(
                IconData(0xe62e, fontFamily: 'iconfont'),
              ),
            ),
          ),
        );
      },
    );
  }
}

///置顶列表
class HomeTopArticleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeModel homeModel = Provider.of(context);
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      ArticleTopBeanData item = homeModel.article[index];
      return ArticleItemWidget(item, true, index);
    }, childCount: homeModel.article == null ? 0 : homeModel.article.length));
  }
}

///首页底部列表
class HomeArticleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeModel homeModel = Provider.of(context);
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      ArticleTopBeanData item = homeModel.list[index];
      return ArticleItemWidget(item, false, index);
    }, childCount: homeModel.list == null ? 0 : homeModel.list.length));
  }
}
