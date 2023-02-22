import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanflutter/entity/project_list_entity.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProjectDetailPage extends StatefulWidget {
  ProjectListDataData projectDetail;

  ProjectDetailPage({this.projectDetail});

  @override
  State<StatefulWidget> createState() {
    return new ProjectDetailWidget();
  }
}

class ProjectDetailWidget extends State<ProjectDetailPage> {
  WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        widget.projectDetail.title,
        style: TextStyle(color: Colors.blue[300], fontSize: 26),
      )),
      body: SafeArea(
//         child: WebViewWidget(
//           initialUrl: widget.projectDetail.link,
//           //允许加载javascript
//           javascriptMode: JavascriptMode.unrestricted,
//           onWebViewCreated: (WebViewController controller) {
//             _webViewController = controller;
//           },
//           onPageFinished: (url) {
//             print("cx-加载完成。。");
// //            _webViewController.evaluateJavascript(url).then((value) => {
// //              setState((){
// //
// //              })
// //            });
//           },
//         ),
        child: WebViewWidget(
          controller: WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setBackgroundColor(const Color(0x00000000))
            ..setNavigationDelegate(
              NavigationDelegate(
                onProgress: (int progress) {
                  // Update loading bar.
                },
                onPageStarted: (String url) {},
                onPageFinished: (String url) {
                  print("cx-加载完成。。");
                },
                onWebResourceError: (WebResourceError error) {  print("cx-加载错误。。");},
                // onNavigationRequest: (NavigationRequest request) {
                //   if (request.url.startsWith('https://www.youtube.com/')) {
                //     return NavigationDecision.prevent;
                //   }
                //   return NavigationDecision.navigate;
                // },
              ),
            )
            ..loadRequest(Uri.parse(widget.projectDetail.link)),
        ),
      ),
    );
  }
}
