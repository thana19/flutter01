import 'package:flutter/material.dart';
import 'package:flutter01/pages/home/HomeStack.dart';
import 'package:flutter01/pages/login/LoginPage.dart';
import 'package:flutter01/pages/login/RegisterPage.dart';
import 'package:flutter01/pages/news/NewsStack.dart';
import 'package:flutter01/pages/product/ProductStack.dart';
import 'package:flutter01/pages/product2/ProductStack2.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? token;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString('token');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        canvasColor: Colors.red[50],
      ),
      // home: HomePage(),
      initialRoute: '/',
      routes: {
        '/': (context) => token == null ? LoginPage() : HomeStack(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/homestack': (context) => HomeStack(),
        '/productstack': (context) => ProductStack(),
        '/productstack2': (context) => ProductStack2(),
        '/newsstack': (context) => NewsStack(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
