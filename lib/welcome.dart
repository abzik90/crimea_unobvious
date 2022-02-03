import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class WelcomePage extends StatelessWidget {
  Widget buildImage(String path) =>
      Center(child: Image.asset(path,width: 350,),);
  PageDecoration getPageDecoration() => PageDecoration(
      titleTextStyle: TextStyle(fontSize: 26.0,fontFamily: "San Francisco",fontWeight: FontWeight.w700),
      bodyTextStyle: TextStyle(fontSize: 18.0,fontFamily: "San Francisco"),
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
  Widget build(BuildContext context) {
    return SafeArea(

      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Крым Неочевидный",
            body: "Видео журнал #КрымНеОчевидный - это свой собственный Крымский видео хостинг, аналог всем известного \"Youtube\", отличие в том, что наш портал целиком и полностью посвящен Крыму.",
            image: buildImage("assets/logo.jpg"),
            decoration: getPageDecoration(),

          ),
          PageViewModel(
            title: "Крым Неочевидный",
            body: "Наша команда путешествует по всему Крыму и занимается видео съемкой всевозможных известных и не очень известных достопримечательностей нашего полуострова.",
            image: buildImage("assets/welcome/winter.jpg"),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: "Крым Неочевидный",
            body: "Подписывайтесь на наши каналы в различных соцсетях, дабы всегда первыми лицезреть новые выпуски. Вас ждет много всего интересного и НеОчевидного.",
            image: buildImage("assets/welcome/man.png"),
            decoration: getPageDecoration(),
          )
        ],
        showSkipButton: true,
        skip: Text("Пропуск"),
        next: Icon(Icons.arrow_forward),

        dotsDecorator: getDotDecoration(),
        done: Text("Начать!"),
        onDone: (){
          Navigator.pushNamed(context,'/');
        },
      ),
    );

  }
}
