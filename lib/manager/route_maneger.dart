import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanflutter/entity/article_top_bean_entity.dart';
import 'package:wanflutter/entity/project_list_entity.dart';
import 'package:wanflutter/ui/page/SplashPage.dart';
import 'package:wanflutter/ui/page/article_detail_page.dart';
import 'package:wanflutter/ui/page/home_page.dart';
import 'package:wanflutter/ui/page/projec_detail_page.dart';
import 'package:wanflutter/ui/widget/page_route_anim.dart';

class RouteName {
  static const String splash = "splash";
  static const String tab = "/";
  static const String articleDetail = "articleDetail";
  static const String projectDetail = "projectDetail";
}

class Router1 {
  static Route<dynamic> generateRouter(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return NoAnimRouteBuilder(SplashPage());
      case RouteName.tab:
        return NoAnimRouteBuilder(MyHomePage());
      case RouteName.articleDetail:
        var article = settings.arguments as ArticleTopBeanData;
        return CupertinoPageRoute(
            builder: (_) => ArticleDetailPage(article: article));

      case RouteName.projectDetail:
        var article = settings.arguments as ProjectListDataData;
        return CupertinoPageRoute(
            builder: (_) => ProjectDetailPage(projectDetail: article));
      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
