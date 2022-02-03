import 'package:flutter/material.dart';
import 'ytLauncher.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';
import 'package:html/parser.dart' as parser;


Future<List> getPreview(url) async {
  List<String> titles=List();
  List<String> links=List();
  List<String> preview=List();

  final response = await http.get(url,headers: {
    "Accept":"application/json"
  });
  var convertedDataToJson=jsonDecode(response.body);
  final document = parser.parseFragment(convertedDataToJson['content']['rendered']);

  final atags=document.querySelectorAll('a');
  final imgs=document.querySelectorAll('img');

  for(final atag in atags){
    titles.add(atag.text.toString());
    links.add(atag.attributes['href'].toString());
  }

  for(final img in imgs){
    preview.add(img.attributes['src'].toString());
  }
  return[titles,links,preview];
}


class RecentVideos extends StatefulWidget {
  @override
  _RecentVideosState createState() => _RecentVideosState();
}

class _RecentVideosState extends State<RecentVideos> {
  @override
  Widget build(BuildContext context) {
    String recentPostsUrl="https://xn--b1aebaqhbqjfgu9g5bk.xn--p1ai/wp-json/wp/v2/pages/8233";
    return Container(
      child: FutureBuilder(
        future: getPreview(recentPostsUrl),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20),
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemCount: 2,
              shrinkWrap : true,
              itemBuilder: (BuildContext context,int index) {
                return GestureDetector(
                  onTap: () {
                    getYT(snapshot.data[1][index]).then((urlFuture){
                      ytLauncher(urlFuture);
                    });
                    Center(child:CircularProgressIndicator());
                  },

                  child: CachedNetworkImage(
                    imageUrl: snapshot.data[2][index],
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                );
              }
            );

          }
          return Center(
            child:CircularProgressIndicator(),
          );
        },
      ),
    );

  }
}
