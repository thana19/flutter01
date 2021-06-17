import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('logo build');
    return Image.asset('images/akira2.png', height: 40, fit: BoxFit.cover);
  }
}
