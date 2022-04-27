import 'package:awquiz/controllers/news_controller.dart';
import 'package:awquiz/models/quiz_category.dart';
import 'package:awquiz/pages/home/quiz_page.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class NewsCard extends StatelessWidget {
  final String? image;
  final String? title;
  const NewsCard(
  
     {
    Key? key,
    required this.image,
  required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<NewsController>().loadNews();
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (_, anim, anim2) => FadeTransition(
              opacity: anim,
              child: QuizPage(),
            ),
          ),
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
                  color: Colors.black45,
                  image: DecorationImage(
                      image: NetworkImage(image!)),
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
                        title!,
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
    );
  }
}
