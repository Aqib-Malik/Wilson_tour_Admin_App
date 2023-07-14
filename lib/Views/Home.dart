// import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:wilson_tours_app/Views/ADMIN_PANEL/country_detail.dart';
import 'package:wilson_tours_app/Views/tour_page/tour_detail_page.dart';
import 'package:wilson_tours_app/common_widgets/common_widgets.dart';
import 'package:wilson_tours_app/common_widgets/destination_widget.dart';
import 'package:wilson_tours_app/utils/color.dart';
import 'package:wilson_tours_app/widgets/card_image.dart';
import 'package:wilson_tours_app/widgets/choose_us.dart';
import 'package:wilson_tours_app/widgets/ecplore_tour_list.dart';
import 'package:wilson_tours_app/widgets/image_list.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wilson_tours_app/widgets/small_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List slides = [
    "https://wilsontoursafrica.com/wp-content/uploads/2023/01/5edfb9a14c3501.jpg",
    "https://wilsontoursafrica.com/wp-content/uploads/2023/01/Specials_01.jpg",
    "https://wilsontoursafrica.com/wp-content/uploads/2023/01/Why-Botswana_Elephant1.jpg"

    //   "https://wilsontoursafrica.com/wp-content/uploads/2021/12/Downloader.la-61a7b15fd2bf6.jpg",
    //   "https://wilsontoursafrica.com/wp-content/uploads/2021/11/Downloader.la-6197821630b0a.jpg",
    // "https://wilsontoursafrica.com/wp-content/uploads/2021/11/Downloader.la-619786e4bbb3f.jpg",
    // "https://wilsontoursafrica.com/wp-content/uploads/2021/11/Downloader.la-619e0d6d3a6f1.jpg",
    // "https://wilsontoursafrica.com/wp-content/uploads/2021/12/Downloader.la-61a7b27f71698.jpg",
    // "https://wilsontoursafrica.com/wp-content/uploads/2021/11/Downloader.la-619786e4bbb3f.jpg",
  ];
  CarouselController carouselController = new CarouselController();
  int carouselIndex = 0;
   final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: CommonWdget.appbar("Home"),
      body: SafeArea(
          child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    // color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "WELCOME TO",
                          style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                              // fontStyle: FontStyle.italic,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "AFRICA!",
                          style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                              // fontStyle: FontStyle.italic,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CarouselSlider.builder(
                        carouselController: carouselController,
                        itemCount: slides.length,
                        itemBuilder: (BuildContext context, int index,
                            int pageViewIndex) {
                          return Container(
                            // height: kIsWeb ? Get.height / 1.5 : Get.height / 3,
                            // width: kIsWeb ? Get.width / 2 : Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        slides.elementAt(index).toString()))),
                          );
                        },
                        options: CarouselOptions(
                            height:
                                // kIsWeb ? 420 :
                                200,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 2),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 1700),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, carouselReason) {
                              setState(() {
                                carouselIndex = index;
                              });
                            })),
                  ),
                  CarouselIndicator(
                    color: Colors.grey,
                    activeColor: Colors.black,
                    width: Get.width * 0.05,
                    height: 2,
                    count: slides.length,
                    index: carouselIndex,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        Text(
                          "Explore tours",
                          style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "The planet’s greatest game lands, Africa’s warmhearted people, and its mesmerizing landscapes, revealed gracefully, thoughtfully, and joyously by the Africa’s Greatest Tour Company.",
                          style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Our Destination",
                    style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
  height: 200,
  child: StreamBuilder<QuerySnapshot>(
    stream: firestore.collection('destinations').snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final destinations = snapshot.data!.docs;

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: destinations.length,
          itemBuilder: (context, index) {
            final destination =
                destinations[index].data() as Map<String, dynamic>;
            final imageUrl = destination['image_url'];
            final countryName = destination['name'];

            return InkWell(
              onTap: (){
                // Replace the onPressed function in the code where the country is selected


  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CountryDetailScreen(countryId: destinations[index].id),
    ),
  );


              },
              child: CustomCard(
                imageUrl: imageUrl,
                title: countryName,
                widthh: 0.4,
              ),
            );
          },
        );
      } else {
        return Center(child: CircularProgressIndicator()); // or any placeholder widget
      }
    },
  ),
),

                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "DISCOVER AFRICA WITH US",
                    style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  HorizontalListWidget(),
                  SizedBox(
                    height: 20,
                  ),

                    Container(
  height: 200,
  child: StreamBuilder<QuerySnapshot>(
    stream: firestore.collection('products').snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final destinations = snapshot.data!.docs;

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: destinations.length,
          itemBuilder: (context, index) {
            final destination =
                destinations[index].data() as Map<String, dynamic>;
            final imageUrl = destination['image_url'];
                      String headingText = destination['title'];
                      String price = destination['price'].toString();

            return InkWell(
              onTap: (){
                Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => TourDetailScreen(tourId: destinations[index].id),
  ),
);
              },
              child: ProductWidget(
                          imageUrl: imageUrl,
                          tagText:destination['is_featured']? 'Featured':'',
                          headingText: headingText,
                          icons: [
                            Icons.calendar_today,
                            Icons.person,
                            Icons.camera_alt_outlined
                          ],
                          iconText: ['22 days', '4', '4'],
                          price: '\$ $price',
                        ),
            );
          },
        );
      } else {
        return Center(child: CircularProgressIndicator()); // or any placeholder widget
      }
    },
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
        ),
      )),
    );
  }
}
