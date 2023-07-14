import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:wilson_tours_app/Views/tour_page/cat_tour_page.dart';
import 'package:wilson_tours_app/utils/color.dart';

class HorizontalListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('categories').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          final List<String> items = [];
          final List<double> prices = [];
          
          snapshot.data!.docs.forEach((DocumentSnapshot doc) {
            final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            final String name = data['name'] as String;
            final double price = data['price'] as double;
            items.add(name);
            prices.add(price);
          });

          return SizedBox(
            height: 80.0,
            child: ListView.builder(
              reverse: true,
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){
                    Get.to(CatTourPage(cat: items[index],));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Neumorphic(
                      style: NeumorphicStyle(
                        depth: 4.0,
                        color: Color.fromARGB(255, 240, 248, 240),
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12.0)),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 12.0),
                          items[index]=='Silver'?
                          Image.asset("assets/cat_silver_icon.jpeg", height: 36.0,width: 36.0, ):
                          items[index]=='Golden'?Image.asset("assets/gold.jpeg", height: 36.0,width: 36.0, ):
                          items[index]=='Platinum'?Image.asset("assets/plat.jpeg", height: 36.0,width: 36.0, ):
                          items[index]=='Luxurious'?Image.asset("assets/lux.jpeg", height: 36.0,width: 36.0, ):
                          items[index]=='Bronze'?Image.asset("assets/bro.jpeg", height: 36.0,width: 36.0, ):Icon(Icons.category,size: 36,),
                          SizedBox(width: 12.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(items[index], style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 4.0),
                              Text("\$${prices[index].toStringAsFixed(2)}", style: TextStyle(fontSize: 12.0)),
                            ],
                          ),
                          SizedBox(width: 12.0),
                        ],
                      ),
                    ),
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
