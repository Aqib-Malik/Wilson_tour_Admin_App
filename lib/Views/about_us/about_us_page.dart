import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wilson_tours_app/Views/about_us/quote_widget.dart';
import 'package:wilson_tours_app/Views/about_us/title_description.dart';
import 'package:wilson_tours_app/widgets/banner_widget.dart';
import 'package:wilson_tours_app/Views/tour_page/category_list.dart';
import 'package:wilson_tours_app/utils/color.dart';
import 'package:wilson_tours_app/widgets/card_image.dart';
import 'package:wilson_tours_app/widgets/ecplore_tour_list.dart';

import '../../widgets/choose_us.dart';

class AboutUSPage extends StatefulWidget {
  const AboutUSPage({super.key});

  @override
  State<AboutUSPage> createState() => _AboutUSPageState();
}

class _AboutUSPageState extends State<AboutUSPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
          
              BannerWidget(
              title: 'About Us',
              imageUrl: 'https://wilsontoursafrica.com/wp-content/uploads/2021/11/Downloader.la-61979d1489938.jpg',
              ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Container(
            height: 1000,
            child: Center(
            child: NeumorphicCard(
              title: 'Our Story',
              description: """Wilson Tours Travel Agency Ltd is a Company that is licenced by RDB (Rwanda Development Board and member of RTTA (Rwanda Tour and Travel association ) founded in 2013 by HABIMANA Wilson who was passionate about tourism since his childhood, after getting graduated from the  University of Tourism, Technology and Business Studies (UTB) He started a company, the main objectives were to Promote Domestic Tourism in Rwanda, Creating many jobs to the locals, Developing other tourism products and teaching the importance of tourism to the local communities (meaning a champion of Domestic Tourism in Rwanda), then soon after getting successful He decided to extend the borders to call the tourists from worldwide to come and enjoy the biodiversity of cultures and wildlife of Africa.
          
          Wilson Tours Travel Agency ltd now is an outstanding tour company combining the best service with the most customized and tailor-made tour packages(Loop, Star shaped and multi-county open Jew itineraries) designed according to our clients’ needs (budget-oriented or higher-end, natural or manmade focus, etc.). We have several years of experience working with individual tourists, groups of tourists, journalists, documentary filmmakers, university researchers, UN organizations, embassies,
          and etc……""",
            ),
                ),),
        ),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: QuoteWidget(
          title: 'The word of Founder',
          quote: '"Be the change you wish to see in the world."',
          icon: Icons.format_quote,
          authorName: 'Wilson Habimana',
          authorImage: 'https://wilsontoursafrica.com/wp-content/uploads/2021/12/WhatsApp-Image-2019-11-18-at-20.23.35.jpeg',
        ),
        ),
         const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Why Choose Us",
                    style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),
                  

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WhyChooseUsWidget(
                    icon: Icons.money_off,
                    title: 'Competitive Pricing',
                    description: 'Affordable and Quality Life Experience Tour Packages',
                  ),
                  ),
Padding(
  padding: const EdgeInsets.all(8.0),
  child:   WhyChooseUsWidget(
  
    icon: Icons.location_on,
  
    title: 'Africa Coverage',
  
    description: 'With Over 20+ Destinations in Africa ,Exprole Africa with us',
  
  ),
),
Padding(
  padding: const EdgeInsets.all(8.0),
  child:   WhyChooseUsWidget(
  
    icon: Icons.check_circle,
  
    title: 'Fast Booking',
  
    description: 'Seamless and Fast Booking ,Easily Book a tour package',
  
  ),
),
Padding(
  padding: const EdgeInsets.all(8.0),
  child:   WhyChooseUsWidget(
  
    icon: Icons.check_circle,
  
    title: 'Guided Tours',
  
    description: 'Travel with Experienced Tour Guides with Wilson Tours',
  
  ),
),

             
                ],
          ),
        ),
      ),
    );
  }
}