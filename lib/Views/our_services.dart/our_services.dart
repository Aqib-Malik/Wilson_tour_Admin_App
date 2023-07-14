import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wilson_tours_app/utils/color.dart';
import 'package:wilson_tours_app/widgets/banner_widget.dart';

class ServicesPage extends StatelessWidget {
  final List<Map<String, String>> services = [
  
    {
      'title': 'Flights and Transfers',
      'description':
          'For your International flights should be booked by you from your home country or through our Company because we are affiliated to many airline Companies worldwide. Thereafter, we could even make all local and regional flights bookings for you. We also arrange for transfers to and from airports or other places and landing strips so your travel is as smooth as it should be.',
      'imageUrl': 'https://media.istockphoto.com/id/155439315/photo/passenger-airplane-flying-above-clouds-during-sunset.jpg?b=1&s=170667a&w=0&k=20&c=0ptevX36IqBQM1P4PoCycpe8Vj-QAhITR7oNn9R991g=',
    },
      {
      'title': 'Tours and Safaris',
      'description':
          "The difference between a tour and a safari in our part of the world is largely semantic. A useful distinction is that safaris mostly have a significant element of game viewing whereas tours can include photographic, scenic, historical, cultural and specialised aspects of the natural world. For more than 13 years we have been arranging and leading tours and safaris throughout Rwanda and into the East African countries but we extended to almost the whole Africa, The tours we have listed are the tried and tested favourites. We always adjust them to suit each client's needs and the Tour Package’s Level If you are browse through our Tours & Safaris you'll see exactly that. Each and every tour is different and we'd like to make your holidays/Vacations special and unique for you too. With most of our tours and safaris you have the choice of Loop, start shaped or Multicounty open Jew Itineraries to Different Destinations in Africa. The choice will depend on your time, budget and personal preferences. Whatever you have in mind, we'll make that dream a reality.",
      'imageUrl': 'https://media.istockphoto.com/id/697689066/photo/three-giraffe-in-national-park-of-kenya.jpg?b=1&s=170667a&w=0&k=20&c=9Te4-YTHiVOyCL_Ry69akoH8xUDI6ibiqwGEI7LK2FA=',
    },
    {
      'title': 'CONSULTATION',
      'description':
          'We offer consultancy services in human resource management, capacity building, business management, tourism Products Development, conservation and conservation education, Tourism Polices Development, Community Development, Products Blanding & marketing.',
      'imageUrl': 'https://images.unsplash.com/photo-1513530534585-c7b1394c6d51?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8Y29uc3VsdGFudHxlbnwwfHwwfHw%3D&w=1000&q=80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: kPrimaryLightColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            BannerWidget(
              title: 'Our Services',
              imageUrl: 'https://media.istockphoto.com/id/1339455923/photo/tiger-cub-playing-with-mother.jpg?b=1&s=170667a&w=0&k=20&c=JQARRPZ1wAN8E9TjCREvsXQn0g7Hq8I4-lwZISG8qpQ=',
        ),
           SizedBox(height: 10,),
        Container(
          height: Get.height/1.5,
              child: ListView.builder(
                itemCount: services.length,
                itemBuilder: (BuildContext context, int index) {
                  return ServiceTile(
                    title: services[index]['title']!,
                    description: services[index]['description']!,
                    imageUrl: services[index]['imageUrl']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceTile extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  ServiceTile({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            margin: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    title,
                    style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    )),
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    description,
                   style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey[600],
                    )),
                  ),
                ),
                SizedBox(height: 20.0),
                // Padding(
                //   padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
                //   child: TextButton(
                //     onPressed: () {},
                //     child: Text(
                //       'LEARN MORE',
                //       style: TextStyle(
                //         fontSize: 16.0,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.blue,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
