import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wanflutter/ui/page/personal_center_page.dart';
import 'package:wanflutter/ui/page/project_page.dart';
import 'package:wanflutter/ui/page/subscription_page.dart';
import 'package:wanflutter/ui/page/system_page.dart';
import 'package:wanflutter/utils/constant.dart';

import 'index_page.dart';

///首页框架
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int indexPage = 0;
  var appBarTitles = ["首页", "项目", "公众号", "体系", "我的"];
  var tabeIcons;
  var pageList = [
    new IndexPage(),
    new ProjectPage(),
    new SubscriptionPage(),
    new SystemPage(),
    new PersonalCenterPage(),
  ];

  @override
  Widget build(BuildContext context) {
    initData();
    return Scaffold(
      //使用IndexedStack来保持每个tab的页面状态
      body: IndexedStack(
        index: indexPage,
        children: pageList,
      ),
//      pageList[indexPage],
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: getTab(0),
                label: appBarTitles[0],
                backgroundColor: getTabTitleBg(0)),
            new BottomNavigationBarItem(
                icon: getTab(1),
                label: appBarTitles[1],
                backgroundColor: getTabTitleBg(1)),
            new BottomNavigationBarItem(
                icon: getTab(2),
                label: appBarTitles[2],
                backgroundColor: getTabTitleBg(2)),
            new BottomNavigationBarItem(
                icon: getTab(3),
                label: appBarTitles[3],
                backgroundColor: getTabTitleBg(3)),
            new BottomNavigationBarItem(
                icon: getTab(4),
                label: appBarTitles[4],
                backgroundColor: getTabTitleBg(4))
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: indexPage,
          iconSize: 24,
          onTap: (index) {
            setState(() {
              indexPage = index;
            });
          }),
    );
  }

  void initData() {
    tabeIcons = [
      [
        getTabIcon(
            IconData(0xe604, fontFamily: 'iconfont'), Constant.mainColor),
        getTabIcon(IconData(0xe604, fontFamily: 'iconfont'), Colors.grey)
      ],
      [
        getTabIcon(
            IconData(0xe66a, fontFamily: 'iconfont'), Constant.mainColor),
        getTabIcon(IconData(0xe66a, fontFamily: 'iconfont'), Colors.grey)
      ],
      [
        getTabIcon(
            IconData(0xe66b, fontFamily: 'iconfont'), Constant.mainColor),
        getTabIcon(IconData(0xe66b, fontFamily: 'iconfont'), Colors.grey)
      ],
      [
        getTabIcon(
            IconData(0xe606, fontFamily: 'iconfont'), Constant.mainColor),
        getTabIcon(IconData(0xe606, fontFamily: 'iconfont'), Colors.grey)
      ],
      [
        getTabIcon(
            IconData(0xe603, fontFamily: 'iconfont'), Constant.mainColor),
        getTabIcon(IconData(0xe603, fontFamily: 'iconfont'), Colors.grey)
      ],
    ];
  }

  getTabIcon(IconData iconData, Color color) {
    return new Icon(
      iconData,
      color: color,
      size: 24,
    );
  }

  getTab(int position) {
    if (position == indexPage) {
      return tabeIcons[position][0];
    } else {
      return tabeIcons[position][1];
    }
  }

  getTabTitleBg(int position) {
    if (position == indexPage) {
      return Constant.mainColor;
    } else {
      return Colors.grey;
    }
  }
}
