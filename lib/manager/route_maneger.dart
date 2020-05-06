import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanflutter/ui/page/SplashPage.dart';
import 'package:wanflutter/ui/page/home_page.dart';
import 'package:wanflutter/ui/widget/page_route_anim.dart';

class RouteName {
  static const String splash = "splash";
  static const String tab = "/";
}

class Router {
  static Route<dynamic> generateRouter(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return NoAnimRouteBuilder(SplashPage());
      case RouteName.tab:
        return NoAnimRouteBuilder(MyHomePage());
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
