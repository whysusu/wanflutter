import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanflutter/model/chapters_model.dart';
import 'package:wanflutter/provider/provider_widget.dart';
import 'package:wanflutter/provider/view_state_model.dart';
import 'package:wanflutter/provider/view_state_widget.dart';
import 'package:wanflutter/ui/page/subscription_list_page.dart';
import 'package:wanflutter/ui/widget/animated_provider.dart';

class SubscriptionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new SubscriptionState();
  }
}

class SubscriptionState extends State<SubscriptionPage>
    with AutomaticKeepAliveClientMixin {
  int index = 0;

  @override
  bool get wantKeepAlive => true;
  bool menuShow = false;
  TabController tabController;

  @override
  Widget build(BuildContext context) {
    return ProviderWidgetOne<ChaptersModel>(
      modelT: ChaptersModel(),
      onModelReady: (chaptersModel) {
        chaptersModel.initData();
      },
      build: (context, chaptersModel, child) {
        return Scaffold(
          body: _BodyWidget(chaptersModel),
        );
      },
    );
  }

  Widget _BodyWidget(ChaptersModel chaptersModel) {
    if (chaptersModel.viewState == ViewState.busy) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (chaptersModel.viewState == ViewState.error) {
      return ViewStateWidget();
    } else {
      return chaptersModel.list.isNotEmpty
          ? DefaultTabController(
              length: chaptersModel.list.length,
              child: Builder(
                builder: (context) {
                  if (tabController == null) {
                    tabController = DefaultTabController.of(context);
                    tabController.addListener(() {
                      index = tabController.index;
                      refreshModelData(chaptersModel, index);
                      menuShow=false;
                      chaptersModel.notifyListeners();
                    });
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 85,
                              padding: EdgeInsets.only(bottom: 2),
                              alignment: Alignment.bottomLeft,
                              color: Colors.blue[300],
                              child: TabBar(
                                  labelColor: Colors.white,
                                  unselectedLabelColor: Colors.white60,
                                  indicatorColor: Colors.white,
                                  indicatorWeight: 2,
                                  isScrollable: true,
                                  labelStyle: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600),
                                  unselectedLabelStyle: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                  tabs: List.generate(
                                      chaptersModel.list.length,
                                      (index) => Tab(
                                          text:
                                              chaptersModel.list[index].name))),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              menuShow = !menuShow;
                              chaptersModel.notifyListeners();
                            },
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              padding: EdgeInsets.only(bottom: 15),
                              width: 40,
                              height: 85,
                              color: Colors.blue[300],
                              child: Icon(
                                Icons.more_vert,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        flex: 1,
                        child: Stack(
                          children: <Widget>[
                            TabBarView(
                              children: List.generate(
                                  chaptersModel.list.length,
                                  (index) => SubscriptionListPage(
                                      chaptersModel.list[index].id)),
                            ),
                            MenuAnimatedSwitcher(
                                display: menuShow,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        color: Colors.blue[300],
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: ListView.builder(
                                            padding: EdgeInsets.only(top: 10),
                                            itemCount:
                                                chaptersModel.list.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return InkWell(
                                                onTap: () {
                                                  //点击跳转至相应的tab
                                                  menuShow = false;
                                                  tabController
                                                      .animateTo(index);
                                                  refreshModelData(chaptersModel, index);
                                                  chaptersModel
                                                      .notifyListeners();
                                                },
                                                child: Container(
                                                  height: 28,
                                                  child: Text(
                                                    chaptersModel
                                                        .list[index].name,
                                                    style: chaptersModel
                                                                .list[index]
                                                                .visible ==
                                                            0
                                                        ? TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold)
                                                        : TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: GestureDetector(
                                        onTap: () {
                                          menuShow = false;
                                          chaptersModel.notifyListeners();
                                        },
                                        child: Container(
                                          width: double.maxFinite,
                                          height: double.maxFinite,
                                          child: Text(""),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          : ViewStateWidget(
              message: "暂无数据",
              image: IconData(0xe60f, fontFamily: 'iconfont'),
            );
    }
  }

  ///tab选项刷新，用于拉下选项选中状态选择
  void refreshModelData(ChaptersModel chaptersModel, int index) {
      for (int i = 0;
    i < (chaptersModel.list.length);
    i++) {
      if (index == i) {
        chaptersModel.list[i].visible = 0;
      } else {
        chaptersModel.list[i].visible = 1;
      }
    }
  }
}
