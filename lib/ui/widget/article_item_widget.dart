import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanflutter/entity/article_top_bean_entity.dart';
import 'package:wanflutter/model/home_model.dart';

///首页列表Item布局
class ArticleItemWidget extends StatelessWidget {
  ArticleTopBeanData item;
  bool top;

  ArticleItemWidget(this.item, this.top);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeModel>(
      builder: (_, homeModel, __) {
        return Card(
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        item.title,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Icon(
//                        Icons.favorite_border,
                        IconData(0xe62f, fontFamily: 'iconfont'),
                        color: Colors.blue[300],
                        size: 22,
                      ),
                    ),
                  ],
                ),
                tags(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    explainText("分类：", color: Colors.grey),
                    explainText(
                      item.superChapterName + "/" + item.chapterName,
                    ),
                    explainText("   时间：", color: Colors.grey),
                    explainText(
                      item.niceDate,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    item.author.isEmpty
                        ? explainText("分享人：",
                            size: 14, fontWeight: FontWeight.w600)
                        : explainText("作者：",
                            size: 14, fontWeight: FontWeight.w600),
                    item.author.isEmpty
                        ? explainText(item.shareUser,
                            size: 14, fontWeight: FontWeight.w600)
                        : explainText(item.author,
                            size: 14, fontWeight: FontWeight.w600),
                  ],
                ),
              ],
            ),
            padding: EdgeInsets.all(10),
          ),
          margin: EdgeInsets.only(left: 15, right: 15, top: 10),
          color: top ? Colors.blue[50] : Colors.white,
        );
      },
    );
  }

  Widget tags() {
    var dateNow = new DateTime.now(); //现在的时间
    var now = dateNow.millisecondsSinceEpoch; //转换为时间戳
    bool isToday = (now - item.publishTime) / 1000 / 60 / 60 <= 24;
    if (top || isToday || (item.tags != null && item.tags.length > 0)) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          top ? TagText("置顶") : Text(""),
          newTag(isToday), //标签"新"
          Expanded(
            flex: 1,
            child: TagList(),
          ),
        ],
      );
    } else {
      return Container(
        height: 0,
        child: Text(""),
      );
    }
  }

  Widget newTag(bool isToday) {
    if (isToday) {
      return TagText("新");
    } else {
      return Container(
        height: 0,
        child: Text(""),
      );
    }
  }

  Widget TagText(String text) {
    return Container(
        height: 18,
        padding: EdgeInsets.only(left: 5, right: 5,top: 0,bottom: 1.5),
        margin: EdgeInsets.only(top: 5, right: 5),
        alignment: Alignment.center,
        decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(2)),
            border: new Border.all(width: 1, color: Colors.red[500])),
        child: Text(
          text,
          style: TextStyle(fontSize: 12, color: Colors.red[500]),
          textAlign: TextAlign.center,
        ));
  }

  Widget TagList() {
    if (item.tags != null && item.tags.length > 0) {
      return new SizedBox(
        height: 23,
        child: ListView.builder(
            itemCount: item.tags.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.only(left: 5, right: 5,bottom: 1.5),
                margin: EdgeInsets.only(
                  top: 5,
                ),
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    border: new Border.all(width: 1, color: Colors.blue[400])),
                child: Text(
                  item.tags[index].name,
                  style: TextStyle(fontSize: 12, color: Colors.blue[400]),
                  textAlign: TextAlign.center,
                ),
              );
            }),
      );
    } else {
      return Text("");
    }
  }

  Widget explainText(String text,
      {double size = 12, color = Colors.black, fontWeight = FontWeight.normal}) {
    return Container(
        height: 22,
        padding: EdgeInsets.all(0),
        alignment: Alignment.bottomLeft,
        child: Text(
          text,
          style:
              TextStyle(fontSize: size, color: color, fontWeight: fontWeight),
        ));
  }
}
