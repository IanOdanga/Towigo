import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:towigo/Assistant/assistant_methods.dart';
import 'package:towigo/Assistant/request_assistant.dart';
import 'package:towigo/Data%20Handler/app_data.dart';
import 'package:towigo/Screens/search_screen.dart';
import 'package:towigo/model/request_model.dart';
import 'package:towigo/screens/service_request_screen.dart';
import 'package:towigo/widgets/progress_dialog.dart';

import '../config_maps.dart';

class TowingRequest extends StatefulWidget{
  static const String idScreen = "servicescreen";
  @override
  TowingRequestState createState() => TowingRequestState();
}

class TowingRequestState extends State<TowingRequest>{
  TextEditingController pickupTextEditingController = TextEditingController();

  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  final firestoreInstance = FirebaseFirestore.instance;

  late Position currentPosition;
  var geolocator = Geolocator();
  double bottomPaddingOfMap = 0;

  double rideDetailsContainerHeight = 0.0;
  double requestRideContainerHeight = 0.0;
  double searchContainerHeight = 0.0;
  void locatePosition() async
  {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    currentPosition = position;
    LatLng latLaPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = new CameraPosition(target: latLaPosition, zoom: 14.0);

    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address = await AssistantMethods.searchCoordinateAddress(position, context);
    print("This is your Address :: "+ address);

  }
  void displayrequestRideContainer()
  {
    setState((){
      requestRideContainerHeight = 250.0;
      rideDetailsContainerHeight = 0;
      bottomPaddingOfMap = 230.0;
    }
    );
  }

  Future<void> displayRiderDetails() async
  {
    var initialPos = Provider.of<AppData>(context, listen: false).pickUpLocation;
    var driverpos = Provider.of<AppData>(context, listen: false).driverlocation;

    var pickUpLatLng = LatLng(initialPos!.latitude, initialPos.longitude);
    var driverLatLng = LatLng(driverpos!.latitude, driverpos.longitude);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => ProgressDialog(message: "Please wait..."),
    );

    var details = await AssistantMethods.obtainPlaceDirections(pickUpLatLng, driverLatLng);

    Navigator.pop(context);
  }

  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-1.32162745, 36.82159511214216),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Towing Service',
            style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
            )
        ),
        backgroundColor: Color.fromRGBO(47, 11, 118, 1),
      ),
      body: Stack(
          children: [

            GoogleMap(
              padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              initialCameraPosition: _kGooglePlex,
              myLocationEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              onMapCreated: (GoogleMapController controller)
              {
                _controllerGoogleMap.complete(controller);
                newGoogleMapController = controller;

                setState(() {
                  bottomPaddingOfMap=300.0;
                });

                locatePosition();
              },
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Container(
                height: 300.0,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 6.0),
                      Text("Hi there, ", style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(height: 6.0),
                      Text("Where to?", style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(height: 6.0),

                      GestureDetector(
                        onTap: () async{
                          var res = await Navigator.push(context, MaterialPageRoute(builder: (context)=> ServiceRequest()));

                          if (res == "obtainDirection")
                            {
                              await displayRiderDetails();
                            }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 6.0,
                                  spreadRadius: 0.5,
                                  offset: Offset(0.7,0.7),
                                )
                              ]
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.deepPurpleAccent,),
                              SizedBox(width: 10.0,),
                              Text("Pick Up location", style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 24.0,),
                      Row(
                        children: [
                          Icon(Icons.home, color: Colors.grey),
                          SizedBox(width: 24.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Five Star Road, Five Star Phae 2"
                                /*Provider.of<AppData>(context).pickUpLocation != null
                                    ?Provider.of<AppData>(context).pickUpLocation!.placeName
                                    :"Location"*/
                              ),
                              SizedBox(height: 4.0,),
                              Text("Current Location", style: TextStyle(color: Colors.black54,fontFamily:"Brand Bold", fontSize: 12.0))
                            ],
                          )
                        ]
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]
      ),
    );
  }
  void findPlace(String placeName) async{
    if (placeName.length > 1)
    {
      String autoCompleteUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=1234567890&components=country:ke";

      var res = await RequestAssistant.getRequest(autoCompleteUrl);

      if (res == "failed")
      {
        return;
      }
      print("Places Prediction Response :: ");
      print(res);
    }
  }

  void saveTowRequest()
  {
    FirebaseFirestore.instance
        .collection('requests')
        .add({'text': 'data added through app'});
  }
  postDetailsToFirestore() async {

    /*FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    RequestModel? request = _request as RequestModel?;

    RequestModel requestModel = RequestModel();

    requestModel.requestid = request!.requestid;
    requestModel.uid = request.uid;
    requestModel.servicetype = firstNameEditingController.text;
    requestModel.secondName = secondNameEditingController.text;

    await firebaseFirestore
        .collection("requests")
        .doc(request.uid)
        .set(RequestModel.toMap());*/
  }
}

