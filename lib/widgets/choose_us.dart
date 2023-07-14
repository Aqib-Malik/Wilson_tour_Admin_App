import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhyChooseUsWidget extends StatelessWidget {
  const WhyChooseUsWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  icon,
                  color: Colors.brown,
                  size: 20,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                        style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                              // fontStyle: FontStyle.italic,
                            
                              fontSize: 16,
                        color: Colors.brown,
                            ),
                          ),
                  
                    ),
                    SizedBox(height: 8),
                    Text(
                      description,
                       style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                              // fontStyle: FontStyle.italic,
                            fontSize: 14,
                        color: Colors.grey[600],
                            ),
                          ),
                     
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
