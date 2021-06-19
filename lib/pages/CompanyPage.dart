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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('images/bg.png'),
              height: 100,
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
                      SizedBox(height: 10,),
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
                          List.generate(8, (index) => Chip(
                            label: Text('Text1 ${index+1}'),
                            avatar: Icon(Icons.star),
                            backgroundColor: Colors.red,
                          ),)
                      ),
                      Divider(),
                      buildRowFooter()
                  ],
                  ),
                )
            )
          ],
        ),
      )
    );
  }

  Row buildRowFooter() {
    return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('images/thana.jpg'),
                        radius: 40,
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage('images/thana.jpg'),
                        radius: 40,
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage('images/thana.jpg'),
                        radius: 40,
                      ),
                      SizedBox(
                        width: 60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(Icons.business),
                            Icon(Icons.scanner),
                            Icon(Icons.edit_location_outlined),
                          ],
                        ),
                      )
                    ],
                  );
  }

  void openHomePage() {
    Navigator.pushNamedAndRemoveUntil(context, 'homestack/home', (Route<dynamic> route) => false);
  }
}
