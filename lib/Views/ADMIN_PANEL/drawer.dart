import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wilson_tours_app/Views/ADMIN_PANEL/add_country.dart';
import 'package:wilson_tours_app/Views/ADMIN_PANEL/add_service.dart';
import 'package:wilson_tours_app/Views/ADMIN_PANEL/add_tour.dart';
import 'package:wilson_tours_app/Views/ADMIN_PANEL/order_page.dart';
import 'package:wilson_tours_app/Views/ADMIN_PANEL/add_product.dart';

class CustomDrawer extends StatefulWidget {
  final AnimationController animationController;

  const CustomDrawer({Key? key, required this.animationController})
      : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget? child) {
        double slide = 200 * widget.animationController.value;
        double scale = 1 - (0.3 * widget.animationController.value);
        return Transform(
          transform: Matrix4.identity()
            ..translate(slide)
            ..scale(scale),
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 200,
            child: Neumorphic(
              style: NeumorphicStyle(
                depth: -10,
                intensity: 1,
                // color: Theme.of(context).backgroundColor,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(16),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 32),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Admin User',
                    style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.dashboard),
                    title: Text(
                      'Dashboard',
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.tour),
                    title: Text(
                      'Add Tour',
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    onTap: () {Get.to(AddProductScreen());},
                  ),
                  
                  ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: Text(
                      'Orders',
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    onTap: () {
                       Get.to(OrderPage());
                    },
                  ),
                  // ListTile(
                  //   leading: Icon(Icons.supervised_user_circle_sharp),
                  //   title: Text(
                  //     'Add services',
                  //     style: GoogleFonts.quicksand(
                  //       textStyle: TextStyle(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.black87,
                  //       ),
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     Get.to(AddServicePage());
                  //   },
                  // ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.place),
                    title: Text(
                      'Add Destination',
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.to(AddCountryScreen());
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

