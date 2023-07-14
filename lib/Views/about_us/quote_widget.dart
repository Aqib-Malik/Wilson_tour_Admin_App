import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

class QuoteWidget extends StatelessWidget {
  final String title;
  final String quote;
  final IconData icon;
  final String authorName;
  final String authorImage;

  QuoteWidget({
    required this.title,
    required this.quote,
    required this.icon,
    required this.authorName,
    required this.authorImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://media.istockphoto.com/id/1398999646/photo/circular-white-chat-bubbles-sitting-on-blue-background.jpg?b=1&s=170667a&w=0&k=20&c=OSb2ZRMEhnGvhI19qkVupT1osfOQtPiNwQ48kSRk-Fo=',
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Neumorphic(
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          depth: 5,
          intensity: 0.5,
          lightSource: LightSource.topLeft,
          color: Colors.white,
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.quicksand(
                          textStyle:TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )),
                ),
                Icon(
                  icon,
                  color: Colors.grey,
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              quote,
              style: GoogleFonts.quicksand(
                          textStyle:TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
              )),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Neumorphic(
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    depth: -5,
                    intensity: 0.7,
                  ),
                  padding: EdgeInsets.all(8),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(authorImage),
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  authorName,
                   style: GoogleFonts.quicksand(
                          textStyle:TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
