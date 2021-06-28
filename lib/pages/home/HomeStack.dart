import 'package:flutter/material.dart';
import 'package:flutter01/pages/home/AboutPage.dart';
import 'package:flutter01/pages/home/CompanyPage.dart';
import 'package:flutter01/pages/home/ContactPage.dart';
import 'package:flutter01/pages/home/HomePage.dart';
import 'package:flutter01/pages/news/NewsPage.dart';
import 'package:flutter01/pages/home/RoomPage.dart';

class HomeStack extends StatefulWidget {
  const HomeStack({Key? key}) : super(key: key);

  @override
  _HomeStackState createState() => _HomeStackState();
}

class _HomeStackState extends State<HomeStack> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'homestack/home',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'homestack/home':
            builder = (BuildContext context) => HomePage();
            break;
          case 'homestack/about':
            builder = (BuildContext context) => AboutPage();
            break;
          case 'homestack/company':
            builder = (BuildContext context) => CompanyPage();
            break;
          case 'homestack/contact':
            builder = (BuildContext context) => ContactPage();
            break;
          case 'homestack/room':
            builder = (BuildContext context) => RoomPage();
            break;
          case 'homestack/news':
            builder = (BuildContext context) => NewsPage();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }
}
