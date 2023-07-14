import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:wilson_tours_app/utils/color.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class TourDetailScreen extends StatefulWidget {
  final String tourId;

  TourDetailScreen({required this.tourId});

  @override
  _TourDetailScreenState createState() => _TourDetailScreenState();
}

class _TourDetailScreenState extends State<TourDetailScreen> {
  int numberOfTickets = 1;

TextEditingController emailController = TextEditingController();


  void _showBookingDialog(BuildContext context, Map<String, dynamic> tourData) {
    // Variables to store the selected date and time
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: Neumorphic(
                style: NeumorphicStyle(
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(8.0)),
                ),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Book Now',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Tickets'),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    if (numberOfTickets > 1) {
                                      numberOfTickets--;
                                    }
                                  });
                                },
                              ),
                              Text(numberOfTickets.toString()),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    numberOfTickets++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          NeumorphicText(
                            'Total: \$${tourData['price'] * numberOfTickets}',
                            style: NeumorphicStyle(
                                depth: 2,
                                color: Colors
                                    .black // Control the depth/shadow of the text
                                ),
                            textStyle: NeumorphicTextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NeumorphicText(
                            'Select Date',
                            style: NeumorphicStyle(
                                depth: 2,
                                color: Colors
                                    .black // Control the depth/shadow of the text
                                ),
                            textStyle: NeumorphicTextStyle(
                              fontSize: 16,
                            ),
                          ),
                          // Text('Select Date'),
                          InkWell(
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  selectedDate = pickedDate;
                                });
                              }
                            },
                            child: Neumorphic(
                              style: NeumorphicStyle(
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(4.0)),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                selectedDate.toString().split(' ')[0],
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text('Select Time'),
                          NeumorphicText(
                            'Select Time',
                            style: NeumorphicStyle(
                                depth: 2,
                                color: Colors
                                    .black // Control the depth/shadow of the text
                                ),
                            textStyle: NeumorphicTextStyle(
                              fontSize: 16,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              final TimeOfDay? pickedTime =
                                  await showTimePicker(
                                context: context,
                                initialTime: selectedTime,
                              );
                              if (pickedTime != null) {
                                setState(() {
                                  selectedTime = pickedTime;
                                });
                              }
                            },
                            child: Neumorphic(
                              style: NeumorphicStyle(
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(4.0)),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                selectedTime.format(context),
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                     
                 
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          NeumorphicButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: NeumorphicStyle(
                              color: Colors.grey[200],
                              boxShape: NeumorphicBoxShape.stadium(),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          NeumorphicButton(
                            onPressed: () {
                                                         _saveBookingDetails(context, tourData, selectedDate, selectedTime);

                            },
                            style: NeumorphicStyle(
                              color: bgColor,
                              boxShape: NeumorphicBoxShape.stadium(),
                            ),
                            child: Text(
                              'Book Now',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }



void _saveBookingDetails(BuildContext context, Map<String, dynamic> tourData, DateTime selectedDate, TimeOfDay selectedTime) {
  // Combine the selected date and time into a single DateTime object
  DateTime bookingDateTime = DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
    selectedTime.hour,
    selectedTime.minute,
  );

  // Prepare the booking data to be saved to the database
  Map<String, dynamic> bookingData = {
    'tourId': widget.tourId,
    'date': bookingDateTime.toIso8601String(),
    'numberOfTickets': numberOfTickets,
    'isApprove':false,
    'total':tourData['price'] * numberOfTickets,
    'title':tourData['title']
    // Add any additional booking details you want to save
  };

  // Save the booking data to the database
  FirebaseFirestore.instance
      .collection('bookings')
      .add(bookingData)
      .then((value) async{
    // Booking details saved successfully
    print('Booking saved to database');
    // Send the booking details via email
    String bookingDetails = _buildBookingDetailsString(bookingData);
    await _sendEmail(bookingDetails);


    // Show a snackbar to indicate successful booking
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Booking successfully saved'),
      ),
    );
    Get.back();
  })
  .catchError((error) {
    // Error occurred while saving booking details
    print('Error saving booking to database: $error');

    // Show a snackbar to indicate error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error saving booking'),
      ),
    );
  });
}

