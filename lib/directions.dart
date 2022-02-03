import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bottom.dart';
import 'fetchfunctions.dart';
import 'postclass.dart';

class DirectionsPage extends StatelessWidget {
  Map<String,String> urls={
    "/beaches":"https://xn--b1aebaqhbqjfgu9g5bk.xn--p1ai/index.php/wp-json/wp/v2/posts?per_page=50&categories=2238",
    "/east":"https://xn--b1aebaqhbqjfgu9g5bk.xn--p1ai/index.php/wp-json/wp/v2/posts?per_page=50&categories=709",
    "/west":"https://xn--b1aebaqhbqjfgu9g5bk.xn--p1ai/index.php/wp-json/wp/v2/posts?per_page=50&categories=710",
    "/north":"https://xn--b1aebaqhbqjfgu9g5bk.xn--p1ai/index.php/wp-json/wp/v2/posts?per_page=50&categories=711",
    "/south":"https://xn--b1aebaqhbqjfgu9g5bk.xn--p1ai/index.php/wp-json/wp/v2/posts?per_page=50&categories=712",
    "/center":"https://xn--b1aebaqhbqjfgu9g5bk.xn--p1ai/index.php/wp-json/wp/v2/posts?per_page=50&categories=713",
    "/festivals":"https://xn--b1aebaqhbqjfgu9g5bk.xn--p1ai/index.php/wp-json/wp/v2/posts?per_page=50&categories=716",
    "/reportage":"https://xn--b1aebaqhbqjfgu9g5bk.xn--p1ai/index.php/wp-json/wp/v2/posts?per_page=50&categories=1301",
    "/poetics":"https://xn--b1aebaqhbqjfgu9g5bk.xn--p1ai/index.php/wp-json/wp/v2/posts?per_page=50&categories=715",
    "/museums":"https://xn--b1aebaqhbqjfgu9g5bk.xn--p1ai/index.php/wp-json/wp/v2/posts?per_page=50&categories=714",
    "/tags":"https://xn--b1aebaqhbqjfgu9g5bk.xn--p1ai/wp-json/wp/v2/posts?per_page=50&tags="

  };
  String functionNavs,rusText,tagId,tagName;
  List<String> contentImage,contentURL,contentDescription;
  DirectionsPage({this.rusText,this.functionNavs,this.tagId,this.tagName});

  @override
  Widget build(BuildContext context) {
    if(tagId!="0" && functionNavs=="/tags"){
      urls['/tags']=urls['/tags']+tagId;
      rusText=tagName;
      print(urls['/tags']);
    }
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
        child: Column(
          children: [
            Center(
                child:Padding(
                    padding:const EdgeInsets.all(12),
                    child:Text(
                      rusText+" \n(нажмите для просмотра)",
                      style:TextStyle(fontSize: 25.0,fontFamily:"San Francisco",),
                    )
                ),
            ),
            Container(
              child:FutureBuilder(
                future:fetchWpPosts(urls[functionNavs]),
                builder:(context,snapshot){
                  if(snapshot.hasData){
                    if(snapshot.data.length==0)
                      return Center(child: Text("К сожалению постов нету..."),);
                    return Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) => DirectionsPage(rusText:rusText,functionNavs:functionNavs,tagId:tagId,tagName:tagName),
                              transitionDuration: Duration.zero,
                            ),
                          );
                         return;
                        },
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context,int index){
                            Map wpPost=snapshot.data[index];
                            // print("DirectionsImgURL:"+wpPost["_links"]["wp:featuredmedia"][0]["href"]);
                            print(wpPost["link"]);
                            return PostCard(
                                postID: wpPost["id"].toString(),
                                imageURL: wpPost["_links"]["wp:featuredmedia"][0]["href"],
                                postURL: wpPost["link"],
                                title: wpPost["title"]["rendered"].replaceAll("&#8212;","").replaceAll("#171;","").replaceAll("&#187;","").replaceAll("&#8230","").replaceAll("&nbsp;",""),
                                description: wpPost["excerpt"]["rendered"].replaceAll("&#8212;","").replaceAll("&#171;","").replaceAll("&#187;","").replaceAll("&#8230","").replaceAll("&nbsp;",""),
                                content: wpPost["content"]["rendered"]
                            );
                            //return Text(wpPost["title"]["rendered"]);
                          },
                        ),
                      ),
                    );
                  }
                  return Center(
                    child:CircularProgressIndicator(),
                  );
                }
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBarCustom(),
    );
  }
}

