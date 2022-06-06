import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'about.dart';
import 'search.dart';
import 'tags.dart';


class BottomBarCustom extends StatefulWidget {
   @override
  _BottomBarCustomState createState() => _BottomBarCustomState();
}

class _BottomBarCustomState extends State<BottomBarCustom> {
  @override
  void initState(){
    super.initState();
  }
  void onTapped(int index){
    if(index==0)  
      Navigator.of(context).maybePop();//Navigator.of(context).popUntil((route) => route.isFirst);
    else if(index==1)
      Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);
    else if(index==2)
      Navigator.push(context,MaterialPageRoute(builder: (context) => TagsPage()),);
    else if(index==3)
      Navigator.push(context,MaterialPageRoute(builder: (context) => FirstAboutPage()),);
    else
    Navigator.push(context,MaterialPageRoute(builder: (context) => SearchPage()),);

  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_back),
          label: 'Назад',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.home),
          label: 'Домой',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.tag),
          label: 'Теги',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.info),
          label: 'Инфо',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.search),
          label: 'Поиск',
        ),
      ],
      //currentIndex: null,
      onTap:onTapped,
    );
  }
}
