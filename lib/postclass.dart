import 'package:crimea_unobvious/preload.dart';
import 'package:flutter/material.dart';
import 'post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'fetchfunctions.dart';
import 'preload.dart';

class PostCard extends StatefulWidget {
  final String postID,imageURL,postURL,title,description,content;
  PostCard({this.postID,this.imageURL,this.postURL,this.title,this.description,this.content});

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder:(context)=>PostPage(
            postID: widget.postID,
            postURL: widget.postURL
           )
          )
        );
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(8.0,8.0,8.0,0.0),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: fetchWpJson(widget.imageURL),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return CachedNetworkImage(
                      imageUrl:(snapshot.data["guid"]["rendered"]!="") ? snapshot.data["guid"]["rendered"] : snapshot.data["source_url"],
                      placeholder: (context, url) => Center(child: PreloadWidget()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    );
                  }else if(snapshot.hasError){
                    print(snapshot.error);
                    return Center(child: CircularProgressIndicator());//Empty message
                  }
                  return Center(
                      child: PreloadWidget(),
                  );
                },
              ),
              Text(
                widget.title.replaceAll("&",""),
                style:TextStyle(fontFamily:"Helvetica",fontWeight: FontWeight.w600,fontSize: 18),
              ),
              SizedBox(height: 5,),
              SingleChildScrollView(
                child: Text(widget.description.replaceAll("<p>", "").replaceAll("</p>", "").replaceAll("[&hellip;]", "..."),style:TextStyle(fontFamily:"Helvetica"),),
              ),
              SizedBox(height: 20,),
              //Text(),
            ],
          ),
        ),
      ),
    );
  }
}

