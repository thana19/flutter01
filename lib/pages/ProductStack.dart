import 'package:flutter/material.dart';
import 'package:flutter01/pages/DetailPage.dart';
import 'package:flutter01/pages/ProductPage.dart';

class ProductStack extends StatefulWidget {
  const ProductStack({Key? key}) : super(key: key);

  @override
  _ProductStackState createState() => _ProductStackState();
}

class _ProductStackState extends State<ProductStack> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'productstack/product',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'productstack/product':
            builder = (BuildContext context) => ProductPage();
            break;
          case 'productstack/detail':
            builder = (BuildContext context) => DetailPage();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }
}
