import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:wilson_tours_app/utils/color.dart';

class AddCountryScreen extends StatefulWidget {
  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<AddCountryScreen> {
  String languagesSpoken = '';

  String countryName = '';
  String currencyUsed = '';
  String visaRequirement = '';
  double area = 0.0;
  File? selectedImage;
  String description = '';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> _uploadData() async {
    if (countryName.isNotEmpty &&
      selectedImage != null &&
      currencyUsed.isNotEmpty &&
      visaRequirement.isNotEmpty &&
      description.isNotEmpty) {
      try {
        // Upload image to Firebase Storage
        final String imageName = DateTime.now().toString();
        final Reference storageReference =
            storage.ref().child('country_images/$imageName.jpg');
        await storageReference.putFile(selectedImage!);
        final String imageUrl = await storageReference.getDownloadURL();

        // Save country details to Firestore
      await firestore.collection('destinations').add({
  'name': countryName,
  'image_url': imageUrl,
  'currency_used': currencyUsed,
  'visa_requirement': visaRequirement,
  'area': area,
  'description': description,
  'languages_spoken': languagesSpoken, // Add this line
});


        // Reset form fields
        setState(() {
          countryName = '';
          currencyUsed = '';
          visaRequirement = '';
          area = 0.0;
          selectedImage = null;
        });

        // Show success message
       showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: const Text('Uploaded'),
      content: const Text('Destination uploaded'),
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
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Incomplete Data'),
            content: const Text('Please fill in all required fields and select an image.'),
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
        backgroundColor: bgColor,
        title: const Text('Add Destination'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Country Name',
                labelStyle: TextStyle(color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  countryName = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Currency Used',
                labelStyle: TextStyle(color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  currencyUsed = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
TextField(
  style: TextStyle(color: Colors.black),
  decoration: InputDecoration(
    labelText: 'Languages Spoken',
    labelStyle: TextStyle(color: Colors.grey),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
    ),
  ),
  onChanged: (value) {
    setState(() {
      languagesSpoken = value;
    });
  },
),
            const SizedBox(height: 16.0),
            TextFormField(
  style: TextStyle(color: Colors.black),
  decoration: InputDecoration(
    labelText: 'Visa Requirement',
    labelStyle: TextStyle(color: Colors.grey),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
    ),
  ),
  keyboardType: TextInputType.multiline,  // Enables multiline input
  maxLines: null,  // Allows the text field to expand dynamically
  onChanged: (value) {
    setState(() {
      visaRequirement = value;
    });
  },
),

            const SizedBox(height: 16.0),
            TextField(
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Area (km2)',
                labelStyle: TextStyle(color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  area = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: 'Description',
        labelStyle: TextStyle(color: Colors.grey),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      onChanged: (value) {
        setState(() {
          description = value;
        });
      },
    ),
      const SizedBox(height: 16.0),
            if (selectedImage != null)
              Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.file(selectedImage!),
                ),
              ),
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
                color: bgColor,
                boxShape: NeumorphicBoxShape.stadium(),
              ),
              child: const Text(
                'Upload',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
