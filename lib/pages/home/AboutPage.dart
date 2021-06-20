import 'package:flutter/material.dart';
import 'package:flutter01/data/ScreenArguments.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  Future<Map<String, dynamic>> _getData()async{
    var url = Uri.parse('https://api.codingthailand.com/api/version');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> version = convert.jsonDecode(response.body);
      return version;
    } else {
      throw Exception('Failed to load version ${response.statusCode}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {

    final contact = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      appBar: AppBar(title: Text('เกี่ยวกับเรา')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<Map<String, dynamic>>(
              future: _getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!['data']['version']);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
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
