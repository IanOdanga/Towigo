import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:towigo/model/user_model.dart';
import 'package:towigo/screens/tow_serviceconfirm_screen.dart';
import 'package:towigo/widgets/progress_dialog.dart';

import '../config_maps.dart';

class ServiceRequest extends StatefulWidget{
  static const String idScreen = "servicescreen";
  @override
 ServiceRequestState createState() => ServiceRequestState();
}

class ServiceRequestState extends State<ServiceRequest>{
  TextEditingController pickupTextEditingController = TextEditingController();

  final firestoreInstance = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  RequestModel requests = RequestModel();

  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  late Position currentPosition;
  var geolocator = Geolocator();
  double bottomPaddingOfMap = 0;

  double rideDetailsContainerHeight = 0.0;
  double requestRideContainerHeight = 0.0;
  double searchContainerHeight = 0.0;
  bool drawerOpen = true;
  void locatePosition() async
  {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLaPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = new CameraPosition(target: latLaPosition, zoom: 14.0);

    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address = await AssistantMethods.searchCoordinateAddress(position, context);
    print("This is your Address :: "+ address);

  }

  void saveRideDetails()
  {
    var pickup = Provider.of<AppData>(context, listen: false).pickUpLocation;

    Map PickUpLoc =
    {
      "latitude":pickup!.latitude.toString(),
      "longitude":pickup.longitude.toString(),
    };

    FirebaseFirestore.instance
        .collection("requests")
        .add({
      "tower_id":"waiting",
      "payment_method":"cash",
      "pickup":PickUpLoc,
      "created_at":DateTime.now().toString(),
      "rider_name":"",
      "rider_phone":"",
    });
  }

  void CancelRideRequest()
  {
    firestoreInstance
        .collection("requests")
        .doc(user!.uid)
        .delete();

  }

  void displayrequestRideContainer()
  {
    setState((){
      requestRideContainerHeight = 250.0;
      rideDetailsContainerHeight = 0;
      bottomPaddingOfMap = 230.0;
      drawerOpen = true;
      }
    );
    saveRideDetails();
  }

  resetApp()
  {
    setState((){
      drawerOpen = true;
      searchContainerHeight = 300.0;
      requestRideContainerHeight = 0.0;
      rideDetailsContainerHeight = 0;
      bottomPaddingOfMap = 230.0;
    });
    locatePosition();
  }

  void displayRiderDetails() async
  {
    //await getPlaceDirection();
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

  static const colorizeTextStyle = TextStyle(
    fontSize: 35.0,
    fontFamily: 'Signatra',
  );

  static const colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  static final CameraPosition _kGooglePlex = CameraPosition(
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
                  bottomPaddingOfMap=265.0;
                });

                locatePosition();
              },
            ),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: Container(
                height: 300,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 16.0,
                        spreadRadius: 0.3,
                        offset: Offset(0.7, 0.7),
                      )
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17.0),
                  child: Column(
                    children: [
                      Container(
                          width: 250,
                          color: Colors.deepPurpleAccent,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                Image.asset("assets/images/car_android.png", height: 70.0, width: 80.0,),

                                const SizedBox(width: 16.0,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Tow Truck", style: TextStyle(fontSize: 18.0, fontFamily: "brand-bold"),
                                    ),
                                    Text(
                                      "10Km", style: TextStyle(fontSize: 16.0, color: Colors.grey),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                      ),

                      const SizedBox(height: 20.0),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: const [
                            Icon(FontAwesomeIcons.moneyCheckAlt, size: 18.0, color: Colors.black,),
                            SizedBox(width: 16.0),
                            Text("Cash"),
                            SizedBox(width: 6.0),
                            Icon(Icons.keyboard_arrow_down, size: 16.0, color: Colors.black,),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20.0),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          onPressed: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context){
                                  return ProgressDialog(message: "Confirming request...");
                                }
                            );
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => ServiceConfirmation()));
                            saveRideDetails();
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(5.0,0.0,5.0,0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Request", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                Icon(FontAwesomeIcons.truckPickup, size: 18.0, color: Colors.white,),
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
}

