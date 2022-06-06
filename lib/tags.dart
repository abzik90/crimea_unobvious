import 'package:crimea_unobvious/directions.dart';
import 'package:flutter/material.dart';
import 'bottom.dart';

class TagsPage extends StatefulWidget {
  // const TagsPage({Key? key}) : super(key: key);
  @override
  _TagsPageState createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  List<Map<String,int>> popularTags=[
    {"Крымчанка" : 1636},
    {"Аэросъемка" : 1714},
    {"Горы" : 756},
    {"Дворцы" : 753},
    {"Дикие пляжи" : 767},
    {"Закат" : 876},
    {"Рассвет" : 1034},
    {"Заповедники" : 738},
    {"Места силы" : 763},
    {"Море" : 818},
    {"Пляжи" : 768},
    {"Музеи" : 733},
    {"Археология" : 765},
    {"Пещерные города" : 747}
  ];
  List<Map<String,int>> tagsList=[
    {"Азовское море" : 1097},
    {"Активный отдых" : 1110},
    {"Античное городище" : 1574},
    {"Археологическая экспедиция" : 1872},
    {"Археология" : 765},
    {"Архитектура" : 769},
    {"Астрономия" : 1907},
    {"Аэродром" : 1126},
    {"Аэросъемка" : 1714},
    {"Бархатный сезон" : 1533},
    {"Белый песок" : 878},
    {"Берег моря" : 1009},
    {"Бикини" : 2268},
    {"Большая ялта" : 1071},
    {"Боспорское царство" : 886},
    {"Великая отечественная в крыму" : 793},
    {"Византийская империя" : 2212},
    {"Виндсерф" : 2297},
    {"Горы" : 756},
    {"Гражданская война" : 1778},
    {"Гробницы" : 776},
    {"Грязелечение" : 1045},
    {"Дайвинг" : 1017},
    {"Дворцы" : 753},
    {"День победы" : 1142},
    {"Дикая природа" : 1619},
    {"Дикие животные" : 1623},
    {"Дикие пляжи" : 767},
    {"Загадки крыма" : 1651},
    {"Закат" : 876},
    {"Заповедники" : 738},
    {"Зима в крыму" : 1818},
    {"Зоопарки" : 772},
    {"Интервью" : 2067},
    {"Казантип" : 1931},
    {"Кайт" : 853},
    {"Кенасы" : 761},
    {"Керченский пролив" : 1318},
    {"Крепости" : 734},
    {"Крым и наука" : 1923},
    {"Крымская война" : 1998},
    {"Крымчанка" : 1636},
    {"Курганы" : 777},
    {"Ландшафтный парк" : 1614},
    {"Лечебные грязи" : 1174},
    {"Малый иерусалим" : 929},
    {"Маяк" : 1007},
    {"Мемориалы" : 775},
    {"Места силы" : 763},
    {"Море" : 818},
    {"Музеи" : 733},
    {"Музеи под открытым небом" : 1344},
    {"Набережные" : 766},
    {"Наследие ссср" : 1920},
    {"Наука и крым" : 1926},
    {"Онлайн экскурсия" : 1592},
    {"Осенний крым" : 1720},
    {"Османская империя" : 808},
    {"Парки" : 774},
    {"Пещерные города" : 747},
    {"Пляжи" : 768},
    {"Поход" : 1115},
    {"Поэзия крыма" : 921},
    {"Праздник победы" : 2079},
    {"Птицы" : 2335},
    {"Радиотелескоп" : 1678},
    {"Раскопки" : 875},
    {"Рассвет" : 1034},
    {"Религиозные центры" : 745},
    {"Розовые озера" : 740},
    {"Рыбалка в крыму" : 849},
    {"Скифы" : 1434},
    {"Снег в крыму" : 1811},
    {"Степи" : 1129},
    {"Усадьбы" : 754},
    {"Фестивали крыма" : 977},
    {"Экспедиция в крыму" : 1580}
  ];
  @override
  Widget build(BuildContext context) {
    //Каменоломни   Not found
    //космос и крым Not found
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
            child: Text("Популярные теги",
              textAlign:TextAlign.left,
              style: new TextStyle(fontSize: 30.0,fontFamily: "Helvetica",fontWeight: FontWeight.w600),),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: popularTags.length,
            itemBuilder: (context, index) {
              Map<String,int> tag=popularTags[index];
              String key=tag.keys.toString().replaceAll("(","").replaceAll(")",""),value=tag.values.toString().replaceAll("(","").replaceAll(")","");

              return ListTile(
                dense:true,
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
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,10,0,10),
                      child: Text(key,style: new TextStyle(fontFamily: "Helvetica"),),
                    ),
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text("Все теги",
              textAlign:TextAlign.left,
              style: new TextStyle(fontSize: 30.0,fontFamily: "Helvetica",fontWeight: FontWeight.w600),),
          ),
        ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: tagsList.length,
          itemBuilder: (context, index) {
            Map<String,int> tag=tagsList[index];
            String key=tag.keys.toString().replaceAll("(","").replaceAll(")",""),value=tag.values.toString().replaceAll("(","").replaceAll(")","");

            return ListTile(
              dense:true,
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
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0,10,0,10),
                    child: Text(key,style: new TextStyle(fontFamily: "Helvetica"),),
                  ),
                ),
              ),
            );
          },
        ),
      ]),
          bottomNavigationBar: BottomBarCustom(),
    );
  }
}
