import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BezierCircleHeader(
        circleColor: Colors.blue[200],
        enableChildOverflow: false,
        bezierColor: Colors.blue[50],
        rectHeight: 50);
  }
}

class RefreshFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClassicFooter(
      failedText: "加载失败",
      idleText: "上拉加载更多",
      loadingText: "加载中...",
      noDataText: "没有更多数据了",
    );
  }
}
