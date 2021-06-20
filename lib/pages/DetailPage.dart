import 'package:flutter/material.dart';
import 'package:flutter01/models/detail.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late var course ;
  // late Map<String, dynamic> course ;

  List<Chapter> chapter = [];
  bool isLoading = true;
  final fNumber = NumberFormat('#,###');

  _getData(int id)async {
    var url = Uri.parse('https://api.codingthailand.com/api/course/$id');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final Detail detail = Detail.fromJson(convert.jsonDecode(response.body));
      print(response.body);
      setState(() {
        chapter = detail.chapter;
        isLoading = false;
      });
    } else {
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
              title: Text(chapter[index].chTitle),
              subtitle: Text(chapter[index].chDateadd),
              trailing: Chip(
                label: Text('${fNumber.format(chapter[index].chView)}'),
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
