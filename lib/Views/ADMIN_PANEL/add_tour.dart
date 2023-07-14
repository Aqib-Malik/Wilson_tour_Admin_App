import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wilson_tours_app/utils/color.dart';

class AddTourPage extends StatefulWidget {
  @override
  _AddTourPageState createState() => _AddTourPageState();
}

class _AddTourPageState extends State<AddTourPage> {
  final _formKey = GlobalKey<FormState>();
  final _imagePicker = ImagePicker();
  List<Description> _descriptions = [
    Description(
      title: 'Title 1',
      description: 'Description 1',
    ),
    Description(
      title: 'Title 2',
      description: 'Description 2',
    ),
    Description(
      title: 'Title 3',
      description: 'Description 3',
    ),
  ];
  List<Price> _prices = [
    Price(price: 50.0, rate: 4.5, newRate: 5.0, discount: 10.0),
    Price(price: 75.0, rate: 4.0, newRate: 4.5, discount: 5.0),
    Price(price: 100.0, rate: 3.5, newRate: 4.0, discount: 15.0),
  ];

  List<String> categories = ['Category 1', 'Category 2', 'Category 3'];
  int _numOfItems = 1;
  File? _featureImage;
  List<File> _slideshowImages = [];
  List<String> _imageDescriptions = [];

  String? _videoLink;
  int _minGuests = 1;
  int _maxGuests = 1;
  int _numItems = 1;

  DateTime _availableFromDate = DateTime.now();
  DateTime _availableToDate = DateTime.now();

  String? _selectedCategory;

  String? _objectCode;
  String? _address;
  double? _latitude;
  double? _longitude;

  double? _fixedDepositAmount;
  double? _price;
  double? _newRate;
  double? _discount;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String _category = categories[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text('Add Tour'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title textfield
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),

                // Content textfield
                TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Content',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter content';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),

