import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wilson_tours_app/utils/color.dart';

class ProductWidget extends StatelessWidget {
  final String imageUrl;
  final String tagText;
  final String headingText;
  final List<IconData> icons;
  final List<String> iconText;
  final String price;

  const ProductWidget({
    required this.imageUrl,
    required this.tagText,
    required this.headingText,
    required this.icons,
    required this.iconText,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            child: Image.network(
              imageUrl,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               tagText==''?SizedBox(): Container(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [GreenColor, Colors.greenAccent],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    tagText.toUpperCase(),
                     style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                            fontSize: 14,
                        color: kPrimaryLightColor,
                            ),
                          ),
                  
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  headingText,
                   style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                               fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                            ),
                          ),
                 
                ),
                SizedBox(height: 10),
                Row(
                  children: List.generate(
                    icons.length,
                    (index) => Row(
                      children: [
                        Icon(icons[index], size: 16),
                        SizedBox(width: 4),
                        Text(
                          iconText[index],
                          style: TextStyle(fontSize: 12),
                        ),
                        if (index != icons.length - 1) SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  price,
                   style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                              fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    letterSpacing: 0.5,
                            ),
                          ),
                 
                ),
                Spacer(),
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [GreenColor, Colors.greenAccent],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Explore',
                       style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                              color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                            ),
                          ),
                     
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
