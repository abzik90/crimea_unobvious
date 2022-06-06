import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatelessWidget {

  Future<void> defineVisit() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setInt('initScreen',667);
  }

  Widget buildImage(String path) =>
      Center(child: Image.asset(path,width: 350,),);
  PageDecoration getPageDecoration() => PageDecoration(
      titleTextStyle: TextStyle(fontSize: 26.0,fontFamily: "Helvetica",fontWeight: FontWeight.w700),
      bodyTextStyle: TextStyle(fontSize: 18.0,fontFamily: "Helvetica"),
      descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
      imagePadding: EdgeInsets.all(24),
      pageColor: Colors.white
  );
  DotsDecorator getDotDecoration() => DotsDecorator(
    size:Size(10,10),
    activeSize:Size(22,10),
    activeShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24)
    )
  );
  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Крым Неочевидный",
            body: "Видео Журнал #КрымНеОчевидный - это первое Крымское цифровое сетевое видео издание, посвященное целиком и полностью Крымскому полуострову.",
            image: buildImage("assets/welcome/page1.png"),
            decoration: getPageDecoration(),

          ),
          PageViewModel(
            title: "Такого Крыма Вы еще не видели!",
            body: "Наша команда путешествует по всему Крыму и занимается видео съемкой всевозможных известных и малоизвестных достопримечательностей нашего полуострова.",
            image: buildImage("assets/welcome/page2.png"),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: "Крым Неочевидный",
            body: "Подписывайтесь на наши каналы и аккаунты в различных социальных сетях или оставайтесь в этом приложении, дабы всегда первыми лицезреть новые выпуски. Вас ждет много интересного и НеОчевидного. Ссылки на соцсети в разделе «Инфо»",
            image: buildImage("assets/welcome/page3.png"),
            decoration: getPageDecoration(),
          )
        ],
        showSkipButton: true,
        skip: Text("Пропуск",style: new TextStyle(fontFamily: "Helvetica"),),
        next: Icon(Icons.arrow_forward),

        dotsDecorator: getDotDecoration(),
        done: Text("Начать!",style: new TextStyle(fontFamily: "Helvetica"),),
        onDone: (){
          defineVisit();
          Navigator.pushNamed(context,'/');
        },
      ),
    );

  }
}
