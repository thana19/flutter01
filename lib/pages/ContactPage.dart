import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ติดต่อเรา'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('ติดต่อเรา'),
            TextButton(
                onPressed: openHomePage,
                child: Text('กลับหน้าหลัก')
            ),
          ],
        ),
      ),
    );
  }

  void openHomePage() {
    Navigator.pushNamedAndRemoveUntil(context, 'homestack/home', (Route<dynamic> route) => false);
  }
}
