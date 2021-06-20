import 'package:flutter/material.dart';
// import 'package:flutter01/models/product.dart';
import 'package:flutter01/widgets/menu.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ProductPage2 extends StatefulWidget {
  ProductPage2({Key? key}) : super(key: key);

  @override
  _ProductPage2State createState() => _ProductPage2State();
}

class _ProductPage2State extends State<ProductPage2> {
  List<dynamic> course = [];
  bool isLoading = true;

  _getData()async{
    var url = Uri.parse('https://api.codingthailand.com/api/course');
    var response = await http.get(url);
    if (response.statusCode == 200) {

      final Map<String, dynamic> product = convert.jsonDecode(response.body);
      setState(() {
        course = product['data'];
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
          title: Text('สินค้า dynamic')
        //Text(widget.title),
      ),
      body: isLoading == true ?
          Center(
            child: CircularProgressIndicator(),
          )
          : ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        image: NetworkImage(course[index]['picture']),
                        fit: BoxFit.cover
                    )
                ),
              ),
              // title: Text('item $index'),
              title: Text(course[index]['title']),
              subtitle: Text(course[index]['detail']),
              // trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  'productstack2/detail2',
                  arguments: {
                    'id': course[index]['id'],
                    'title': course[index]['title'],
                  }
                );
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemCount: course.length
      )
    );
  }


}
