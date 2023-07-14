import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HorizontalCategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('categories').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          final List<String> categories = [];
          final List<IconData> icons = [];
          
          snapshot.data!.docs.forEach((DocumentSnapshot doc) {
            final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            final String name = data['name'] as String;
            final IconData icon = FontAwesomeIcons.marsAndVenus;
            categories.add(name);
            icons.add(icon);
          });

          return Container(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Row(
                      children: [
                        Icon(
                          icons[index],
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: 6),
                        DefaultTextStyle(
                          style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          child: AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              TypewriterAnimatedText(
                                categories[index],
                                speed: Duration(milliseconds: 100),
                                cursor: '_',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}







// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';

// class HorizontalCategoryList extends StatelessWidget {
//   final List<String> categories = [
//     'Bronze',
//     'Silver',
//     'Golden',
//     'Platinum',
//     'Luxreious',
//   ];

//   final List<IconData> icons = [
//     FontAwesomeIcons.marsAndVenus,
//     FontAwesomeIcons.marsAndVenus,
//     FontAwesomeIcons.marsAndVenus,
//     FontAwesomeIcons.marsAndVenus,
//     FontAwesomeIcons.marsAndVenus,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 40,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: categories.length,
//         itemBuilder: (context, index) {
//           return Container(
//             margin: EdgeInsets.symmetric(horizontal: 8),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               child: Row(
//                 children: [
//                   Icon(
//                     icons[index],
//                     color: Colors.white,
//                     size: 16,
//                   ),
//                   SizedBox(width: 6),
//                   DefaultTextStyle(
//                     style: GoogleFonts.quicksand(
//                       textStyle: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12,
//                       ),
//                     ),
//                     child: AnimatedTextKit(
//                       repeatForever: true,
//                       animatedTexts: [
//                         TypewriterAnimatedText(
//                           categories[index],
//                           speed: Duration(milliseconds: 100),
//                           cursor: '_',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             decoration: BoxDecoration(
//               color: Colors.grey[800],
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.2),
//                   offset: Offset(0, 2),
//                   blurRadius: 4,
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
