
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.451),
                image: DecorationImage(
                  fit: BoxFit.cover,
                    image: NetworkImage(image ?? "https://media.istockphoto.com/vectors/thumbnail-image-vector-graphic-vector-id1147544807?k=20&m=1147544807&s=612x612&w=0&h=pBhz1dkwsCMq37Udtp9sfxbjaMl27JUapoyYpQm0anc=")),
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
    );
  }
}
