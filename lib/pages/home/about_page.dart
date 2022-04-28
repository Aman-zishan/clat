import 'package:flutter/material.dart';


class AboutPage extends StatefulWidget {
  const AboutPage({ Key? key }) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Scaffold(appBar:  AppBar(
           backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/app-icon.png',width: 40, ),
                  SizedBox(width: 10,),
                  Text("CLAT App",style: TextStyle(color: Colors.blue),)
                ],
              ),
        actions: [
         
        ],),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                   Container(
                        height: 200,
                        decoration: BoxDecoration(
                          
                        
                          image: DecorationImage(image: NetworkImage("https://cdn.pixabay.com/photo/2015/10/29/14/42/law-1012473_960_720.jpg"),fit: BoxFit.cover)
                       
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 130,right: 30),
                        child: Align
                        (
                          alignment: Alignment.bottomRight,
                          child: Text("About CLAT", style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold))),
                      )
                      ],
                ),
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("The Common Law Admission Test (CLAT) is a national-level law entrance exam for admission to 22 national law universities and more than 70 affiliated colleges.\n\n The exam is conducted by the Consortium of National Law Universities (NLUs) in offline, pen and paper format. Candidates who pass the examination will be eligible for admission to 5-year integrated LLB and LLM programmes offered by the participating national law universities.",
                  style: TextStyle(
                    fontSize: 20,
                  
                  ),),
                )
              ],
            ),
          ),
        )),
    );
  }
}