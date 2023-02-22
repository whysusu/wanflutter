import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'manager/route_maneger.dart';

void main() {
//  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  //状态栏透明
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
//        primarySwatch: Colors.white,//主题颜色，只能是MaterialColor类型
        primaryColor: Colors.white, //若要修改为其他颜色就要用到这个属性
      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: RouteName.splash,
      //初始路由
      onGenerateRoute: Router1.generateRouter,
      //生成路由
      debugShowCheckedModeBanner: false, //是否显示右上角的debug标签
    );
  }
}
