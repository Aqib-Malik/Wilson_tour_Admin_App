import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wilson_tours_app/Views/ADMIN_PANEL/drawer.dart';

class AdminPanelPage extends StatefulWidget {
  const AdminPanelPage({Key? key}) : super(key: key);

  @override
  _AdminPanelPageState createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage>
    with SingleTickerProviderStateMixin {
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
      appBar: AppBar(
        title: Text(
          'Admin Panel',
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
      drawer: CustomDrawer(
        animationController: _animationController,
      ),
      body: Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Neumorphic(
                  style: NeumorphicStyle(
                    depth: 8,
                    boxShape: NeumorphicBoxShape.circle(),
                    border: NeumorphicBorder(
                      color: Colors.grey[400]!,
                      width: 1.5,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[200]!,
                    radius: 50,
                    child: Icon(
                      Icons.account_circle,
                      size: 60,
                      color: Colors.grey[400]!,
                    ),
                  ),
                ),
                
                SizedBox(height: 20),
                TypewriterAnimatedTextKit(
                  speed: Duration(milliseconds: 100),
                  textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                  text: ['Welcome to Admin Panel'],
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
