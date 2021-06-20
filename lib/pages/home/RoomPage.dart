import 'package:flutter/material.dart';
import 'package:flutter01/widgets/menu.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class RoomPage extends StatefulWidget {
  RoomPage({Key? key}) : super(key: key);

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  List<dynamic> room = [];
  bool isLoading = true;

  _getData()async{
    var url = Uri.parse('https://codingthailand.com/api/get_rooms.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {

      final List<dynamic> hotel = convert.jsonDecode(response.body);
      setState(() {
        room = hotel;
        // room = convert.jsonDecode(response.body);
        isLoading = false;
      });

    } else {
      setState(() {
        isLoading = false;
      });
      print('Request failed with status: ${response.statusCode}.');
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
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
          centerTitle: true,
          title: Text('Room')
        //Text(widget.title),
      ),
      body: isLoading == true ?
          Center(
            child: CircularProgressIndicator(),
          )
          : ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(

              title: Text(room[index]['id']),
              subtitle: Text(room[index]['name']),
              // trailing: Icon(Icons.arrow_right),

            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemCount: room.length
      )
    );
  }


}
