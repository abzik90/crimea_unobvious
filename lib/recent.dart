import 'package:flutter/material.dart';
import 'post.dart';
import 'fetchfunctions.dart';
import 'package:cached_network_image/cached_network_image.dart';


class RecentVideos extends StatefulWidget {
  @override
  _RecentVideosState createState() => _RecentVideosState();
}

class _RecentVideosState extends State<RecentVideos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: fetchWpPosts("https://xn--b1aebaqhbqjfgu9g5bk.xn--p1ai/wp-json/wp/v2/posts?per_page=2"),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20),
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemCount: snapshot.data.length,
              shrinkWrap : true,
              itemBuilder: (BuildContext context,int index) {
                Map wpPost=snapshot.data[index];
                return GestureDetector(
                  child: CachedNetworkImage(
                    imageUrl: wpPost['yoast_head_json']['schema']['@graph'][2]['url'],
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),

                  onTap: (){Navigator.push(context,MaterialPageRoute(builder:(context)=>PostPage(postID: wpPost["id"].toString(), postURL: wpPost["link"],)));
                  },
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
