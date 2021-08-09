import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter01/redux/appReducer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:flutter01/data/ScreenArguments.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  // Map<String, dynamic> profile = {'name': '', 'email': '', 'role': ''};

  _getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var profileString = prefs.getString('profile');
    print(profileString);
    if (profileString != null) {
      // setState(() {
      //   profile = convert.jsonDecode(profileString);
      // });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // DrawerHeader(
          //   decoration: BoxDecoration(
          //     color: Colors.blue,
          //   ),
          //   child: Text(
          //     'Drawer Header',
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 24,
          //     ),
          //   ),
          // ),
          // UserAccountsDrawerHeader(
          //   currentAccountPicture: CircleAvatar(
          //     backgroundImage: AssetImage('images/thana.jpg'),
          //   ),
          //   accountName: Text('${profile['name']}'),
          //   accountEmail: Text('${profile['email']}'),
          //   otherAccountsPictures: [
          //     IconButton(
          //         onPressed: () {
          //           // Navigator.pushNamedAndRemoveUntil(
          //           //     context,
          //           //     'homestack/editprofile',
          //           //     (Route<dynamic> route) => false);
          //           Navigator.pushNamed(context, 'homestack/editprofile',
          //               arguments:
          //                   ScreenArguments(profile['name'], profile['email']));
          //         },
          //         icon: Icon(Icons.edit))
          //   ],
          // ),
          StoreConnector<AppState, Map<String, dynamic>>(
              distinct: true,
              converter: (store) => store.state.profileState.profile,
              builder: (context, profile) {
                return UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('images/thana.jpg'),
                  ),
                  accountName: Text('${profile['name']}'),
                  accountEmail: Text('${profile['email']}'),
                  otherAccountsPictures: [
                    IconButton(
                        onPressed: () {
                          // Navigator.pushNamedAndRemoveUntil(
                          //     context,
                          //     'homestack/editprofile',
                          //     (Route<dynamic> route) => false);
                          Navigator.pushNamed(context, 'homestack/editprofile',
                              arguments: ScreenArguments(
                                  profile['name'], profile['email']));
                        },
                        icon: Icon(Icons.edit))
                  ],
                );
              }),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('หน้าหลัก'),
            // selected: true,
            selected: ModalRoute.of(context)!.settings.name == 'homestack/home'
                ? true
                : false,
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamedAndRemoveUntil('/', (route) => false);
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('สินค้า'),
            selected:
                ModalRoute.of(context)!.settings.name == 'productstack/product'
                    ? true
                    : false,
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamedAndRemoveUntil('/productstack', (route) => false);
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('สินค้า dynamic'),
            selected: ModalRoute.of(context)!.settings.name ==
                    'productstack2/product2'
                ? true
                : false,
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamedAndRemoveUntil('/productstack2', (route) => false);
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('News'),
            selected: ModalRoute.of(context)!.settings.name == 'newsstack/news'
                ? true
                : false,
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamedAndRemoveUntil('/newsstack', (route) => false);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
