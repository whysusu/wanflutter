import 'package:flutter/material.dart';

class EmptyAnimatedSwitcher extends StatelessWidget {
  final bool display;
  final Widget child;

  EmptyAnimatedSwitcher({this.display: true, this.child});

  @override
  Widget build(BuildContext context) {
    return ScaleAnimatedSwitcher(
      child: display ? child : SizedBox.shrink(),
    );
  }
}

class ScaleAnimatedSwitcher extends StatelessWidget {
  final Widget child;

  ScaleAnimatedSwitcher({this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(
        milliseconds: 300,
      ),
      switchInCurve: Curves.elasticOut,
      switchOutCurve: Curves.ease,
      transitionBuilder: (child, animation) => ScaleTransition(
        scale: animation,
        child: child,
      ),
      child: child,
    );
  }
}

class MenuAnimatedSwitcher extends StatelessWidget {
  final bool display;
  final Widget child;

  MenuAnimatedSwitcher({this.display, this.child});

  @override
  Widget build(BuildContext context) {
    return FractionalAnimatedSwitcher(
      child: display ? child : SizedBox.shrink(),
    );
  }
}

class FractionalAnimatedSwitcher extends StatelessWidget {
  final Widget child;

  Tween<Offset>  _tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));

  FractionalAnimatedSwitcher({
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(
        milliseconds: 300,
      ),
      transitionBuilder: (child, animation){
        return SlideTransition(
          position: _tween.animate(animation),
          child: child,
        );
      },
      child: child,
    ) ;
  }


}
