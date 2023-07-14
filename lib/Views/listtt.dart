import 'package:flutter/material.dart';

class WhyChooseUsWidget extends StatelessWidget {
  final List<WhyChooseUsItem> items;

  WhyChooseUsWidget({required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: items
          .map((item) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item.icon,
                    size: 32.0,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    item.heading,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    item.description,
                    textAlign: TextAlign.center,
                  ),
                ],
              ))
          .toList(),
    );
  }
}

class WhyChooseUsItem {
  final IconData icon;
  final String heading;
  final String description;

  WhyChooseUsItem(
      {required this.icon, required this.heading, required this.description});
}
