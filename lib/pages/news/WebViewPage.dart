import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({Key? key}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    final Map news = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      // drawer: Menu(),
      appBar: AppBar(
        leading: (ModalRoute.of(context)?.canPop ?? false) ? BackButton() : null,
        title: Text('${news['name']}'),
        automaticallyImplyLeading: false,
      ),
      body: WebView(
          initialUrl: '${news['url']}',
           javascriptMode: JavascriptMode.unrestricted,
      )
    );
  }
}
