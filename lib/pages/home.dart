import 'package:awquiz/controllers/quiz_controller.dart';
import 'package:awquiz/pages/home/news_page.dart';
import 'package:awquiz/pages/onboarding.dart';
import 'package:awquiz/widgets/my_bottom_navigation_bar_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/nav_bar.dart';
import 'home/about_page.dart';
import 'home/news_card.dart';
import 'home/quiz_category_card.dart';

import 'package:settings_ui/settings_ui.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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
    throw Exception('Failed to load news');
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
  String url = "";
  String? urlToImage;
  String? publishedAt;
  String? content;

  Articles(
      {this.source,
      this.author,
      this.title,
      this.description,
      required this.url,
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
  List quizImages = ["https://www.imf.org/external/pubs/ft/fandd/2020/06/images/frieden-1600.jpg",
   "https://leverageedu.com/blog/wp-content/uploads/2020/02/General-Knowledge-for-Kids.jpg", 
   "https://www.issnationallab.org/wp-content/uploads/baby_groot.jpg",
    "https://www.anratechnologies.com/home/wp-content/uploads/2016/11/history-1024x576.jpg",
     "https://www.anratechnologies.com/home/wp-content/uploads/2016/11/history-1024x576.jpg"];
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
MyBottomNavigationBarItem(
    icon: Icon(Icons.home),
    title: Text("Home"),
    activeColor: Colors.lightBlueAccent,
    inactiveColor: inactiveColor,
    textAlign: TextAlign.center,
),
MyBottomNavigationBarItem(
    icon: Icon(Icons.question_answer),
    title: Text("Quiz"),
    activeColor: Colors.lightBlueAccent,
    inactiveColor: inactiveColor,
    textAlign: TextAlign.center,
),
MyBottomNavigationBarItem(
    icon: Icon(Icons.newspaper),
    title: Text("News"),
    activeColor: Colors.lightBlueAccent,
    inactiveColor: inactiveColor,
    textAlign: TextAlign.center,
),
MyBottomNavigationBarItem(
    icon: Icon(Icons.settings),
    title: Text("Settings"),
    activeColor: Colors.lightBlueAccent,
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
           
           backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/app-icon.png',width: 40, ),
                  SizedBox(width: 10,),
                  Text("CLAT App",style: TextStyle(color: Colors.blue),)
                ],
              ),
      ),
      body: currentPosition == 0 ? Padding(
        padding: const EdgeInsets.only(top: 150 ,left: 20, right: 20),
        child: Center(
          child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              children: <Widget>[
                GestureDetector(
                      onTap: () => {  
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const AboutPage()),
  )},
                  child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Stack(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        
                        color: Colors.blueAccent,
                        image: DecorationImage(image: NetworkImage("https://hbr.org/resources/images/article_assets/2022/02/Feb22_23_3597544.jpg"),fit: BoxFit.cover)
                     
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black,
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "About CLAT",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 24.0,
                              ),
                            ),
                            SizedBox(height: 8),
                           
                          ],
                        ),
                      ),
                    ),
                  ],
                              ),
                            ),
                          ),
                ),
          GestureDetector(
            onTap: () async {
             await launchUrl(Uri.parse("https://law.careers360.com/articles/clat-syllabus"));
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Stack(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        image: DecorationImage(fit: BoxFit.cover,image: NetworkImage("https://cdn.dnaindia.com/sites/default/files/styles/full/public/2021/07/15/985341-neet-2021-study-material.jpg"))
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black,
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Syllabus",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 24.0,
                              ),
                            ),
                            SizedBox(height: 8),
                           
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
            Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewsPage()),
      );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Stack(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        
                        color: Colors.orange,
                        image: DecorationImage(
                        fit: BoxFit.cover,
                          image: NetworkImage("https://static3.depositphotos.com/1004325/185/i/450/depositphotos_1853470-stock-photo-news.jpg")),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black,
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "News",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 24.0,
                              ),
                            ),
                            SizedBox(height: 8),
                           
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
               GestureDetector(
                 onTap: () async { await launchUrl(Uri.parse("https://www.careerindia.com/entrance-exam/clat-question-papers-e29.html")); },
                 child: Padding(
                           padding: const EdgeInsets.only(bottom: 8.0),
                           child: ClipRRect(
                             borderRadius: BorderRadius.circular(4),
                             child: Stack(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        
                        color: Colors.orange,
                        image: DecorationImage(fit:BoxFit.cover, image: NetworkImage("https://media.istockphoto.com/photos/miniature-house-and-many-question-marks-on-white-papers-house-with-picture-id694294788?k=20&m=694294788&s=612x612&w=0&h=IYKMo43ttNj0RWLPS_V_TX0mO0zqqYIXRmh51pQJkR4="))
                     
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black,
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Previous year papers",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 24.0,
                              ),
                            ),
                            SizedBox(height: 8),
                           
                          ],
                        ),
                      ),
                    ),
                  ],
                             ),
                           ),
                         ),
               )],
                
              ),
        ),
      ) : currentPosition == 1 ? Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
             
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
                          image: quizImages[index],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ) : currentPosition == 2 ? Stack(
        children: [
          
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                   FutureBuilder<News>(
            future: futureNews,
            builder: (context, snapshot) {
              
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.articles!.length,
                          itemBuilder: (_, index) => GestureDetector(
                             onTap: () async{
                      await launchUrl(Uri.parse(snapshot.data!.articles![index].url));
                    },
                            child: NewsCard(
                              title: snapshot.data!.articles![index].title,
                              image: snapshot.data!.articles![index].urlToImage ?? "https://media.istockphoto.com/vectors/thumbnail-image-vector-graphic-vector-id1147544807?k=20&m=1147544807&s=612x612&w=0&h=pBhz1dkwsCMq37Udtp9sfxbjaMl27JUapoyYpQm0anc=",
                            ),
                          ),
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

