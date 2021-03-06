import 'package:http/http.dart' as http;
import 'dart:convert';

class Comic {
  final int id;
  final String title;
  final DateTime date;
  final String imgUrl;

  Comic(this.id, this.title, this.date, this.imgUrl);

  Comic.fromJson(Map<String, dynamic> json)
      : this(
            json['num'],
            json['title'],
            dateFromString(json['year'], json['month'], json['day']),
            json['img']);

  static DateTime dateFromString(String year, String month, String day) =>
      DateTime(int.parse(year), int.parse(month), int.parse(day));

  String getDateString() => "${date.year}-${date.month}-${date.day}";
}

class Backend {
  static Future<Map<String, dynamic>> jsonGet(String url) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw Exception("JSON Get failed");
  }

  static String xkcd_url = "https://xkcd.com/";
  static String xkcd_end = "info.0.json";

  static Future<List<Comic>> getLatestComics([int amount = 10]) async {
    Map<String, dynamic> json = await jsonGet("https://xkcd.now.sh/?comic=latest");
    Comic first = Comic.fromJson(json);
    List<Comic> returnList = [first];

    int id = first.id;
    amount--;
    id--;
    while (amount > 0 && id >= 0) {
      json = await jsonGet("https://xkcd.now.sh/?comic=$id");
      returnList.add(Comic.fromJson(json));
      amount--;
      id--;
    }
    return returnList;
  }
}
