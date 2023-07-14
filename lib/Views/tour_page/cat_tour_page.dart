import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wilson_tours_app/Views/ADMIN_PANEL/update_tour.dart';
import 'package:wilson_tours_app/Views/tour_page/tour_detail_page.dart';
import 'package:wilson_tours_app/widgets/banner_widget.dart';

enum TourSorting {
  Date,
  Title,
}

class CatTourPage extends StatefulWidget {
  final String cat;
  const CatTourPage({Key? key, required this.cat}) : super(key: key);

  @override
  State<CatTourPage> createState() => _CatTourPageState();
}

class _CatTourPageState extends State<CatTourPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> _productsStream;
  String _searchText = '';
  TourSorting _selectedSorting = TourSorting.Date;

  @override
  void initState() {
    super.initState();
    _productsStream = firestore.collection('products').where('category' , isEqualTo: this.widget.cat).snapshots();
  }

  void _onSearchTextChanged(String text) {
    setState(() {
      _searchText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BannerWidget(
                title: 'Tour Packages',
                imageUrl:
                    'https://wilsontoursafrica.com/wp-content/uploads/2021/12/group-of-people-white-water-rafting-472596858-5acb4f406bf0690037e3e0aa-5c40b8b4c9e77c00010dbdba-820x520.jpg',
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Sort by:'),
                    SizedBox(width: 8),
                    DropdownButton<TourSorting>(
                      value: _selectedSorting,
                      onChanged: (TourSorting? newValue) {
                        setState(() {
                          _selectedSorting = newValue!;
                        });
                      },
                      items:
                          TourSorting.values.map<DropdownMenuItem<TourSorting>>(
                        (TourSorting value) {
                          return DropdownMenuItem<TourSorting>(
                            value: value,
                            child: Text(
                              value == TourSorting.Date ? 'Date' : 'Title',
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Neumorphic(
                  style: NeumorphicStyle(
                    depth: -4,
                    intensity: 1,
                    boxShape: NeumorphicBoxShape.stadium(),
                  ),
                  child: TextField(
                    onChanged: _onSearchTextChanged,
                    decoration: InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 290,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _productsStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final products = snapshot.data!.docs;
                      final filteredProducts = products
                          .where((product) => product['title']
                              .toLowerCase()
                              .contains(_searchText.toLowerCase()))
                          .toList();

                      // Sort the filtered products based on the selected sorting option
                      switch (_selectedSorting) {
                        case TourSorting.Date:
                          filteredProducts.sort((a, b) {
                            final Timestamp timestampA = a['date'];
                            final Timestamp timestampB = b['date'];
                            final DateTime dateA = timestampA.toDate();
                            final DateTime dateB = timestampB.toDate();
                            return dateA.compareTo(dateB);
                          });
                          break;
                        case TourSorting.Title:
                          filteredProducts.sort((a, b) {
                            final String titleA = a['title'];
                            final String titleB = b['title'];
                            return titleA.compareTo(titleB);
                          });
                          break;
                      }

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index].data()
                              as Map<String, dynamic>;
                          final imageUrl = product['image_url'];
                          final headingText = product['title'];
                          final price = product['price'].toString();
                          final timestamp = product['date'];

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TourDetailScreen(
                                    tourId: filteredProducts[index].id,
                                  ),
                                ),
                              );
                            },
                            child: ProductWidget(
                              imageUrl: imageUrl,
                              tagText:product['is_featured']? 'Featured':'' ,
                              headingText: headingText,
                              icons: [
                                Icons.calendar_today,
                                Icons.person,
                                Icons.camera_alt_outlined
                              ],
                              iconText: [
                                DateFormat('yyyy-MM-dd')
                                    .format(timestamp.toDate()),
                                '4',
                                '4'
                              ],
                              price: '\$ $price',
                              onDelete: () async {
                                await FirebaseFirestore.instance
                                    .collection('products')
                                    .doc(filteredProducts[index].id)
                                    .delete();
                              },
                              onUpdate: () {
                               Get.to(UpdateTourScreen(
                                        tourId: filteredProducts[index].id),arguments:filteredProducts[index] );
                              },
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductWidget extends StatelessWidget {
  final String imageUrl;
  final String tagText;
  final String headingText;
  final List<IconData> icons;
  final List<String> iconText;
  final String price;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  const ProductWidget({
    required this.imageUrl,
    required this.tagText,
    required this.headingText,
    required this.icons,
    required this.iconText,
    required this.price,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tagText,
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Delete Tour'),
                            content: Text(
                                'Are you sure you want to delete this Tour?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  onDelete();
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
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  IconButton(
                    onPressed: onUpdate,
                    icon: Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            headingText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 4),
          Row(
            children: [
              for (int i = 0; i < icons.length; i++)
                Row(
                  children: [
                    Icon(
                      icons[i],
                      size: 16,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 2),
                    Text(
                      iconText[i],
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            price,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
