import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanflutter/entity/project_list_entity.dart';
import 'package:wanflutter/model/chapters_model.dart';
import 'package:wanflutter/provider/provider_widget.dart';
import 'package:wanflutter/provider/view_state_model.dart';
import 'package:wanflutter/provider/view_state_widget.dart';
import 'package:wanflutter/ui/helper/refresh_helper.dart';


class SubscriptionListPage extends StatefulWidget {
  int id;

  SubscriptionListPage(this.id);

  @override
  State<StatefulWidget> createState() {
    return SubscriptionListState(id);
  }
}

class SubscriptionListState extends State<SubscriptionListPage>with AutomaticKeepAliveClientMixin{
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  int id;
  SubscriptionListState(this.id);

  @override
  Widget build(BuildContext context) {
    return ProviderWidgetOne<ChaptersListModel>(
      modelT: ChaptersListModel(id),
      onModelReady: (chaptersListModel) {
        chaptersListModel.initData();
      },
      build: (context, chaptersListModel, child) {
        return Scaffold(
          body: buildWidget(chaptersListModel),
        );
      },
    );
  }

  Widget buildWidget(ChaptersListModel chaptersListModel) {
    if (chaptersListModel.viewState == ViewState.busy) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (chaptersListModel.viewState == ViewState.error) {
      return ViewStateWidget();
    } else {
      if (chaptersListModel.list.isNotEmpty) {
        return SmartRefresher(
          controller: chaptersListModel.refreshController,
          onLoading: chaptersListModel.loadMore,
          onRefresh: chaptersListModel.refresh,
          footer: RefreshFooter(),
          header: RefreshHeader(),
          enablePullUp: chaptersListModel.list.isNotEmpty,
          child: ListView.builder(
              itemCount: chaptersListModel.list == null
                  ? 0
                  : chaptersListModel.list.length,
              itemBuilder: (BuildContext context, int index) {
                ProjectListDataData item = chaptersListModel.list[index];
                return SubscriptionItemWidget(item);
              }),
        );
      } else {
        return ViewStateWidget(
          message: "暂无数据",
          image: IconData(0xe60f, fontFamily: 'iconfont'),
        );
      }
    }
  }

  Widget SubscriptionItemWidget(ProjectListDataData item) {
    return Card(
      margin: EdgeInsets.only(left: 15, right: 15, top: 10),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(right: 10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      item.title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    IconData(0xe62f, fontFamily: 'iconfont'),
                    color: Colors.blue[100],
                    size: 22,
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top:10),
              child: Text(
                item.niceShareDate,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}
