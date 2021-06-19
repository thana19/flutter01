import 'package:flutter/material.dart';
import 'package:flutter01/data/ScreenArguments.dart';
import 'package:flutter01/widgets/logo.dart';
import 'package:flutter01/widgets/menu.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
          centerTitle: true,
          title: const Logo()
        //Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg2.png'),
            fit: BoxFit.cover
          )
        ),
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            GestureDetector(
              onTap: ()async {
                result = await Navigator.pushNamed(
                    context,
                    'homestack/company',
                    arguments:ScreenArguments('thana.j@gmail.com', "0840866680")
                );

                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text('$result')));
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.business, size: 80, color: Colors.red),
                    Text('บริศัท', style: TextStyle(fontSize: 20),)
                  ],
                ),
                color: Colors.teal[100],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 80, color: Colors.red),
                  Text('บริษัท', style: TextStyle(fontSize: 20),)
                ],
              ),
              color: Colors.teal[100],
            ),

            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera, size: 80, color: Colors.red),
                  Text('Camera', style: TextStyle(fontSize: 20),)
                ],
              ),
              color: Colors.teal[100],
            ),
            GestureDetector(
              onTap: ()async {
                result = await Navigator.pushNamed(
                    context,
                    'homestack/about',
                    arguments:ScreenArguments('thana.j@gmail.com', "0840866680")
                );

                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text('$result')));
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person, size: 80, color: Colors.red),
                    Text('About', style: TextStyle(fontSize: 20),)
                  ],
                ),
                color: Colors.teal[100],
              ),
            ),
          ],
        )
      )
    );
  }

 void openAboutPage(BuildContext context) async {
    result = await Navigator.pushNamed(
        context,
        'homestack/about',
        arguments:ScreenArguments('thana.j@gmail.com', "0840866680")
        );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }
}
