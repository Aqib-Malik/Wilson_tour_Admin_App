import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wilson_tours_app/utils/color.dart';

class AddServicePage extends StatefulWidget {
  @override
  _AddServicePageState createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  bool _isMandatory = false;
  bool _isConditional = false;
  String _selectedPriceType = 'Fixed Price';
  String _selectedServiceType = 'Tour Guide';
  int _selectedMaxQuantity = 10;
 bool _allowQuantity = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _conditionalPriceController = TextEditingController();
  TextEditingController _maxQuantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Service',
          style: GoogleFonts.quicksand(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title',
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Neumorphic(
                  style: NeumorphicStyle(
                    depth: 2,
                    color: Colors.white,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(12),
                    ),
                  ),
                  child: TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: InputBorder.none,
                      hintText: 'Enter service title',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter service title';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Content',
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Neumorphic(
  style: NeumorphicStyle(
    depth: 2,
    color: Colors.white,
    boxShape: NeumorphicBoxShape.roundRect(
      BorderRadius.circular(12),
    ),
  ),
  child: TextFormField(
    controller: _contentController,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      border: InputBorder.none,
      hintText: 'Enter service content',
      hintStyle: TextStyle(
        fontSize: 14,
        color: Colors.grey,
      ),
    ),
    maxLines: 5, // Set maxLines to 5 for a bigger field
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter service content';
      }
      return null;
    },
  ),
),

                SizedBox(height: 16),
                Text('Service Type'),
                SizedBox(height: 8),
                Wrap(
                  spacing: 16,
                  children: [
                    ChoiceChip(
                      label: Text(
                        'Per Booking',
                        style: TextStyle(
                          color: _selectedServiceType == 'Per Booking'
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                      selected: _selectedServiceType == 'Per Booking',
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedServiceType = 'Per Booking';
                        });
                      },
                      backgroundColor: Colors.grey[200],
                      selectedColor: Theme.of(context).primaryColor,
                    ),
                    ChoiceChip(
                      label: Text(
                        'Per Person',
                        style: TextStyle(
                          color: _selectedServiceType == 'Per Person'
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                      selected: _selectedServiceType == 'Per Person',
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedServiceType = 'Per Person';
                        });
                      },
                      backgroundColor: Colors.grey[200],
                      selectedColor: Theme.of(context).primaryColor,
                    ),
                    ChoiceChip(
                      label: Text(
                        'Per Day',
                        style: TextStyle(
                          color: _selectedServiceType == 'Per Day'
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                      selected: _selectedServiceType == 'Per Day',
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedServiceType = 'Per Day';
                        });
                      },
                      backgroundColor: Colors.grey[200],
                      selectedColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Price Type',
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Neumorphic(
                  style: NeumorphicStyle(
                    depth: 2,
                    color: Colors.white,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(12),
                    ),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _selectedPriceType,
                    items: [
                      DropdownMenuItem(
                        value: 'Fixed Price',
                        child: Text('Fixed Price'),
                      ),
                      DropdownMenuItem(
                        value: 'Price per Person',
                        child: Text('Price per Person'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedPriceType = value!;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Prices by Age',
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Neumorphic(
                  style: NeumorphicStyle(
                    depth: 2,
                    color: Colors.white,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(12),
                    ),
                  ),
                  child: TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: InputBorder.none,
                      hintText: 'Enter prices by age',
                      // hint
                      // Style: GoogleFonts.quicksand(
                      //   textStyle: TextStyle(
                      //     fontSize: 14,
                      //     color: Colors.black87,
                      //   ),
                      // ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter prices by age';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Conditional Prices',
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Neumorphic(
                  style: NeumorphicStyle(
                    depth: 2,
                    color: Colors.white,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(12),
                    ),
                  ),
                  child: TextFormField(
                    controller: _conditionalPriceController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: InputBorder.none,
                      hintText: 'Enter conditional prices',
                      hintStyle: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter conditional prices';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: _isMandatory,
                      onChanged: (value) {
                        setState(() {
                          _isMandatory = value!;
                        });
                      },
                    ),
                    Text(
                      'Is Mandatory',
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Allow to select quantity',
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Radio(
                      value: 'Yes',
                      groupValue: _allowQuantity,
                      onChanged: (value) {
                        setState(() {
                          _allowQuantity = value.toString() as bool;
                        });
                      },
                    ),
                    Text(
                      'Yes',
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Radio(
                      value: 'No',
                      groupValue: _allowQuantity,
                      onChanged: (value) {
                        setState(() {
                          _allowQuantity = value.toString() as bool;
                        });
                      },
                    ),
                    Text(
                      'No',
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Maximum Quantity',
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Neumorphic(
                  style: NeumorphicStyle(
                    depth: 2,
                    color: Colors.white,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(12),
                    ),
                  ),
                  child: TextFormField(
                    controller: _maxQuantityController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: InputBorder.none,
                      hintText: 'Enter maximum quantity',
                      hintStyle: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter maximum quantity';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // _saveService();
                    }
                  },
                  child: Text(
                    'Save',
                    style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: bgColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ServiceType {
  final String title;
  bool isSelected;

  _ServiceType({
    required this.title,
    this.isSelected = false,
  });
}
