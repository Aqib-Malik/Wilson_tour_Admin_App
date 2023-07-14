import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:wilson_tours_app/Views/ADMIN_PANEL/update_destination.dart';
import 'package:wilson_tours_app/utils/color.dart';

class CountryDetailScreen extends StatelessWidget {
  final String countryId;

  CountryDetailScreen({required this.countryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text('Country Details'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('destinations')
            .doc(countryId)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var countryData = snapshot.data!.data() as Map<String, dynamic>; // Cast to Map<String, dynamic>
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Overview',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Neumorphic(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                      depth: 4,
                      intensity: 0.8,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          countryData['image_url'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                       SizedBox(height: 16),
                     SizedBox(height: 24),
                  ..._buildDetailRow('Name', Icons.title, '${countryData['name']}', bgColor),
                  SizedBox(height: 24),
                  ..._buildDetailRow('Currency Used', Icons.monetization_on, '${countryData['currency_used']}', bgColor),
                  SizedBox(height: 24),
                  ..._buildDetailRow('Visa Requirement', Icons.assignment, '${countryData['visa_requirement']}', bgColor),
                  SizedBox(height: 24),
                  ..._buildDetailRow('Area', Icons.public, '${countryData['area']} km²', bgColor),
                  SizedBox(height: 24),
                  ..._buildDetailRow('Description', Icons.description, '${countryData['description']}', bgColor),
                  SizedBox(height: 24),
                  ..._buildDetailRow('Languages Spoken', Icons.language_sharp, '${countryData['languages_spoken']}', bgColor),
                  SizedBox(height: 24),
                  
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                           NeumorphicButton(
                 onPressed: () {
                              // Perform delete operation
                                showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Delete Destination'),
                            content: Text(
                                'Are you sure you want to delete this Destination?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                  .collection('destinations')
                                  .doc(countryId)
                                  .delete();
                              Navigator.pop(context); // Navigate back to the previous screen
                               Navigator.pop(context); 
                                },
                                child: Text('Delete'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                            ],
                          );
                        },
                      );
                             
                            },
                style: NeumorphicStyle(
                  color: Color.fromARGB(255, 232, 14, 14),
                  boxShape: NeumorphicBoxShape.stadium(),
                ),
                child:  Text('Delete',style: TextStyle(color: Colors.white),),
              ),
                            NeumorphicButton(
                  onPressed: () {
                              // Navigate to the update screen
                             Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => UpdateCountryScreen(
      countryId: countryId,
      initialCountryName: countryData['name'],
      initialCurrencyUsed: countryData['currency_used'],
      initialVisaRequirement:countryData['visa_requirement'],
      initialArea: countryData['area'],
      initialSelectedImage:  null,
    ),
  ),
);
                            },
                style: NeumorphicStyle(
                  color: bgColor,
                  boxShape: NeumorphicBoxShape.stadium(),
                ),
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
              ),

                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

List<Widget> _buildDetailRow(String title, IconData icon, String value, Color color) {
    return [
      Row(
        children: [
          Icon(icon, color: color),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      SizedBox(height: 8),
      Text(
        value,
        style: TextStyle(fontSize: 16),
      ),
      SizedBox(height: 16),
    ];
  }

}
