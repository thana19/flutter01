import 'package:flutter/material.dart';
import 'package:flutter01/models/product.dart';
import 'package:flutter01/widgets/menu.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Course> course = [];
  bool isLoading = true;

  _getData()async{
    var url = Uri.parse('https://api.codingthailand.com/api/course');
    var response = await http.get(url);
    if (response.statusCode == 200) {

      final Product product = Product.fromJson(convert.jsonDecode(response.body));
      setState(() {
        course = product.course;
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
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
          centerTitle: true,
          title: Text('สินค้า')
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
                        image: NetworkImage(course[index].picture),
                        fit: BoxFit.cover
                    )
                ),
              ),
              // title: Text('item $index'),
              title: Text(course[index].title),
              subtitle: Text(course[index].detail),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  'productstack/detail',
                  arguments: {
                    'id': course[index].id,
                    'title': course[index].title,
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
