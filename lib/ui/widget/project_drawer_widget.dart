import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanflutter/model/project_model.dart';
import 'package:wanflutter/ui/page/project_page.dart';

class DrawerWidget extends StatelessWidget {
  ProjectListModel projectListModel;
  ProjectState projectState;

  DrawerWidget(this.projectListModel, this.projectState);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 3 / 4, //获取屏幕宽度
      color: Colors.white,
      child: Consumer<ProjectTreeModel>(builder: (_, projectTreeModel, __) {
        return Column(
          children: <Widget>[
            Container(
              height: 60,
              padding: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              color: Colors.blue[300],
              child: Text(
                "项目分类",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            Expanded(
              flex: 1,
              child: GridView.builder(
                  padding: EdgeInsets.all(
                    10,
                  ),
                  itemCount: projectTreeModel.list.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, //一行几个
                    childAspectRatio: 10, //宽高比
                    mainAxisSpacing: 5, // 垂直item间距
//                    crossAxisSpacing: 8//水平item间距
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      ///点击事件
                      onTap: () {
                        projectListModel.cid = projectTreeModel.list[index].id;
                        projectListModel.initData();
                        for (int i = 0;
                            i < (projectTreeModel.list.length);
                            i++) {
                          if (index == i) {
                            projectState.title = projectTreeModel.list[i].name;
                            projectTreeModel.list[i].visible = 0;
                          } else {
                            projectTreeModel.list[i].visible = 1;
                          }
                        }
                        projectTreeModel.notifyListeners();
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
//                              projectTreeModel.list[index].visible == 0
//                                  ? Icons.bookmark
//                                  : Icons.bookmark_border,
                              IconData(0xe616, fontFamily: 'iconfont'),
                              color: projectTreeModel.list[index].visible == 0
                                  ? Colors.blue[300]
                                  : Colors.grey[500],
                              size: 15),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(projectTreeModel.list[index].name,
                                style: TextStyle(
                                    fontSize: 15,
                                    color:
                                        projectTreeModel.list[index].visible ==
                                                0
                                            ? Colors.blue[300]
                                            : Colors.grey[500])),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ],
        );
      }),
    );
  }
}
