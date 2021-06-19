import 'package:flutter/material.dart';

class CompanyPage extends StatefulWidget {
  const CompanyPage({Key? key}) : super(key: key);

  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company')
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
                image: AssetImage('images/bg.png')
            ),
            SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Thana', style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold)),
                      Divider(),
                      Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
                          'Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, '
                          'the 1960s with the release'),
                      Divider(),
                      SizedBox(height: 20,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Icon(Icons.phone, color: Colors.red,)
                            ],
                          ),
                          SizedBox(width: 25),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [ Text('Thana Chantrapong')]),
                              Row(children: [ Text('0840866680')]),
                            ],
                          )
                        ],
                      ),
                      Divider(),
                      Wrap(
                        spacing: 4,
                        children:
                          List.generate(10, (index) => Chip(
                            label: Text('Text1 '),
                            avatar: Icon(Icons.save_outlined),
                            backgroundColor: Colors.red,
                          ),)
                      )
                    ],
                  ),
                )
            )
          ],
        ),
      )
    );
  }

  void openHomePage() {
    Navigator.pushNamedAndRemoveUntil(context, 'homestack/home', (Route<dynamic> route) => false);
  }
}
