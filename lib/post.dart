import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import 'ytLauncher.dart';
import 'bottom.dart';
import 'fetchfunctions.dart';
import 'preload.dart';

class PostPage extends StatefulWidget {
  final String postID,postURL,imageURL;
  PostPage({this.postID,this.postURL,this.imageURL});

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    String jsonPostURL="https://xn--b1aebaqhbqjfgu9g5bk.xn--p1ai/wp-json/wp/v2/posts/"+widget.postID;
    return Scaffold(
      body:ListView(
        children:[
            Center(
              child:Padding(
                  padding:const EdgeInsets.all(12),
                  child:Text(
                    "Просмотр Видео",
                    style:TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,),
                  )
              ),
            ),
            FutureBuilder(
              future: getYT(widget.postURL),
              builder: (context,snapshot){
                if(snapshot.hasData){
                      return GestureDetector(
                      onTap: (){ytLauncher(snapshot.data);},
                      child:Card(
                       child:Padding(
                         padding: const EdgeInsets.fromLTRB(0.0,50.0,0.0,0.0),
                         child: Column(
                            children: [
                              FutureBuilder(
                                future: fetchWpJson(widget.imageURL),
                                builder: (context,snapshot){
                                  if(snapshot.hasData){
                                    return Stack(
                                      children: <Widget>[
                                        Container(
                                            // height:230,
                                            decoration: new BoxDecoration(color: Colors.white),
                                            alignment: Alignment.center,
                                            child: CachedNetworkImage(
                                              imageUrl: (snapshot.data["guid"]["rendered"]!="") ? snapshot.data["guid"]["rendered"] : snapshot.data["source_url"],
                                              placeholder: (context, url) => Center(child: PreloadWidget()),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                            )
                                        ),
                                        Positioned(
                                          bottom: 50, right: 125, //give the values according to your requirement
                                          child: Icon(
                                              Icons.play_circle_fill_rounded,
                                              size:120
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  return Center(
                                    child:PreloadWidget(),
                                  );
                                },
                              ),
                            ],
                          ),
                       ),

                      ),
                      );
                    }else if(snapshot.hasError){
                      print(snapshot.error);
                      return Center(child: PreloadWidget());
                    }else{
                      return Center(child: PreloadWidget());
                    }
              }
            ),
          FutureBuilder(
            future: fetchWpJson(jsonPostURL),
            builder: (context,snapshot){
            if(snapshot.hasData){
              // String article=snapshot.data['content']['rendered'].replaceAll('<a href="https://xn--b1aebaqhbqjfgu9g5bk.xn--p1ai/icons-video/"><div align="center"><img src="/icons/car_red.png" title="тип автомобиля"><img src="/icons/road_red.png" title="качество дороги"><img src="/icons/price_white.png" title="стоимость посещения"></div></a>',"");
              String article=snapshot.data['content']['rendered'];
              int occ = article.indexOf("<p>"),last=article.length;
              print(occ);
              article = article.substring(occ,last);
              // print(article);
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  SizedBox(height: 5,),
                  SingleChildScrollView(
                    child: SingleChildScrollView(
                      child: Html(
                        data: article,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                ],),
              );
            }
            return Center(child: PreloadWidget());
          })

        ],
      ),
      bottomNavigationBar: BottomBarCustom(),
    );
  }
}