import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanflutter/manager/route_maneger.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController animateContorller;

  @override
  void initState() {
    animateContorller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    animateContorller.forward();
    super.initState();
  }

  @override
  void dispose() {
    animateContorller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: new Center(
        child: AnimationCountDown(
          context: context,
          animation: StepTween(begin: 3, end: 0).animate(animateContorller),
        ),
      ),
    );
  }
}

class AnimationCountDown extends AnimatedWidget {
  final Animation<int> animation;

  AnimationCountDown({key, this.animation, context})
      : super(key: key, listenable: animation) {
    this.animation.addStatusListener((states) {
      if (states == AnimationStatus.completed) {
        Navigator.of(context).pushReplacementNamed(RouteName.tab);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var value = animation.value + 1;
    return new Center(child: Text(value == 0 ? "" : "$value秒后跳转到首页"));
  }
}
