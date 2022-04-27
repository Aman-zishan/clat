import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NewsController extends GetxController {

  RxBool loadingNews = true.obs;
  RxList news = [].obs;
  loadNews() async {

    loadingNews(true);
    http.Response res = await http.get(
      Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=ce67dfb9d31c45c483490fc1fc643ccb",
      ),
    );
    var json = jsonDecode(res.body);
    if (json["articles"] != null) {
      json["articles"].forEach((e) => news.add(e));
    }
    loadingNews(false);
    return news;
  }

  clearNews() => news.clear();
}