String _buildBookingDetailsString(Map<String, dynamic> bookingData) {
  // Construct the email body with the booking details
  // Customize this string according to your desired email format
  String bookingDetails = '''
    Tour ID: ${bookingData['tourId']}
    Date: ${bookingData['date']}
    Number of Tickets: ${bookingData['numberOfTickets']}
    Total: ${bookingData['total']}
    Title: ${bookingData['title']}
    ''';

  return bookingDetails;
}

Future<void> _sendEmail(String bookingDetails) async {
  final Email email = Email(
    body: bookingDetails,
    subject: 'Booking Details',
    recipients: ['info@wilsontoursafrica.com'],
    isHTML: false,
  );

  await FlutterEmailSender.send(email);
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text('Tour Description'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('products')
            .doc(widget.tourId)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
              child: Text('Tour not found'),
            );
          }

          final tourData = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  tourData['image_url'],
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
                SizedBox(height: 16.0),
                Text(
                  tourData['title'],
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
               Row(
  children: [
    Icon(Icons.monetization_on,color: bgColor,), // Price icon
    SizedBox(width: 4.0),
    Text(
      'Price: \$${tourData['price']}',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  ],
),
SizedBox(height: 8.0),
Row(
  children: [
    Icon(Icons.person,color: bgColor), // Minimum age icon
    SizedBox(width: 4.0),
    Text(
      'Minimum Age: ${tourData['minimum_age']}',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  ],
),
// SizedBox(height: 8.0),
// Row(
//   children: [
//     Icon(Icons.monetization_on,color: bgColor), // Price per person icon
//     SizedBox(width: 4.0),
//     Text(
//       'Price per Person: \$${tourData['price_per_person']}',
//       style: TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//   ],
// ),
SizedBox(height: 8.0),
Row(
  children: [
    Icon(Icons.category,color: bgColor), // Category icon
    SizedBox(width: 4.0),
    Text(
      'Category: ${tourData['category']}',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  ],
),

SizedBox(height: 8.0),
Row(
  children: [
    Icon(Icons.date_range_sharp,color: bgColor), // Category icon
    SizedBox(width: 4.0),
    Text(
      'Days: ${tourData['days']}',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  ],
),

                
                SizedBox(height: 16.0),
                Text(
          'Tour Highlights',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            tourData['tour_highlights'].length,
            (index) => Row(
              children: [
                NeumorphicIcon(
                  Icons.check,
                  size: 16,
                  style: NeumorphicStyle(
                    color: Colors.green,
                  ),
                ),
                SizedBox(width: 4.0),
                Text(
                  tourData['tour_highlights'][index],
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      
    
                 SizedBox(height: 16.0),
                 Text(
          'Included',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            tourData['included_points'].length,
            (index) => Row(
              children: [
                NeumorphicIcon(
                  Icons.check,
                  size: 16,
                  style: NeumorphicStyle(
                    color: Colors.green,
                  ),
                ),
                SizedBox(width: 4.0),
                Text(
                  tourData['included_points'][index],
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      SizedBox(height: 16.0),
                Text(
          'Excluded',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            tourData['excluded_points'].length,
            (index) => Row(
              children: [
                NeumorphicIcon(
                  Icons.close,
                  size: 16,
                  style: NeumorphicStyle(
                    color: Colors.red,
                  ),
                ),
                SizedBox(width: 4.0),
                Text(
                  tourData['excluded_points'][index],
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),  SizedBox(height: 16.0),
                 NeumorphicButton(
              onPressed: (){
                 _showBookingDialog(context, tourData);
              },
              style: NeumorphicStyle(
                color: bgColor,
                boxShape: NeumorphicBoxShape.stadium(),
              ),
              child: const Text(
                'Book Now',
                style: TextStyle(color: Colors.white),
              ),
            ),
                
              ],
            ),
          );
        },
      ),
    );
  }
}
