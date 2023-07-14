import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wilson_tours_app/Views/contact_page.dart/contact_card.dart';
import 'package:wilson_tours_app/Views/contact_page.dart/contactform.dart';
import 'package:wilson_tours_app/widgets/banner_widget.dart';
import 'package:wilson_tours_app/Views/tour_page/category_list.dart';
import 'package:wilson_tours_app/utils/color.dart';
import 'package:wilson_tours_app/widgets/card_image.dart';
import 'package:wilson_tours_app/widgets/ecplore_tour_list.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
          
              BannerWidget(
              title: 'Contact',
              imageUrl: 'https://wilsontoursafrica.com/wp-content/uploads/2021/11/Downloader.la-619786e4bbb3f.jpg',
              ),
        SizedBox(height: 10,),
        
                        Text(
                          "Contact Form",
                          style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
              Container(
          height: Get.height/1.3,
          
          child: ContactForm()),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: ContactCard(
          ),
          ),
           Container(
            height: 200,
             child: Stack(
                 children: [
                   CachedNetworkImage(
                     imageUrl: 'https://lahorerealestate.com/wp-content/uploads/2018/02/Google-Maps.jpg',
                     fit: BoxFit.cover,
                   ),
                   Positioned(
                     left: 100,
                     top: 200,
                     child: Icon(Icons.location_on, color: Colors.red, size: 50),
                   ),
                 ],
               ),
           )

        
        
          
                ],
          ),
        ),
      ),
    );
  }
}