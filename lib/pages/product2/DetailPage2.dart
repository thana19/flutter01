import 'package:flutter/material.dart';
// import 'package:flutter01/models/detail.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DetailPage2 extends StatefulWidget {
  const DetailPage2({Key? key}) : super(key: key);

  @override
  _DetailPage2State createState() => _DetailPage2State();
}

class _DetailPage2State extends State<DetailPage2> {
  late var course ;
  // late Map<String, dynamic> course ;

  List<dynamic> chapter = [];
  bool isLoading = true;
  final fNumber = NumberFormat('#,###');

  _getData(int id)async {
    var url = Uri.parse('https://api.codingthailand.com/api/course/$id');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> detail = convert.jsonDecode(response.body);
      print(response.body);
      setState(() {
        chapter = detail['data'];
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
    print('init1');
    Future.delayed(Duration.zero, () {
      print('init2');
      _getData(course['id']);
    });
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   // _getData(course['id']);
  // }
  
  @override
  Widget build(BuildContext context) {
    // course = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic> ;
    course = ModalRoute.of(context)!.settings.arguments ;
    print('build1');
    return Scaffold(
      appBar: AppBar(
          title: Text('${course['title']}')
      ),
      body: isLoading == true ?
      Center(
        child: CircularProgressIndicator(),
      )
          : ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              // title: Text('item $index'),
              title: Text(chapter[index]['ch_title']),
              subtitle: Text(chapter[index]['ch_dateadd']),
              trailing: Chip(
                label: Text('${fNumber.format(chapter[index]['ch_view'])}'),
                backgroundColor: Colors.deepOrange,
              )

            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemCount: chapter.length
      )
    );
  }


}
