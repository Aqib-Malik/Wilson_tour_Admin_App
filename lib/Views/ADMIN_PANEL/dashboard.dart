
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:wilson_tours_app/Views/ADMIN_PANEL/add_category.dart';
import 'package:wilson_tours_app/Views/ADMIN_PANEL/add_country.dart';
import 'package:wilson_tours_app/Views/ADMIN_PANEL/add_service.dart';
import 'package:wilson_tours_app/Views/ADMIN_PANEL/contact_form_messages.dart';
import 'package:wilson_tours_app/Views/ADMIN_PANEL/drawer.dart';
import 'package:wilson_tours_app/Views/ADMIN_PANEL/order_page.dart';
import 'package:wilson_tours_app/Views/Bottom_nav_bar.dart';
import 'package:wilson_tours_app/Views/ADMIN_PANEL/add_product.dart';
import 'package:wilson_tours_app/utils/color.dart';

class Dashboardd extends StatefulWidget {
  @override
  State<Dashboardd> createState() => _DashboarddState();
}

class _DashboarddState extends State<Dashboardd>with SingleTickerProviderStateMixin{
    late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: bgColor,
          title: Text('Dashboard'),
        ),
      ),
        drawer: CustomDrawer(
        animationController: _animationController,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: Get.height/0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top section
                Container(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/logo.png',
                            height: 48,
                          ),
                          SizedBox(width: 8),
                          NeumorphicText(
                            'Admin Panel',
                            style: NeumorphicStyle(
                              depth: 5,
                              color: Color.fromARGB(255, 161, 159, 159),
                            ),
                            textStyle: NeumorphicTextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      NeumorphicText(
                        'Welcome back',
                        style: NeumorphicStyle(
                          depth: 3,
                          color: Colors.grey[400],
                        ),
                        textStyle: NeumorphicTextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                // Menu section
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          buildMenuItem(
                              context, 'Home', Icons.home, () {
                                    Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BottomNavBar(),
                              ),
                            );
                                
                              }),
                               SizedBox(height: 16),
                         
                          buildMenuItem(
                              context, 'Add Destinations', Icons.tour,  () {Get.to(AddCountryScreen());},),
                            
                          SizedBox(height: 16),
                         
                          buildMenuItem(
                              context, 'Contact Messages', Icons.contact_mail,  () {Get.to(ContactFormScreen());},),
                          SizedBox(height: 16),
                         
                          buildMenuItem(
                              context, 'Add Tour', Icons.tour,  () {Get.to(AddProductScreen());},),
                          SizedBox(height: 16),
                          buildMenuItem(context, 'Orders', Icons.shopping_cart,
                              () {
                             
                       Get.to(OrderPage());
                    
                          }),
                          // SizedBox(height: 16),
                          // buildMenuItem(context, 'Add services', Icons.supervised_user_circle_sharp,
                          //     () {
                          //   Get.to(AddServicePage());
                          // }),
                           SizedBox(height: 16),
                           buildMenuItem(context, 'Add category', Icons.category,
                              () {
                            Get.to(AddCategoryPage());
                          }),
                          
                        
                        ],
                      ),
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

  Widget buildMenuItem(
      BuildContext context, String title, IconData icon, VoidCallback ontap) {
    return NeumorphicButton(
      onPressed: () {
        ontap();
      },
      style: NeumorphicStyle(
        depth: 3,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
      ),
      child: ListTile(
        leading: Icon(icon,color: bgColor,),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
