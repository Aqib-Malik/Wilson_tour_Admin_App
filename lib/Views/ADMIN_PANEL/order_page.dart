// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class OrderPage extends StatefulWidget {
//   @override
//   _OrderPageState createState() => _OrderPageState();
// }

// class _OrderPageState extends State<OrderPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Orders'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('bookings').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<Order> orders = snapshot.data!.docs.map((doc) {
//               Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//               return Order(
//                 orderNum: doc.id,
//                 items: [data['title']],
//                 dateFrom: DateTime.parse(data['date']).toString(),
//                 dateTo: '',
//                 guest: data['numberOfTickets'],
//                 totalAmount: data['total'],
//                 status: data['isApprove']
//                     ? OrderStatus.Confirmed
//                     : OrderStatus.Available,
//               );
//             }).toList();

//             return ListView.builder(
//               itemCount: orders.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   // Build your list tile UI here
//                   // Use orders[index] to access individual order data
//                 );
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             return CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }
// }

// enum OrderStatus {
//   Available,
//   Confirmed,
//   Rejected,
// }

// class Order {
//   final String orderNum;
//   final List<String> items;
//   final String dateFrom;
//   final String dateTo;
//   final int guest;
//   final double totalAmount;
//   OrderStatus status;

//   Order({
//     required this.orderNum,
//     required this.items,
//     required this.dateFrom,
//     required this.dateTo,
//     required this.guest,
//     required this.totalAmount,
//     required this.status,
//   });
// }







import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:wilson_tours_app/utils/color.dart';


class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<Order> _orders = [];
  

  @override
  void initState() {
    super.initState();
    _fetchOrdersData();
  }

  Future<void> _fetchOrdersData() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('bookings').get();
    List<Order> fetchedOrders = snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Order(
        orderNum: doc.id,
        items: [data['title']],
        dateFrom: DateTime.parse(data['date']).toString(),
        dateTo: '',
        guest: data['numberOfTickets'],
        totalAmount:data['total'],
        status: data['isApprove'] ? OrderStatus.Confirmed : OrderStatus.Available,
      );
    }).toList();

    setState(() {
      _orders = fetchedOrders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text('Orders'),
      ),
      body: ListView.builder(
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          return Neumorphic(
            margin: EdgeInsets.all(8),
            style: NeumorphicStyle(
              depth: 2,
              color: Colors.white,
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(12),
              ),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: Text(
                  (index+1).toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    _orders[index].items.join(', '),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'From: ${_orders[index].dateFrom}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Total Tickets: ${_orders[index].guest.toString()} Total Amount: \$${_orders[index].totalAmount.toString()}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                 IconButton(
  icon: Icon(Icons.check),
  onPressed: () async {
    setState(() {
      _orders[index].status = OrderStatus.Confirmed;
    });

    try {
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(_orders[index].orderNum)
          .update({'isApprove': true});
           ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Approved')),
    );
    } catch (e) {
      // Handle any error that occurred during the update
      print('Error updating status: $e');
    }
  },
  color: _orders[index].status == OrderStatus.Available
      ? Colors.green
      : Colors.grey,
),
SizedBox(width: 16),
IconButton(
  icon: Icon(Icons.clear),
  onPressed: () async {
    setState(() {
      _orders[index].status = OrderStatus.Rejected;
    });

    try {
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(_orders[index].orderNum)
          .delete();
          Get.back();
           ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Rejected')),
    );
    } catch (e) {
      // Handle any error that occurred during the update
      print('Error updating status: $e');
    }
  },
  color: _orders[index].status == OrderStatus.Confirmed
      ? Colors.red
      : Colors.grey,
),


                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

enum OrderStatus {
  Available,
  Confirmed,
  Rejected,
}

class Order {
  final String orderNum;
  final List<String> items;
  final String dateFrom;
  final String dateTo;
  final int guest;
  final double totalAmount;
   OrderStatus status;

  Order({
    required this.orderNum,
    required this.items,
    required this.dateFrom,
    required this.dateTo,
    required this.guest,
    required this.totalAmount,
    required this.status,
  });
}
