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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'HomePage',
            ),
            // Text('from about page sent message is ${result ?? ''}'),
            Text('from about page sent message is $result'),
            TextButton(
                onPressed: () {
                  openAboutPage(context);
                  },
                child: Text('เปิดหน้าเกี่ยวกับเรา')
            ),
            TextButton(
                onPressed: () async {
                  result = await Navigator.pushNamed(
                      context,
                      'homestack/about',
                      arguments:ScreenArguments('thana.j@gmail.com', "0840866680")
                  );

                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text('$result')));
                },
                child: Text('เปิดหน้าเกี่ยวกับเรา2')
            )
          ],
        ),
      ),
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
