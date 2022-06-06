import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> fetchWpPosts(url) async {
  final response = await http.get(url,headers: {
    "Accept":"application/json"
  });
  var convertedDataToJson=jsonDecode(response.body);
  print("fetchWpPosts fired!");
  return convertedDataToJson;
}

Future fetchWpJson(url) async {
  final response = await http.get(url,headers: {
    "Accept":"application/json"
  });
  var convertedDataToJson = jsonDecode(response.body);
  return convertedDataToJson;
}

Future<String> fetchWpMediaUrl(String url) async {
    //enters the post json,and then gets media
    final response = await http.get(url,headers: {
      "Accept":"application/json"
    });
    var convertedDataToJson=jsonDecode(response.body);
    return "https://xn--b1aebaqhbqjfgu9g5bk.xn--p1ai/wp-json/wp/v2/media/"+(convertedDataToJson["featured_media"].toString());
}
