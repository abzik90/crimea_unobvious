import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'ytLauncher.dart';
import 'bottom.dart';
import 'fetchfunctions.dart';
import 'preload.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart' as webView;

class PostPage extends StatefulWidget {
  final String postID,postURL;
  PostPage({this.postID,this.postURL});

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
                    style:TextStyle(fontSize: 30.0,fontFamily:"Helvetica",fontWeight: FontWeight.bold,),
                  )
              ),
            ),
          FutureBuilder(
            future: getYT(widget.postURL),
            builder: (context,snapshot){
            if(snapshot.hasData){
                print(snapshot.data.toString());
                return Container(
                  width: 400,
                  height:250,
                  child:Padding(
                   padding: const EdgeInsets.fromLTRB(0.0,50.0,0.0,0.0),
                   child: InAppWebView(
                     initialUrl: snapshot.data.toString(),
                     initialHeaders: {},
                     initialOptions: InAppWebViewGroupOptions(
                         crossPlatform: InAppWebViewOptions(
                           debuggingEnabled: true,
                         )),

                   ),
                 )
                );
            }else if(snapshot.hasError){
                print(snapshot.error);
                return Center(child: PreloadWidget());
            }else{
                return Center(child: PreloadWidget());
              }
            }),
          FutureBuilder(
            future: fetchWpJson(jsonPostURL),
            builder: (context,snapshot){
            if(snapshot.hasData){
              // String article=snapshot.data['content']['rendered'].replaceAll('<a href="https://xn--b1aebaqhbqjfgu9g5bk.xn--p1ai/icons-video/"><div align="center"><img src="/icons/car_red.png" title="тип автомобиля"><img src="/icons/road_red.png" title="качество дороги"><img src="/icons/price_white.png" title="стоимость посещения"></div></a>',"");
              String article=snapshot.data['content']['rendered'];
              int occ = article.indexOf("<p>"),last=article.length;
              print(occ);
              if(occ != 0 && last != 0)
                article = article.substring(occ,last);
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  // Container(
                  //   height: 175,
                  //   width: 400,
                  //   child:webView.WebView(
                  //     javascriptMode: webView.JavascriptMode.unrestricted,
                  //     initialUrl: "https://xn--b1aebaqhbqjfgu9g5bk.xn--p1ai/code-ads.html",
                  //     navigationDelegate: (webView.NavigationRequest request) {
                  //       if (request.url.startsWith("https://xn--b1aebaqhbqjfgu9g5bk.xn--p1ai/")) {
                  //         return webView.NavigationDecision.navigate;
                  //       } else {
                  //         ytLauncher(request.url);
                  //         return webView.NavigationDecision.prevent;
                  //       }
                  //     },
                  //   ),
                  // ),
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
