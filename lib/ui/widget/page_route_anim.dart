import 'package:flutter/material.dart';

class NoAnimRouteBuilder extends PageRouteBuilder {
  final Widget page;
  NoAnimRouteBuilder(this.page)
      : super(
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) {
              return page;
            },
            transitionDuration: Duration(milliseconds: 0),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return child;
            });
}
