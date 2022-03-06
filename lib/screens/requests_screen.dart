import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:towigo/model/request_model.dart';
import 'package:towigo/model/user_model.dart';

class Requests extends StatefulWidget {

  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> with SingleTickerProviderStateMixin{
  static String idScreen = "requests";

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  RequestModel userRequests = RequestModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("requests")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.userRequests = RequestModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Requests',
              style: GoogleFonts.raleway(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )
              )
          ),
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: <Widget>[
            Container(
                height: 150.0,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black,Colors.blueAccent]
                    )
                ),
                child: Container(
                  width: double.infinity,
                  height: 60.0,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          child: Image.asset(
                            'assets/images/user_icon.png',
                          ),
                          radius: 50.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text("${loggedInUser.firstName} ${loggedInUser.secondName}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Brand Bold",
                            )),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                )
            ),
            const SizedBox(
              height: 5.0,
            ),
          ],
        )
    );
  }
}