import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:wilson_tours_app/utils/color.dart';

class AddCategoryPage extends StatefulWidget {
  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _iconController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _addCategory() async {
    String name = _nameController.text;
    String icon = _iconController.text;
    double price = double.parse(_priceController.text);

    // Add category data to Firebase
    await _firestore.collection('categories').add({
      'name': name,
      'icon': icon,
      'price': price,
    });

    // Clear text fields after adding category
    _nameController.clear();
    _iconController.clear();
    _priceController.clear();

    // Show a success message
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Category added successfully.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GreenColor,
        title: Text('Add Category'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Category Name'),
            ),
            TextFormField(
              controller: _iconController,
              decoration: InputDecoration(labelText: 'Icon'),
            ),
            TextFormField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            SizedBox(height: 16.0),
            // TextButton(
            //   child: Text('Add Category'),
            //   onPressed: _addCategory,
            // ),
             NeumorphicButton(
              onPressed: _addCategory,
              style: NeumorphicStyle(
                color: GreenColor,
                boxShape: NeumorphicBoxShape.stadium(),
              ),
              child:  Text('Upload',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
