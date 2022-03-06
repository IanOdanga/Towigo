import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:towigo/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:towigo/screens/profile_page.dart';
import 'package:towigo/screens/requests_screen.dart';
import 'package:towigo/screens/search_screen.dart';
import 'package:towigo/screens/service_request_screen.dart';
import 'package:towigo/screens/settings_screen.dart';
import 'package:towigo/screens/spares_screen.dart';
import 'package:towigo/screens/tow_request_screen.dart';

import 'legal_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  final _advancedDrawerController = AdvancedDrawerController();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
        backdropColor: Colors.black,
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
            boxShadow: <BoxShadow>[
            BoxShadow(
            color: Colors.black12,
            blurRadius: 0.0,
              ),
          ],
    borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('TOWIGO', style: TextStyle(fontFamily: "Brand Bold"),),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          backgroundColor: const Color.fromRGBO(47, 11, 118, 1),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 35,
              ),
              Text("Choose your option to continue.,",
                  style: TextStyle(fontSize: 16, fontFamily: "Brand Bold", fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TowingRequest()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.purple.shade50,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 100,
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.truckPickup,
                                size: 45,
                                color: Colors.deepPurpleAccent,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Towing",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: "Brand Bold",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SparePartsScreen()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 100,
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.car,
                                size: 45,
                                color: Colors.green[700],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Spare Parts",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: "Brand Bold",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      drawer: SafeArea(
        child: Container(
          width: 32.0,
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 128.0,
                    height: 32.0,
                    margin: const EdgeInsets.only(
                      top: 24.0,
                      bottom: 64.0,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/user_icon.png',
                    ),
                  ),
                  Text("Welcome ${loggedInUser.firstName} ${loggedInUser.secondName}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Brand Bold",
                      )),
                  Spacer(),
                  ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
                    },
                    leading: Icon(Icons.account_circle_rounded),
                    title: Text('Profile', style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: Colors.white,

                        )
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Requests()));
                    },
                    leading: Icon(Icons.car_repair),
                    title: Text('Requests',
                      style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                      color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
                    },
                    leading: Icon(Icons.settings),
                    title: Text('Settings',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Legal()));
                    },
                    leading: Icon(Icons.info_rounded),
                    title: Text('Legal',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white54,
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 16.0,
                      ),
                      child: Text('Terms of Service | Privacy Policy',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  GestureDetector(
                    onTap: (){
                      logout(context);
                    },
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Logout',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
