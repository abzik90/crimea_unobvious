import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'directions.dart';


class DirectionElements{
  String photoLink;
  String rusText;
  String functionNavs;

  DirectionElements({this.photoLink,this.rusText,this.functionNavs});
}


List<Widget> getList(objectsIt,context){
  List<Widget> listToShow = [];
  for (var i = 0; i < objectsIt.length; i++) {
    listToShow.add(
      InkWell(
        onTap: (){
          Navigator.of(context)
              .push(
              MaterialPageRoute(builder: (context)=>DirectionsPage(rusText:objectsIt[i].rusText,functionNavs:objectsIt[i].functionNavs,tagId:"0",tagName:""))
          );
        },
        child: Image.asset(
          objectsIt[i].photoLink,
          width: 200,
          fit: BoxFit.cover,

        ),
      ),
    );
  }
  return listToShow;
}

class MenuPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<DirectionElements> elements = [
      DirectionElements(photoLink:"assets/textPagePhotos/beaches.jpg",rusText:"Пляжи",functionNavs:"/beaches"),
      DirectionElements(photoLink:"assets/textPagePhotos/east.jpg",rusText:"Восток",functionNavs:"/east"),
      DirectionElements(photoLink:"assets/textPagePhotos/west.jpg",rusText:"Запад",functionNavs:"/west"),
      DirectionElements(photoLink:"assets/textPagePhotos/north.jpg",rusText:"Север",functionNavs:"/north"),
      DirectionElements(photoLink:"assets/textPagePhotos/south.jpg",rusText:"Юг",functionNavs:"/south"),
      DirectionElements(photoLink:"assets/textPagePhotos/center.jpg",rusText:"Центр",functionNavs:"/center"),
      DirectionElements(photoLink:"assets/textPagePhotos/festivals.jpg",rusText:"Фестивали",functionNavs:"/festivals"),
      DirectionElements(photoLink:"assets/textPagePhotos/reportage.jpg",rusText:"Репортажи",functionNavs:"/reportage"),
      DirectionElements(photoLink:"assets/textPagePhotos/poetics.jpg",rusText:"Поэзия Крыма",functionNavs:"/poetics"),
      DirectionElements(photoLink:"assets/textPagePhotos/museums.jpg",rusText:"Музеи Крыма",functionNavs:"/museums"),
    ];
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8),
      scrollDirection: Axis.vertical,
      crossAxisCount: 2,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      shrinkWrap: true,
      children: getList(elements,context),
    );
  }
}
