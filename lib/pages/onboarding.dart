import 'package:awquiz/pages/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'home.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final pages = [
    PageModel(
        color: Colors.black,
        imageAssetPath: 'assets/1.png',
        title: 'Current Affairs',
        
        body: 'Stay updated',
        doAnimateImage: true),
    PageModel(
        color: Colors.green,
        imageAssetPath: 'assets/1.png',
        title: 'Previous Year papers',
        body: 'Practice makes you perfect',
        doAnimateImage: true),
    PageModel(
        color: Colors.purple,
        imageAssetPath: 'assets/1.png',
        title: 'Syllabus',
        body: 'Know more about the syllabus',
        doAnimateImage: true),
    
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: OverBoard(
        pages: pages,
        
        showBullets: true,
        skipCallback: () {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  LoginPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          );
        },
        finishCallback: () {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  LoginPage(),
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
    );
  }
}
