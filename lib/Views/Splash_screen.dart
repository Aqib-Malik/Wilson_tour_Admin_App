// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wilson_tours_app/Views/Bottom_nav_bar.dart';
import 'package:wilson_tours_app/utils/color.dart';

String? finalemail;

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({key}) : super(key: key);

  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 7), () {
      Get.off(BottomNavBar());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          Container(
            height: Get.height,
            
            child: Image.asset("assets/zarafa.jpg",fit: BoxFit.cover,)),
            Positioned(

              top: 80,
              left: Get.width/3.5,
              
              child: Image.asset("assets/logo.png",)),

               Positioned(

              bottom: 80,
              left: 40,
              
              child:Container(
                decoration: new BoxDecoration(
              color: Colors.green,
              borderRadius: new BorderRadius.all(
               Radius.circular(10.0),
              )
            ),
                // color: Colors.green,
                    // color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
    AnimatedTextKit(
  animatedTexts: [
    TyperAnimatedText(
      'Hi!',
      textStyle: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.amber,
      ),
      speed: Duration(milliseconds: 300),
    ),
    FadeAnimatedText(
      'Welcome to Africa',
      textStyle: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        color: Colors.amber,
      ),
      duration: Duration(milliseconds: 2000),
    ),
    ScaleAnimatedText(
      'Get ready to explore',
      textStyle: TextStyle(
        color: Colors.amber,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
      duration: Duration(milliseconds: 2000),
    ),
  ],


  
),
                      
                      
                      //  Text(
                      //   "WELCOME TO AFRICA!",
                      //   style: GoogleFonts.quicksand(
                      //     textStyle: TextStyle(
                      //       // fontStyle: FontStyle.italic,
                      //       fontSize: 18,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.amber,
                      //     ),
                      //   ),
                      // ),
                    ),
                  ),
                  )
        ],
      ),
    );
  }
}
