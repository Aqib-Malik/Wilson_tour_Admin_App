import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:wilson_tours_app/Views/Home.dart';
import 'package:wilson_tours_app/Views/contact_page.dart/contact_page.dart';
import 'package:wilson_tours_app/Views/destination_page.dart';
import 'package:wilson_tours_app/Views/tour_page/tour_page.dart';
import 'package:wilson_tours_app/utils/color.dart';

import 'about_us/about_us_page.dart';
import 'our_services.dart/our_services.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  var pagesAll = [
    const Home(),
     TourPage(),
    const DestinationPage(),
    ServicesPage(),
    const ContactPage(),
    AboutUSPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
  backgroundColor: bgColor,
  height: 50, // Reduce the height of the ConvexAppBar widget
  items: <TabItem>[
    TabItem(icon: Icons.home, title: 'Home'),
    TabItem(icon: Icons.tour, title: 'Tour'),
    TabItem(icon: Icons.stop_circle_outlined, title: 'Dest'),
    TabItem(icon: Icons.category, title: 'Services'),
    TabItem(icon: Icons.contact_phone, title: 'Contact'),
    TabItem(icon: Icons.info, title: 'About'),
  ],
  onTap: (int index) {
    setState(() {
      _page = index;
    });
  },
)
,      body: SafeArea(
        child: pagesAll[_page],
      ),
    );
  }
}
