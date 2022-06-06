import 'package:flutter/material.dart';
import 'fetchfunctions.dart';
import 'postclass.dart';
import 'bottom.dart';

String searchText="Крым";

// @override
// void initState() {
//   searchText="Крым";
// }
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  void searchChange(String searchTextChange){
    setState(() {
      if(searchTextChange!=null && searchTextChange!="")
        searchText=searchTextChange;
      else searchText="Крым";
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(2,70,2,0),
            child: Container(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Поиск',
                ),
                onChanged: searchChange,
              ),
            ),
          ),
          Container(
            child: FutureBuilder(
              future:fetchWpPosts("https://xn--b1aebaqhbqjfgu9g5bk.xn--p1ai/index.php/wp-json/wp/v2/search?search="+searchText+"&per_page=50&page=1"),
              builder:(context,snapshot){
                if(snapshot.hasData){

                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context,int index){
                        Map wpPost=snapshot.data[index];
                          return FutureBuilder(
                              future:fetchWpMediaUrl(wpPost["_links"]["self"][0]["href"]),
                              builder: (context,snapshotMedia){
                                if(snapshotMedia.hasData){
                                  if(snapshotMedia.data.toString() != "https://xn--b1aebaqhbqjfgu9g5bk.xn--p1ai/wp-json/wp/v2/media/0"){
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(0,0,0,10),
                                      child: PostCard(
                                        postID: wpPost["id"].toString(),
                                        imageURL:snapshotMedia.data.toString(),
                                        postURL: wpPost["url"],
                                        title: wpPost["title"].replaceAll("&#8212;","").replaceAll("#171;","").replaceAll("&#187;","").replaceAll("&#8230","").replaceAll("&nbsp;",""),
                                        description: "\n",
                                        content: "\n",
                                      ),
                                    );
                                  }
                                  else{
                                    return Container();
                                  }
                                }else{
                                  return Center(child: CircularProgressIndicator(),);
                                }
                              }
                          );

                      },
                    ),
                  );
                }
                return Center(
                  child:CircularProgressIndicator(),
                );
              },
            ),
          ),

         

        ],
      ),
      bottomNavigationBar: BottomBarCustom(),
    );
  }
}
