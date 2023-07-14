import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wilson_tours_app/Views/ADMIN_PANEL/country_detail.dart';
import 'package:wilson_tours_app/widgets/banner_widget.dart';
import 'package:wilson_tours_app/Views/tour_page/category_list.dart';
import 'package:wilson_tours_app/utils/color.dart';
import 'package:wilson_tours_app/widgets/card_image.dart';
import 'package:wilson_tours_app/widgets/ecplore_tour_list.dart';

class DestinationPage extends StatefulWidget {
  const DestinationPage({Key? key});

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      body: SafeArea(
        child: Column(
          children: [
            BannerWidget(
              title: 'Our Destinations',
              imageUrl:
                  'https://wilsontoursafrica.com/wp-content/uploads/2021/12/Downloader.la-61a7a0a45647c.jpg',
            ),
            SizedBox(height: 10),
            StreamBuilder<QuerySnapshot>(
              stream: firestore.collection('destinations').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final destinations = snapshot.data!.docs;

                  return Container(
                    height: Get.height / 1.7,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: destinations.length,
                      itemBuilder: (context, index) {
                        final destination =
                            destinations[index].data() as Map<String, dynamic>;
                        final imageUrl = destination['image_url'];
                        final countryName = destination['name'];

                        return InkWell(
                          onTap: (){
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
                            widthh: 0.5,
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
