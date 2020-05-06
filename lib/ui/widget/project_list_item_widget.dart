import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanflutter/entity/project_list_entity.dart';

class ProjectListWidget extends StatelessWidget {
  ProjectListDataData projectListDataData;
  ProjectListWidget(this.projectListDataData);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(right: 10 ),
                height:
                     MediaQuery.of(context).size.width * 2 / 5,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          projectListDataData.title,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          projectListDataData.desc,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        //公众号不展示作者
                        projectListDataData.niceDate +"  作者: " + projectListDataData.author,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //公众号不展示右侧图片
            Container(
              width: MediaQuery.of(context).size.width / 4.5,
              height: MediaQuery.of(context).size.width * 2 / 5,
              child: Stack(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: projectListDataData.envelopePic,
                    placeholder: (context, url) {
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Icon(Icons.error);
                    },
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.black87, Colors.white12],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
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
            ),
          ],
        ),
      ),
      margin: EdgeInsets.only(left: 15, right: 15, top: 10),
      color: Colors.white,
    );
  }
}
