import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanflutter/entity/project_list_entity.dart';
import 'package:wanflutter/model/project_model.dart';
import 'package:wanflutter/provider/provider_widget.dart';
import 'package:wanflutter/provider/view_state_model.dart';
import 'package:wanflutter/provider/view_state_widget.dart';
import 'package:wanflutter/ui/helper/refresh_helper.dart';
import 'package:wanflutter/ui/widget/project_drawer_widget.dart';
import 'package:wanflutter/ui/widget/project_list_item_widget.dart';

///项目
class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ProjectState();
  }
}

class ProjectState extends State<ProjectPage> {
  String title = "完整项目";

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<ProjectTreeModel, ProjectListModel>(
      model1: ProjectTreeModel(),
      model2: ProjectListModel(294), //294为全部项目
      onModelReady: (projectTreeModel, projectListModel) {
        projectTreeModel.initData();
        projectListModel.initData();
      },
      builder: (context, projectTreeModel, projectListModel, child) {
        return Scaffold(
          body: ProjectList(),
          appBar: AppBar(
            title: Text(
              title,
              style: TextStyle(fontSize: 20, color: Colors.blue[300]),
            ),
            centerTitle: true,
          ),
          drawer: DrawerWidget(projectListModel, this),
        );
      },
    );
  }
}

class ProjectList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProjectListModel projectListModel = Provider.of(context);
    if (projectListModel.viewState == ViewState.busy) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (projectListModel.viewState == ViewState.error) {
      return ViewStateWidget();
    } else {
      if (projectListModel.list.isNotEmpty) {
        return SmartRefresher(
          controller: projectListModel.refreshController,
          header: RefreshHeader(),
          footer: RefreshFooter(),
          onRefresh: projectListModel.refresh,
          onLoading: projectListModel.loadMore,
          enablePullUp: projectListModel.list.isNotEmpty,
          child: ListView.builder(
              itemCount: projectListModel.list == null
                  ? 0
                  : projectListModel.list.length,
              itemBuilder: (BuildContext context, int index) {
                ProjectListDataData item = projectListModel.list[index];
                return ProjectListWidget(item);
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
}
