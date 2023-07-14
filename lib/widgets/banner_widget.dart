import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BannerWidget extends StatelessWidget {
  final String title;
  final String imageUrl;

  BannerWidget({required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                      color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                            ),
                          ),
                  
             
            ),
          ),
        ),
      ),
    );
  }
}
