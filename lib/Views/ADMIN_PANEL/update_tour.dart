
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wilson_tours_app/utils/color.dart';
import 'package:get/get.dart';

class UpdateTourScreen extends StatefulWidget {
    final String tourId;
      const UpdateTourScreen({required this.tourId});


  @override
  _UpdateTourScreenState createState() => _UpdateTourScreenState();
}

class _UpdateTourScreenState extends State<UpdateTourScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String title = '';
  double price = 0.0;
  int minimumAge = 0;
  double pricePerPerson = 0.0;
  List<dynamic> tourHighlights = [];
  List<dynamic> includedPoints = [];
  List<dynamic> excludedPoints = [];
  File? selectedImage;
  String? selectedCategory;
  List<String> categoryValues = [];
  DateTime? selectedDate;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    fetchCategoryValues();
    setState(() {
      var data=Get.arguments;
      title=data['title'];
      price=data['price'];
      minimumAge=data['minimum_age'];
      pricePerPerson=data['price_per_person'];
      selectedCategory=data['category'];
      tourHighlights = data['tour_highlights'];
      includedPoints = data['included_points'];
      excludedPoints = data['excluded_points'];
      print( data['tour_highlights'].join(', '))
;    });
  }

  Future<void> fetchCategoryValues() async {
    final QuerySnapshot snapshot = await firestore.collection('categories').get();
    final List<String> values = snapshot.docs.map((doc) => (doc.data() as Map<String, dynamic>)['name'] as String).toList();
    setState(() {
      categoryValues = values;
    });
  }

  Future<void> _uploadData() async {
    if (_formKey.currentState!.validate() && selectedImage != null) {
      _formKey.currentState!.save();
      try {
        // Upload image to Firebase Storage
        final String imageName = DateTime.now().toString();
        final Reference storageReference = storage.ref().child('product_images/$imageName.jpg');
        await storageReference.putFile(selectedImage!);
        final String imageUrl = await storageReference.getDownloadURL();

        // Save product details to Firestore
        await firestore.collection('products').doc(widget.tourId).update({
          'title': title,
          'price': price,
          'minimum_age': minimumAge,
          'price_per_person': pricePerPerson,
          'tour_highlights': tourHighlights,
          'included_points': includedPoints,
          'excluded_points': excludedPoints,
          'image_url': imageUrl,
          'category': selectedCategory,
          'date': selectedDate,
        });

        // Reset form fields
        setState(() {
          title = '';
          price = 0.0;
          minimumAge = 0;
          pricePerPerson = 0.0;
          tourHighlights = [];
          includedPoints = [];
          excludedPoints = [];
          selectedImage = null;
          selectedCategory = null;
          selectedDate = null;
        });

        // Show success message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Tour details updated successfully.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('An error occurred: $e'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GreenColor,
        title: const Text('Update Tour Data'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: title,
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: price.toString(),
                onChanged: (value) {
                  setState(() {
                    price = double.tryParse(value) ?? 0.0;
                  });
                },
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a price';
                  }
                  final double? parsedValue = double.tryParse(value);
                  if (parsedValue == null || parsedValue <= 0) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: minimumAge.toString(),
                onChanged: (value) {
                  setState(() {
                    minimumAge = int.tryParse(value) ?? 0;
                  });
                },
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a minimum age';
                  }
                  final int? parsedValue = int.tryParse(value);
                  if (parsedValue == null || parsedValue <= 0) {
                    return 'Please enter a valid minimum age';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Minimum Age',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: pricePerPerson.toString(),
                onChanged: (value) {
                  setState(() {
                    pricePerPerson = double.tryParse(value) ?? 0.0;
                  });
                },
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a price per person';
                  }
                  final double? parsedValue = double.tryParse(value);
                  if (parsedValue == null || parsedValue <= 0) {
                    return 'Please enter a valid price per person';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Price per Person',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
  initialValue: tourHighlights.join(', '), // Use join() instead of toString()
  onChanged: (value) {
    setState(() {
      tourHighlights = value.split(',').map((String highlight) => highlight.trim()).toList();
    });
  },
  validator: (value) {
    if (value!.isEmpty) {
      return 'Please enter tour highlights';
    }
    return null;
  },
  decoration: InputDecoration(
    labelText: 'Tour Highlights (comma-separated)',
  ),
),
              const SizedBox(height: 16.0),
              TextFormField(
  initialValue: includedPoints.join(', '), // Use join() instead of toString()

                onChanged: (value) {
                  setState(() {
                    includedPoints = value.split(',').map((String point) => point.trim()).toList();
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter included points';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Included Points (comma-separated)',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
  initialValue: excludedPoints.join(', '), // Use join() instead of toString()

                onChanged: (value) {
                  setState(() {
                    excludedPoints = value.split(',').map((String point) => point.trim()).toList();
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter excluded points';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Excluded Points (comma-separated)',
                ),
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                onChanged: (String? value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Category',
                ),
                items: categoryValues.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
                readOnly: true,
                controller: TextEditingController(
                  text: selectedDate != null ? selectedDate.toString().split(' ')[0] : '',
                ),
                validator: (value) {
                  if (selectedDate == null) {
                    return 'Please select a date';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Date',
                ),
              ),
              const SizedBox(height: 16.0),
              if (selectedImage != null) Image.file(selectedImage!),
              const SizedBox(height: 16.0),
              NeumorphicButton(
                onPressed: _pickImage,
                style: NeumorphicStyle(
                  color: Colors.grey[200],
                  boxShape: NeumorphicBoxShape.stadium(),
                ),
                child: const Text('Select Image'),
              ),
              const SizedBox(height: 16.0),
              NeumorphicButton(
                onPressed: _uploadData,
                style: NeumorphicStyle(
                  color: GreenColor,
                  boxShape: NeumorphicBoxShape.stadium(),
                ),
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
