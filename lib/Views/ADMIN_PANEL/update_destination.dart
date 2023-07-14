import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:wilson_tours_app/utils/color.dart';

class UpdateCountryScreen extends StatefulWidget {
  final String countryId;
  final String initialCountryName;
  final String initialCurrencyUsed;
  final String initialVisaRequirement;
  final double initialArea;
  final File? initialSelectedImage;

  UpdateCountryScreen({
    required this.countryId,
    required this.initialCountryName,
    required this.initialCurrencyUsed,
    required this.initialVisaRequirement,
    required this.initialArea,
    required this.initialSelectedImage,
  });

  @override
  _UpdateCountryScreenState createState() => _UpdateCountryScreenState();
}

class _UpdateCountryScreenState extends State<UpdateCountryScreen> {
  late String countryName;
  late String currencyUsed;
  late String visaRequirement;
  late double area;
  File? selectedImage;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    countryName = widget.initialCountryName;
    currencyUsed = widget.initialCurrencyUsed;
    visaRequirement = widget.initialVisaRequirement;
    area = widget.initialArea;
    selectedImage = widget.initialSelectedImage;
  }

  Future<void> _updateData() async {
    if (countryName.isNotEmpty &&
        currencyUsed.isNotEmpty &&
        visaRequirement.isNotEmpty &&
        selectedImage != null) {
      try {
        // Upload image to Firebase Storage
        final String imageName = DateTime.now().toString();
        final Reference storageReference =
            storage.ref().child('country_images/$imageName.jpg');
        await storageReference.putFile(selectedImage!);
        final String imageUrl = await storageReference.getDownloadURL();

        // Update country details in Firestore
        await firestore.collection('destinations').doc(widget.countryId).update({
          'name': countryName,
          'image_url': imageUrl,
          'currency_used': currencyUsed,
          'visa_requirement': visaRequirement,
          'area': area,
        });

        // Show success message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Country details updated successfully.'),
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
        backgroundColor: GreenColor,
        title: const Text('Update Destination'),
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
              controller: TextEditingController(text: countryName),
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
              controller: TextEditingController(text: currencyUsed),
            ),
            const SizedBox(height: 16.0),
            TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Visa Requirement',
                labelStyle: TextStyle(color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  visaRequirement = value;
                });
              },
              controller: TextEditingController(text: visaRequirement),
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
              controller: TextEditingController(text: area.toString()),
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
              onPressed: _updateData,
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
    );
  }
}
