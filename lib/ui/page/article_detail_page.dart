import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanflutter/entity/article_top_bean_entity.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailPage extends StatefulWidget {
  ArticleTopBeanData article;

  ArticleDetailPage({this.article});

  @override
  ArticleDetailState createState() {
    return new ArticleDetailState();
  }
}

class ArticleDetailState extends State<ArticleDetailPage> {
  WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        widget.article.title,
        style: TextStyle(color: Colors.blue[300], fontSize: 26),
      )),
      body: SafeArea(
//         child: WebView(
//           initialUrl: widget.article.link,
//           //允许加载javascript
//           javascriptMode: JavascriptMode.unrestricted,
//           onWebViewCreated: (WebViewController controller) {
//             _webViewController = controller;
//           },
//           onPageFinished: (url) {
//             print("加载完成。。");
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
            ..loadRequest(Uri.parse(widget.article.link)),
        ),
      ),
    );
  }
}
