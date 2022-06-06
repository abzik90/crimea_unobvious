import 'package:about/about.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'ytLauncher.dart';

class FirstAboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    String description="Крым Неочевидный!\n\nВас приветствует первый видео журнал, посвященный всему Крымскому полуострову. Наши выпуски выходят в свет еженедельно. Следите за нами в социальных сетях. Чем Дальше, тем интереснее и увлекательнее";
    return FutureBuilder(
          future: getPackageInfo(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return AboutPage(
                values: {
                  'version': snapshot.data.version,
                  'buildNumber': snapshot.data.buildNumber,
                  'year': DateTime.now().year.toString(),
                  'author': "bizhigitn",
                },
                title: Text('О приложении',style: new TextStyle(fontFamily: "Helvetica"),),
                applicationVersion: 'Версия {{ version }}, Билд: {{ buildNumber }}',
                applicationDescription: Text(
                  description,
                  style: TextStyle(fontSize: 18,fontFamily: "Helvetica"),
                  // textAlign: TextAlign.justify,
                ),
                applicationIcon: Image.asset("assets/logo.png"),
                applicationLegalese: 'Copyright © {{ author }}, {{ year }}',
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: 28.0,
                          icon: FaIcon(FontAwesomeIcons.instagram),
                          onPressed: () => {ytLauncher("https://instagram.com/krim_neochevidniy")},
                        ),
                        IconButton(
                          iconSize: 28.0,
                          icon: FaIcon(FontAwesomeIcons.vk),
                          onPressed: () => {ytLauncher("https://vk.com/crimeaputevoditel")},
                        ),
                        IconButton(
                          iconSize: 28.0,
                          icon: FaIcon(FontAwesomeIcons.youtube),
                          onPressed: () => {ytLauncher("https://www.youtube.com/channel/UCjJcZjGW4DSiwGYPu9TloVQ?view_as=subscriber")},
                        ),
                        IconButton(
                          iconSize: 28.0,
                          icon: FaIcon(FontAwesomeIcons.tiktok),
                          onPressed: () => {ytLauncher("https://www.tiktok.com/@crimean.stories")},
                        ),
                        IconButton(
                          iconSize: 28.0,
                          icon: FaIcon(FontAwesomeIcons.telegram),
                          onPressed: () => {ytLauncher("https://t.me/crimeaputevoditel")},
                        ),
                        IconButton(
                          iconSize: 28.0,
                          icon: FaIcon(FontAwesomeIcons.yandex),
                          onPressed: () => {ytLauncher("https://zen.yandex.ru/id/5d612af02f4ad700ac2ecd7e")},
                        ),
                        IconButton(
                          iconSize: 28.0,
                          icon: FaIcon(FontAwesomeIcons.odnoklassniki),
                          onPressed: () => {ytLauncher("https://ok.ru/krymneoch")},
                        ),

                      ],
                    ),

                ],
              );
            }
            return Center(child: CircularProgressIndicator(),);
          }
    );
  }
  Future<PackageInfo> getPackageInfo() async{
    PackageInfo packageInfo=await PackageInfo.fromPlatform();
    return packageInfo;
  }
}
