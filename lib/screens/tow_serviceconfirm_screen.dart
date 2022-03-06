import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
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
import 'package:towigo/widgets/progress_dialog.dart';

import '../config_maps.dart';

class ServiceConfirmation extends StatefulWidget{
  static const String idScreen = "servicescreen";
  @override
  ServiceConfirmationState createState() => ServiceConfirmationState();
}

class ServiceConfirmationState extends State<ServiceConfirmation>{
  TextEditingController pickupTextEditingController = TextEditingController();

  final firestoreInstance = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  RequestModel requests = RequestModel();

  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  Set<Marker> markers = {};
  Set<Circle> circles = {};

  late Position currentPosition;
  var geolocator = Geolocator();
  double bottomPaddingOfMap = 0;

  double rideDetailsContainerHeight = 0.0;
  double requestRideContainerHeight = 0.0;
  double searchContainerHeight = 0.0;
  bool drawerOpen = true;
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
    var driverpos = LatLng(-1.309295, 36.8218879);//Provider.of<AppData>(context, listen: false).driverlocation;

    var pickUpLatLng = LatLng(initialPos!.latitude, initialPos.longitude);
    var driverLatLng = LatLng(driverpos.latitude, driverpos.longitude);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => ProgressDialog(message: "Please wait..."),
    );

    var details = await AssistantMethods.obtainPlaceDirections(pickUpLatLng, driverLatLng);

    Navigator.pop(context);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodePolyLinePointsResults = polylinePoints.decodePolyline(details!.encodedPoints);

    pLineCoordinates.clear();
    if (decodePolyLinePointsResults.isNotEmpty)
      {
        decodePolyLinePointsResults.forEach((PointLatLng pointLatLng) {
          pLineCoordinates.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
        });
      }

    polylineSet.clear();

    setState((){
      Polyline polyline = Polyline(
        color: Colors.deepPurpleAccent,
        polylineId: PolylineId("PolylineID"),
        jointType: JointType.round,
        points: pLineCoordinates,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );

      polylineSet.add(polyline);
    });
    
    LatLngBounds latLngBounds;
    if(pickUpLatLng.latitude > driverLatLng.latitude && pickUpLatLng.longitude > driverLatLng.longitude)
      {
        latLngBounds = LatLngBounds(southwest: driverLatLng, northeast: pickUpLatLng);
      }
    else if (pickUpLatLng.latitude > driverLatLng.latitude)
      {
        latLngBounds = LatLngBounds(southwest: LatLng(driverLatLng.latitude,pickUpLatLng.longitude), northeast: LatLng(pickUpLatLng.latitude,driverLatLng.longitude));
      }
    else if (pickUpLatLng.longitude > driverLatLng.longitude)
      {
        latLngBounds = LatLngBounds(southwest: LatLng(driverLatLng.longitude,pickUpLatLng.latitude), northeast: LatLng(pickUpLatLng.longitude,driverLatLng.latitude));
      }
    else
      {
        latLngBounds = LatLngBounds(southwest: pickUpLatLng, northeast: driverLatLng);
      }

    newGoogleMapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker pickUpLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: InfoWindow(title: initialPos.placeName, snippet: "my location"),
      position: pickUpLatLng,
      markerId: MarkerId("pickUpID"),
    );
    Marker driverLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: InfoWindow(title: "Driver's location", snippet: "Driver's location"),
      position: pickUpLatLng,
      markerId: MarkerId("DriverID"),
    );

    setState(() {
      markers.add(pickUpLocMarker);
      markers.add(driverLocMarker);
      }
    );

    Circle pickUpLocCircle = Circle(
      circleId: CircleId("pickUpID"),
      fillColor: Colors.deepPurple,
      center: pickUpLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.deepPurple
    );
    Circle driverLocCircle = Circle(
        circleId: CircleId("driverID"),
        fillColor: Colors.deepPurpleAccent,
        center: driverLatLng,
        radius: 12,
        strokeWidth: 4,
        strokeColor: Colors.deepPurpleAccent
    );

    setState(() {
      circles.add(pickUpLocCircle);
      circles.add(driverLocCircle);
    }
    );
  }

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
              markers: markers,
              circles: circles,
              polylines: polylineSet,
              zoomGesturesEnabled: true,
              onMapCreated: (GoogleMapController controller)
              {
                _controllerGoogleMap.complete(controller);
                newGoogleMapController = controller;

                setState(() {
                  bottomPaddingOfMap=265.0;
                });

                locatePosition();
                displayRiderDetails();
              },
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

