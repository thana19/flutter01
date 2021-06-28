import 'package:flutter/material.dart';
import 'package:flutter01/widgets/menu.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<dynamic> articles = [];
  int totalResults = 0;
  bool isLoading = true;
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  int page = 1;
  int pageSize = 5 ;

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _getData();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    if(mounted) {
      setState(() {
        page = ++page;
      });
      _getData();
    }
    _refreshController.loadComplete();
  }


  _getData()async{
    try {
      var url = Uri.parse('https://newsapi.org/v2/everything?q=apple&apiKey=44377980b970429b8fbfac5b6f13e55f&page=$page&pageSize=$pageSize');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> news = convert.jsonDecode(response.body);
        setState(() {
          articles.addAll(news['articles']);
          totalResults = news['totalResults'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch(e) {
      setState(() {
        isLoading = false;
      });
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
          title: totalResults > 0 ? Text('ข่าว ($totalResults)') : Text('News')
        //Text(widget.title),
      ),
      body: isLoading == true ?
          Center(
            child: CircularProgressIndicator(),
          )
          : SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: ClassicHeader(
                refreshingText: 'wait',
              ),
              // footer: ClassicFooter();

              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child:  ListView.separated(itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: InkWell (
                      onTap: () {
                        Navigator.pushNamed(context, 'newsstack/webview', arguments: {
                          'url' : articles[index]['url'],
                          'name' : articles[index]['source']['name']
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 200,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                    child:
                                    articles[index]['urlToImage'] != null ?
                                    Ink.image(image: NetworkImage(articles[index]['urlToImage']), fit: BoxFit.cover,):
                                    Ink.image(image: NetworkImage('https://picsum.photos/500/200'),fit: BoxFit.cover)
                                ),
                                Positioned(
                                    bottom: 16,
                                    left: 16,
                                    right: 16,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.bottomLeft,
                                      child: Text(articles[index]['source']['name'], style: TextStyle(color: Colors.white),),
                                    )
                                )
                              ],
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 16, 16, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(articles[index]['title'])
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              articles[index]['author'] != null ?
                              Chip(
                                  avatar: Icon(Icons.person),
                                  label: articles[index]['author'].length <20 ?
                                  Text(articles[index]['author']) :
                                  Text(articles[index]['author'].substring(0,20))
                              )
                                  : Chip(
                                  avatar: Icon(Icons.person),
                                  label: Text('')
                              ),
                              Text(DateFormat.yMMMd().format(DateTime.parse(articles[index]['publishedAt'])))
                            ],
                          )
                        ],
                      ),
                    )
                );
              },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                  itemCount: articles.length
              )
          ),

    );
  }


}
