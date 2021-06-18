import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('หน้าหลัก'),
            // selected: true,
            selected: ModalRoute.of(context)!.settings.name == 'homestack/home' ? true : false ,
            // selected: ModalRoute.of(context)!.settings.name == '/' ? true : false,
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil('/', (route) => false);
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('สินค้า'),
            // selected: ModalRoute.of(context)!.settings.name == '/productstack' ? false : true ,
            selected: ModalRoute.of(context)!.settings.name == 'productstack/product' ? true : false ,
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil('/productstack', (route) => false);
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
