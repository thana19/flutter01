import 'package:flutter/material.dart';
import 'package:flutter01/data/ScreenArguments.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {

    final contact = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      appBar: AppBar(title: Text('เกี่ยวกับเรา')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('เกี่ยวกับเรา'),
            Text(contact.email),
            Text(contact.phone),
            TextButton(
                onPressed: openContactPage,
                child: Text('`เปิดหน้าติดต่อเรา')
            ),
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
    Navigator.pop(context, 'About AAA');
   // Navigator.pushNamed(context, '/');
  }

  void openContactPage() {
    Navigator.pushNamed(context, 'homestack/contact');
  }
}
