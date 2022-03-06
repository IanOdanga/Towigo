import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:towigo/model/user_model.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin{
  static const String idScreen = "profile";

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile',
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
          new Container(
            width: 300.00,
            color: Color(0xffFFFFFF),
            child: Padding(
              padding: EdgeInsets.only(bottom: 25.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 25.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Text(
                                'Personal Information',
                                style: GoogleFonts.raleway(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                    )
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              _status ? _getEditIcon() : new Container(),
                            ],
                          )
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 25.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                  'First Name',
                                  style: GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.0,
                                      )
                                  )
                              ),
                            ],
                          ),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          left: 25.0, right: 25.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Flexible(
                            child: new TextField(
                              decoration: InputDecoration(
                                hintText: "${loggedInUser.firstName}",
                                hintStyle: TextStyle(
                                  fontSize: 11.0,
                                ),
                              ),
                              enabled: !_status,
                              autofocus: !_status,

                            ),
                          ),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 25.0),
                      child: new Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Text(
                                  'Last Name',
                                  style: GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.0,
                                      )
                                  )
                              ),
                            ],
                          ),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 2.0),
                      child: new Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new Flexible(
                            child: new TextField(
                              decoration: const InputDecoration(
                                  hintText: "Enter your Last Name", hintStyle: TextStyle(
                                fontSize: 11.0,
                              ),),
                              enabled: !_status,
                              autofocus: !_status,
                            ),
                          ),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 25.0),
                      child: new Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Text(
                                  'Mobile',
                                  style: GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.0,
                                      )
                                  )
                              ),
                            ],
                          ),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 2.0),
                      child: new Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new Flexible(
                            child: new TextField(
                              decoration: const InputDecoration(
                                hintText: "Enter Mobile Number",
                                hintStyle: TextStyle(
                                    fontSize: 11.0,
                                ),
                              ),
                              enabled: !_status,
                            ),
                          ),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 1.0),
                      child: new Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 2.0),
                      child: new Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                        ],
                      )),
                  !_status ? _getActionButtons() : new Container(),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Save"),
                    textColor: Colors.white,
                    color: Colors.green.shade600,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Cancel"),
                    textColor: Colors.white,
                    color: Colors.red.shade600,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.blueAccent,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

}