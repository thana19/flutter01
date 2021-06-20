import 'package:flutter/material.dart';
import 'package:flutter01/pages/product2/DetailPage2.dart';
import 'package:flutter01/pages/product2/ProductPage2.dart';

class ProductStack2 extends StatefulWidget {
  const ProductStack2({Key? key}) : super(key: key);

  @override
  _ProductStack2State createState() => _ProductStack2State();
}

class _ProductStack2State extends State<ProductStack2> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'productstack2/product2',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'productstack2/product2':
            builder = (BuildContext context) => ProductPage2();
            break;
          case 'productstack2/detail2':
            builder = (BuildContext context) => DetailPage2();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }
}
