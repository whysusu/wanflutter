import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewStateWidget extends StatelessWidget {
  final String message;
  final IconData image;
  final Widget btnText;
  final VoidCallback onPressed;

  ViewStateWidget({
    Key key,
    this.image,
    this.message,
    this.btnText,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
              Icon(
                image ?? IconData(0xe610, fontFamily: 'iconfont'),
                size: 80,
                color: Colors.grey[700],
              ),
          Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 150),
              child: Text(
                message ?? "加载失败",
                style: Theme.of(context)
                    .textTheme.bodyLarge.copyWith(color: Colors.grey[700]),
                    // .body1
                    // .copyWith(color: Colors.grey[700]),
              )),
        ],
      ),
    );
  }
}
