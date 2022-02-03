import 'package:crimea_unobvious/directions.dart';
import 'package:flutter/material.dart';
import 'bottom.dart';

class TagsPage extends StatefulWidget {
  // const TagsPage({Key? key}) : super(key: key);
  @override
  _TagsPageState createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  List<Map<String,int>> tagsList=[
    {"Азовское море" : 1097},
    {"Активный отдых" : 1110},
    {"Античное городище" : 1574},
    {"Археологическая экспедиция" : 1872},
    {"Архитектура" : 769},
    {"Аэродром" : 1126},
    {"Аэросъемка" : 1714},
    {"Бархатный сезон" : 1533},
    {"Белый песок" : 878},
    {"Берег моря" : 1009},
    {"Бикини" : 2268},
    {"Большая Ялта" : 1071},
    {"Боспорское царство" : 886},
    {"Великая отечественная в Крыму" : 793},
    {"Вечный огонь" : 1221},
    {"Византийская империя" : 2212},
    {"Виндсерф" : 2297},
    {"Высоцкий" : 1956},
    {"Горы" : 756},
    {"Гражданская война" : 1778},
    {"Гробницы" : 776},
    {"Грязелечение" : 1045},
    {"Дайвинг" : 1017},
    {"Дворцы" : 753},
    {"День Победы" : 1142},
    {"Дикая природа" : 1619},
    {"Дикие животные" : 1623},
    {"Дикие пляжи" : 767},
    {"Загадки Крыма" : 1651},
    {"Закат" : 876},
    {"Заповедники" : 738},
    {"Зоопарки" : 772},
    {"Интервью" : 2067},
    {"Кайт" : 853},
    {"Кенасы" : 761},
    {"Керченский пролив" : 1318},
    {"Краеведческий музей" : 1044},
  ];
  @override
  Widget build(BuildContext context) {
    //Каменоломни   Not found
    //космос и крым Not found
    return Scaffold(
      body: ListView.builder(
        itemCount: tagsList.length,
        itemBuilder: (context, index) {
          Map<String,int> tag=tagsList[index];
          String key=tag.keys.toString().replaceAll("(","").replaceAll(")",""),value=tag.values.toString().replaceAll("(","").replaceAll(")","");

          return ListTile(
            title: GestureDetector(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder:(context)=>DirectionsPage(
                  rusText: "",
                  functionNavs: "/tags",
                  tagId: value,
                  tagName: key
                   )
                  )
                );
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,20,0,20),
                  child: Text(key),
                ),
              ),
            ),
          );
        },
      ),
          bottomNavigationBar: BottomBarCustom(),
    );
  }
}
