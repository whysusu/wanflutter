import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanflutter/model/system_model.dart';
import 'package:wanflutter/provider/provider_widget.dart';

class SystemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new SystemState();
  }
}

class SystemState extends State<SystemPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ProviderWidgetOne<SystemTreeModel>(
      modelT: SystemTreeModel(),
      onModelReady: (systemTreeModel) {
        systemTreeModel.initData();
      },
      build: (context, systemTreeModel, child) {
        return systemTreeModel.list.length > 0
            ? Scaffold(
                appBar: AppBar(
                  title: Container(
                    child: Text("体系"),
                  ),
                  centerTitle: true,
                ),
                body: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: ListView.builder(
                    itemCount: systemTreeModel.list.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text(
                                systemTreeModel.list[index].name,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Wrap(
                              spacing: 5,
                              runSpacing: 5,
                              children: List.generate(
                                  systemTreeModel.list[index].children.length,
                                  (childIndex) => Container(
                                        padding: EdgeInsets.only(top: 5,bottom: 5,left: 8,right: 8),
                                        decoration: new BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.blue[300],
//                                            gradient: RadialGradient(
//                                                colors: [
//                                                  Colors.white,
//                                                  Colors.blue[300],
//                                                ],
//                                                radius: 1,
//                                                tileMode: TileMode.mirror)
                                        ),
                                        child: Text(
                                          systemTreeModel.list[index]
                                              .children[childIndex].name,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      )),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
            : Text("");
      },
    );
  }
}
