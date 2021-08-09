import 'package:flutter/material.dart';
import 'package:flutter01/data/ScreenArguments.dart';
import 'package:flutter01/redux/appReducer.dart';
import 'package:flutter01/widgets/logo.dart';
import 'package:flutter01/widgets/menu.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter01/main.dart';

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
          title: const Logo(),
          actions: [
            IconButton(
                onPressed: () {
                  _logout();
                },
                icon: Icon(Icons.exit_to_app))
          ],
          //Text(widget.title),
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/bg2.png'), fit: BoxFit.cover)),
            child: Column(
              children: [
                StoreConnector<AppState, Map<String, dynamic>>(
                    distinct: true,
                    converter: (store) => store.state.profileState.profile,
                    builder: (context, profile) {
                      return Expanded(
                        flex: 1,
                        child: Text(
                            'welcome ${profile['name']} ${profile['email']}'),
                      );
                    }),
                Expanded(
                    flex: 3,
                    child: GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            result = await Navigator.pushNamed(
                                context, 'homestack/company',
                                arguments: ScreenArguments(
                                    'thana.j@gmail.com', "0840866680"));

                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(
                                  SnackBar(content: Text('$result')));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.business,
                                    size: 80, color: Colors.red),
                                Text(
                                  'company',
                                  style: TextStyle(fontSize: 20),
                                )
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
                              Text(
                                'บริษัท',
                                style: TextStyle(fontSize: 20),
                              )
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
                              Text(
                                'Camera',
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                          color: Colors.teal[100],
                        ),
                        GestureDetector(
                          onTap: () async {
                            result = await Navigator.pushNamed(
                                context, 'homestack/about',
                                arguments: ScreenArguments(
                                    'thana.j@gmail.com', "0840866680"));

                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(
                                  SnackBar(content: Text('$result')));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.person, size: 80, color: Colors.red),
                                Text(
                                  'About',
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                            color: Colors.teal[100],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              'homestack/room',
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.person, size: 80, color: Colors.red),
                                Text(
                                  'Room',
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                            color: Colors.teal[100],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              'homestack/news',
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.fiber_new_sharp,
                                    size: 80, color: Colors.red),
                                Text(
                                  'News',
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                            color: Colors.teal[100],
                          ),
                        ),
                      ],
                    ))
              ],
            )));
  }

  void openAboutPage(BuildContext context) async {
    result = await Navigator.pushNamed(context, 'homestack/about',
        arguments: ScreenArguments('thana.j@gmail.com', "0840866680"));

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('profile');

    //open login
    // Navigator.pushNamedAndRemoveUntil(
    //     context, '/login', (Route<dynamic> route) => false);
    Navigator.of(context, rootNavigator: true)
        .pushNamedAndRemoveUntil('/login', (route) => false);
  }
}
