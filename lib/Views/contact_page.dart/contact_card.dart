import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wilson_tours_app/utils/color.dart';

class ContactCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace the data source with your own model or database
    final dataSource = {
      'address': 'Kigali, Rwanda , Car Free Zone Ruma House 2 Floor.',
      'phone': '+250 788 850 725',
      'email': 'info@wilsontoursafrica.com',
      'businessHours': 'Mon- Sat: 9:00 AM - 18:00 PM',
    };

    return Neumorphic(
      style: NeumorphicStyle(
        depth: 5,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16)),
        color: Colors.grey[200],
        shadowLightColor: Colors.white,
        shadowDarkColor: Colors.grey[400],
        shape: NeumorphicShape.flat,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        color: Colors.white54
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 20,
                    color: bgColor,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Address:',
                     style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ],
              ),
              SizedBox(height: 8),
              Text(
                dataSource['address'] ?? 'N/A',
                 style: GoogleFonts.quicksand(
                            textStyle:  TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                )),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    Icons.phone_outlined,
                    size: 20,
                    color: bgColor,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Phone:',
                    style: GoogleFonts.quicksand(
                            textStyle:  TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    )),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                dataSource['phone'] ?? 'N/A',
                style: GoogleFonts.quicksand(
                            textStyle:  TextStyle(
                  fontSize: 14,
                  color: bgColor,
                )),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    Icons.email_outlined,
                    size: 20,
                    color: bgColor,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Email:',
                     style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    )),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                dataSource['email'] ?? 'N/A',
                style: GoogleFonts.quicksand(
                            textStyle:  TextStyle(
                  fontSize: 14,
                  color: bgColor,
                )),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    Icons.access_time_outlined,
                    size: 20,
                     color: bgColor,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Business Hours:',
                     style: GoogleFonts.quicksand(
                            textStyle:  TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                  ),
            ]),  SizedBox(height: 8),
              Text(
                dataSource['businessHours'] ?? 'N/A',
                 style: GoogleFonts.quicksand(
                            textStyle:  TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                )),
              ),
            
          ],
        ),
      ),
     ) );
  }
}
