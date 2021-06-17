import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('รายละเอียดสินค้า')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('รายละเอียดสินค้า'),

          ],
        ),
      ),
    );
  }


}
