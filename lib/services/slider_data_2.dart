import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/models/slider_model.dart';

class Sliders2 {
  List<sliderModel> sliders2 = [];

  Future<void> getSlider2() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=02a079a78c3043118334d4f6b97a1f71";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          sliderModel slidermodel = sliderModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          sliders2.add(slidermodel);
        }
      });
    }
  }
}
