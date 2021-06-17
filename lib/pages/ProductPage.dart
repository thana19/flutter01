import 'package:flutter/material.dart';
import 'package:flutter01/data/ScreenArguments.dart';
import 'package:flutter01/widgets/logo.dart';
import 'package:flutter01/widgets/menu.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
          centerTitle: true,
          title: Text('สินค้า')
        //Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'สินค้า',
            ),

          ],
        ),
      ),
    );
  }


}
