import 'package:flutter/material.dart';

class DestinayionWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String navigationKey;

  DestinayionWidget(this.title, this.navigationKey, this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 70,
      // width: 70,
        alignment: Alignment.center,
        child: Card(
          color:  Colors.amber,
          elevation: 5,
          child: InkWell(
            onTap: () {
              // navigateToView(context, navigationKey);
            },
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Image.network(
                      "https://wilsontoursafrica.com/wp-content/uploads/2023/01/5edfb9a14c3501.jpg",
                      color: Colors.white,
                      width: 35,
                      height: 35,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    verticalDirection: VerticalDirection.up,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.black.withOpacity(.2),
                        child: Text(
                          title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

}