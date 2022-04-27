import 'package:awquiz/controllers/quiz_controller.dart';
import 'package:awquiz/pages/onboarding.dart';
import 'package:awquiz/widgets/my_bottom_navigation_bar_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import '../widgets/nav_bar.dart';
import 'home/news_card.dart';
import 'home/quiz_category_card.dart';
import 'home/quiz_search.dart';
import 'package:settings_ui/settings_ui.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<News> fetchNews() async {
  final response = await http
      .get(Uri.parse('https://newsapi.org/v2/top-headlines?country=in&apiKey=ce67dfb9d31c45c483490fc1fc643ccb'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return News.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class News {
  String? status;
  int? totalResults;
  List<Articles>? articles;

  News({this.status, this.totalResults, this.articles});

  News.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        articles!.add(new Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['totalResults'] = this.totalResults;
    if (this.articles != null) {
      data['articles'] = this.articles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Articles {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Articles(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  Articles.fromJson(Map<String, dynamic> json) {
    source =
        json['source'] != null ? new Source.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.source != null) {
      data['source'] = this.source!.toJson();
    }
    data['author'] = this.author;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['urlToImage'] = this.urlToImage;
    data['publishedAt'] = this.publishedAt;
    data['content'] = this.content;
    return data;
  }
}

class Source {
  String? id;
  String? name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List quizImages = ["5", "6", "7", "8", "9"];
  var currentPosition = 0;
  late Future<News> futureNews;
  
   @override
  void initState() {
    super.initState();
    futureNews = fetchNews();
  }

  Widget bottomNavigationBarWidget() {

var inactiveColor = Colors.white;
return MyBottomNavigationBar(
containerHeight: 75,
itemCornerRadius: 25,
curve: Curves.easeIn,
bgColor: Colors.black,
showElevation: true,
selectedPosition: currentPosition,
onItemSelected: (index) => setState(() => currentPosition = index),
items: <MyBottomNavigationBarItem>[
// MyBottomNavigationBarItem(
//     icon: Icon(Icons.home),
//     title: Text("Home"),
//     activeColor: Colors.orangeAccent,
//     inactiveColor: inactiveColor,
//     textAlign: TextAlign.center,
// ),
MyBottomNavigationBarItem(
    icon: Icon(Icons.question_answer),
    title: Text("Quiz"),
    activeColor: Colors.pinkAccent,
    inactiveColor: inactiveColor,
    textAlign: TextAlign.center,
),
MyBottomNavigationBarItem(
    icon: Icon(Icons.newspaper),
    title: Text("News"),
    activeColor: Colors.tealAccent,
    inactiveColor: inactiveColor,
    textAlign: TextAlign.center,
),
MyBottomNavigationBarItem(
    icon: Icon(Icons.settings),
    title: Text("Settings"),
    activeColor: Colors.deepOrangeAccent,
    inactiveColor: inactiveColor,
    textAlign: TextAlign.center,
),
],
);
}

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
       bottomNavigationBar: bottomNavigationBarWidget(),
         appBar: AppBar(
              title: Text("CLAT App"),
        actions: [
         
        ],),
      body: currentPosition == 0 ?  Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.deepPurple,
                Colors.deepPurpleAccent,
              ]),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  // QuizSearchView(),
                  Obx(() {
                    var categories = Get.find<QuizController>().categories;
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: categories.length,
                        itemBuilder: (_, index) => QuizCategoryCard(
                          categories[index],
                          image: quizImages[index % (quizImages.length)],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ) : currentPosition == 1 ? Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.deepPurple,
                Colors.deepPurpleAccent,
              ]),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                   FutureBuilder<News>(
            future: futureNews,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (_, index) => NewsCard(
                          title: snapshot.data!.articles![index].title,
                          image: snapshot.data!.articles![index].urlToImage,
                        ),
                      ),
                    );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        
               
                ],
              ),
            ),
          ),
        ],
      ) : SettingsList(
        sections: [
          SettingsSection(
            title: Text("General"),
            tiles: [
              SettingsTile(title: Text("Language"),
              leading: Icon(Icons.language),),
              SettingsTile(
                title: Text("Log out"),
               
                leading: Icon(Icons.logout_rounded),
                onPressed: (BuildContext context) async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      OnboardingPage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                ),
              );
            },
              ),
             
            ],
          ),
        ],
      ),

    );
  }
  
}

