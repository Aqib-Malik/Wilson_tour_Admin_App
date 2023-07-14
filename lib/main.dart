
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wilson_tours_app/Views/ADMIN_PANEL/add_country.dart';
import 'package:wilson_tours_app/Views/ADMIN_PANEL/dashboard.dart';
import 'package:wilson_tours_app/Views/Splash_screen.dart';
import 'package:wilson_tours_app/Views/ADMIN_PANEL/add_product.dart';
import 'package:wilson_tours_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  
  runApp(
    GetMaterialApp(
      theme: ThemeData(
    fontFamily: GoogleFonts.quicksand().fontFamily,
  ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body:
        // AddProductScreen(),
        //AddCountryScreen(), 
        // SplashScreenView(),
        Dashboardd()
      ),
    ),
  );
}