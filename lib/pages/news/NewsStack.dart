import 'package:flutter/material.dart';
import 'package:flutter01/pages/news/NewsPage.dart';
import 'package:flutter01/pages/news/WebViewPage.dart';

class NewsStack extends StatefulWidget {
  const NewsStack({Key? key}) : super(key: key);

  @override
  _NewsStackState createState() => _NewsStackState();
}

class _NewsStackState extends State<NewsStack> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'newsstack/news',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'newsstack/news':
            builder = (BuildContext context) => NewsPage();
            break;
          case 'newsstack/webview':
            builder = (BuildContext context) => WebViewPage();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }
}