                // Feature Image section
                Text(
                  'Feature Image',
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                // Add Feature Image button
                NeumorphicButton(
                  onPressed: () async {
                    final pickedFile = await _imagePicker.getImage(
                      source: ImageSource.gallery,
                    );

                    if (pickedFile != null) {
                      setState(() {
                        _featureImage = File(pickedFile.path);
                      });
                    }
                  },
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(8.0),
                    ),
                    depth: 4,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_photo_alternate),
                      SizedBox(width: 8.0),
                      Text('Add Feature Image'),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),

                // Slideshow Images section
                Text(
                  'Slideshow Images',
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
// Add Slideshow Image button
                NeumorphicButton(
                  onPressed: () async {
                    final pickedFile = await _imagePicker.getImage(
                      source: ImageSource.gallery,
                    );

                    if (pickedFile != null) {
                      setState(() {
                        _slideshowImages.add(File(pickedFile.path));
                        _imageDescriptions.add('');
                      });
                    }
                  },
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(8.0),
                    ),
                    depth: 4,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_photo_alternate),
                      SizedBox(width: 8.0),
                      Text('Add Slideshow Image'),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),

                // Slideshow Image Descriptions section
                for (int i = 0; i < _slideshowImages.length; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Slideshow Image ${i + 1} Description',
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      // Add Slideshow Image Description textfield
                      TextFormField(
                        onChanged: (value) {
                          _imageDescriptions[i] = value;
                        },
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Description',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                    ],
                  ),

                // Video Link textfield
                TextFormField(
                  onChanged: (value) {
                    _videoLink = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Video Link',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),

                // Minimum Guests counter
                Row(
                  children: [
                    Text(
                      'Minimum Guests',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    // Minimum Guests counter
                    NeumorphicButton(
                      onPressed: () {
                        setState(() {
                          _minGuests = (_minGuests > 1) ? _minGuests - 1 : 1;
                        });
                      },
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.circle(),
                        depth: 4,
                      ),
                      padding: EdgeInsets.all(16.0),
                      child: Icon(Icons.remove),
                    ),
                    SizedBox(width: 16.0),
                    Text(
                      '$_minGuests',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    // Maximum Guests counter
                    NeumorphicButton(
                      onPressed: () {
                        setState(() {
                          _minGuests++;
                        });
                      },
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        // boxShape: NeumorphicBoxShape.circle,
                        depth: 4,
                      ),
                      padding: EdgeInsets.all(16.0),
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
                SizedBox(height: 16.0), // Maximum Guests counter
                Row(
                  children: [
                    Text(
                      'Maximum Guests',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    // Maximum Guests counter
                    NeumorphicButton(
                      onPressed: () {
                        setState(() {
                          _maxGuests--;
                        });
                      },
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.circle(),
                        depth: 4,
                      ),
                      padding: EdgeInsets.all(16.0),
                      child: Icon(Icons.remove),
                    ),
                    SizedBox(width: 16.0),
                    Text(
                      '$_maxGuests',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    NeumorphicButton(
                      onPressed: () {
                        setState(() {
                          _maxGuests++;
                        });
                      },
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.circle(),
                        depth: 4,
                      ),
                      padding: EdgeInsets.all(16.0),
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),

                // Category dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: 'Select Category',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  value: _selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: 'Category 1',
                      child: Text('Category 1'),
                    ),
                    DropdownMenuItem(
                      value: 'Category 2',
                      child: Text('Category 2'),
                    ),
                    DropdownMenuItem(
                      value: 'Category 3',
                      child: Text('Category 3'),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),

                // Number of items textfield
                TextFormField(
                  onChanged: (value) {
                    _numOfItems = int.tryParse(value) ?? 1;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Number of Items',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),

                // Object Code textfield
                TextFormField(
                  onChanged: (value) {
                    _objectCode = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Object Code (Unique)',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),

                // Address section
                Text(
                  'Address',
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                // Address textfield
                TextFormField(
                  onChanged: (value) {
                    _address = value;
                  },
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Address',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                // Latitude and Longitude textfields
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          _latitude = double.tryParse(value) ?? 0.0;
                        },
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Latitude',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          _longitude = double.tryParse(value) ?? 0.0;
                        },
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Longitude',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),

                // Prices section
                Text(
                  'Prices',
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                // Fixed Deposit amount textfield
                TextFormField(
                  onChanged: (value) {
                    _fixedDepositAmount = double.tryParse(value) ?? 0.0;
                  },
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Fixed Deposit Amount',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                // Prices textfields
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _prices.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              _prices[index].price =
                                  double.tryParse(value) ?? 0.0;
                            },
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Price ${index + 1}',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              _prices[index].rate =
                                  double.tryParse(value) ?? 0.0;
                            },
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Rate ${index + 1}',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              _prices[index].newRate =
                                  double.tryParse(value) ?? 0.0;
                            },
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: InputDecoration(
                              hintText: 'New Rate ${index + 1}',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              _prices[index].discount =
                                  double.tryParse(value) ?? 0.0;
                            },
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Discount ${index + 1}',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _prices.removeAt(index);
                            });
                          },
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 8.0),
// Add prices button
                ElevatedButton(
                   style: ElevatedButton.styleFrom(
                    primary: bgColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _prices.add(
                        Price(
                          price: 0.0,
                          rate: 0.0,
                          newRate: 0.0,
                          discount: 0.0,
                        ),
                      );
                    });
                  },
                  child: Text('Add Prices'),
                ),
                SizedBox(height: 16.0),
                // Description section
                Text(
                  'Description',
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  onChanged: (value) {
                    // _descriptionTitle = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Description Title',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  onChanged: (value) {
                    // _description = value;
                  },
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                // Add description button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: bgColor,
                  ),
                  onPressed: () {
                    setState(() {
                      // _descriptions.add(
                      //   Description(
                      //     title: _descriptionTitle,
                      //     description: _description,
                      //   ),
                      // );
                      // _descriptionTitle = '';
                      // _description = '';
                    });
                  },
                  child: Text('Add Description'),
                ),
                SizedBox(height: 8.0),
                // Descriptions list
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _descriptions.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _descriptions[index].title ?? '',
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          _descriptions[index].description ?? '',
                          style: GoogleFonts.quicksand(
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                // setState(() {
                                //   _descriptionTitle =
                                //       _descriptions[index].title ?? '';
                                //   _description =
                                //       _descriptions[index].description ?? '';
                                //   _descriptions.removeAt(index);
                                // });
                              },
                              child: Text('Edit'),
                            ),
                            SizedBox(width: 8.0),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  _descriptions.removeAt(index);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 16.0),

                // Save button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: bgColor,
                  ),
                  onPressed: () {},
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Price {
  double price;
  double rate;
  double newRate;
  double discount;

  Price({
    this.price = 0.0,
    this.rate = 0.0,
    this.newRate = 0.0,
    this.discount = 0.0,
  });
}

class Description {
  String? title;
  String? description;

  Description({
    this.title,
    this.description,
  });
}

class ImageItem {
  String? imageUrl;
  String? description;

  ImageItem({
    this.imageUrl,
    this.description,
  });
}

class Address {
  String? address;
  double? latitude;
  double? longitude;

  Address({
    this.address,
    this.latitude,
    this.longitude,
  });
}
