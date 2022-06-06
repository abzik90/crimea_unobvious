import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';


Future<String> getYT(String url) async{
  final response= await http.Client().get(Uri.parse(url));
  if(response.statusCode==200){
    var document = parse(response.body);
    final String link=document.getElementsByTagName("iframe")[0].attributes['src'].toString();
    return link;
  }else{
    print("Не смог найти ссылку видео");
    return ("Error");
  }
}

Future<void> ytLauncher(String url) async{
  if(await canLaunch(url)){
    final bool nativeAppLaunchSuccess = await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true
    );
    if(!nativeAppLaunchSuccess){
      await launch(url,forceSafariVC: true);
    }

  }
}