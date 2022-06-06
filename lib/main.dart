import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart' as globals;
import 'menu.dart';
import 'recent.dart';
import 'bottom.dart';
import 'fetchfunctions.dart';
import 'post.dart';
import 'welcome.dart';
import 'apiKey.dart' as apiKey;

int initScreen;

Future<void> main() async{
  globals.appNavigator=GlobalKey<NavigatorState>();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences=await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen',1);
  runApp(MyApp());
}


/*
* Для отправки push уведомлений на iOS устройства,нужно сгенерировать специальный сертификат
* (APN) и включить в фоновых сервисамх XCode
* https://firebase.google.com/docs/cloud-messaging/ios/client*
* */

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static final String oneSignalAppId=apiKey.oneSignalAppId;

  @override
  void initState(){
    super.initState();
    initPlatformState();
  }
  @override
  Widget build(BuildContext context) {
    print("hi");
    return MaterialApp(
      routes: {
        '/welcome': (context) => WelcomePage(),
      },
      initialRoute: initScreen != 667 ? '/welcome':'/',
      navigatorKey: globals.appNavigator,
      home:Scaffold(

          body:ListView(
            children:<Widget>[
              Text("Новые выпуски",
                textAlign:TextAlign.center,
                style: new TextStyle(fontSize: 30.0,fontFamily: "Helvetica",fontWeight: FontWeight.w600),),
              RecentVideos(),
              Text("Выберите направление",
                textAlign:TextAlign.center,
                style: new TextStyle(fontSize: 30.0,fontFamily: "Helvetica",fontWeight: FontWeight.w600),),
              MenuPart(),

            ],
          ),
          bottomNavigationBar:BottomBarCustom()
      ),
    );
  }

  Future<void> initPlatformState() async{
    OneSignal.shared.init(oneSignalAppId);
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
    OneSignal.shared.setNotificationOpenedHandler((openedResult) async{
      var data = openedResult.notification.payload.additionalData;
      if(data != null){
        String postId=data["post_id"].toString();
        final wpPost=await fetchWpJson("https://xn--b1aebaqhbqjfgu9g5bk.xn--p1ai/wp-json/wp/v2/posts/"+postId);
        String mediaUrl=wpPost["_links"]["wp:featuredmedia"][0]["href"];
        String url=wpPost["link"];
        globals.appNavigator.currentState.push(MaterialPageRoute(builder: (context) => PostPage(
            postID: postId,
            postURL:url
        )
        )
        );
      }
    });
  }
}