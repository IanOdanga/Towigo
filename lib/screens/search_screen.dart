import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towigo/Assistant/request_assistant.dart';
import 'package:towigo/Data%20Handler/app_data.dart';
import 'package:towigo/model/address.dart';
import 'package:towigo/model/places_prediction.dart';

import '../config_maps.dart';

class SearchScreen extends StatefulWidget{
  static String idScreen = "search";
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>{

  TextEditingController pickUpController = TextEditingController();
  List <PlacesPredictions> placePredictionList =[];

  @override
  Widget build(BuildContext context) {

    String placeAddress = Provider.of<AppData>(context).pickUpLocation?.placeName ?? "";
    pickUpController.text = placeAddress;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 215.0,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                color: Colors.black,
                blurRadius: 6.0,
                spreadRadius: 0.5,
                offset: Offset(0.7, 0.7),
                )
              ]
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 25.0, top: 20.0, right: 25.0, bottom: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 10.0),
                  Stack(
                    children: [
                      Icon(Icons.arrow_back),
                      Center(
                        child: Text("Use current location", style: GoogleFonts.raleway(textStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),),
                      )
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Image.asset("assets/images/pickicon.png", height: 16.0, width: 16.0,),

                      SizedBox(height: 18.0),

                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: TextField(
                              onChanged: (val)
                              {
                                findPlace(val);
                              },
                              controller: pickUpController,
                              decoration: InputDecoration(
                                hintText: "Pick up location",
                                hintStyle: TextStyle(fontFamily: "Brand Bold",),
                                fillColor: Colors.grey[400],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(left: 11.0,top: 8.0,bottom: 8.0)
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          //tile for predictions
          (placePredictionList.length > 0)
              ?Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListView.separated(
                  padding: EdgeInsets.all(0.0),
                  itemBuilder: (context, index)
                  {
                    return PredictionsTile(placePredictions: placePredictionList[index],);
                  },
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                  itemCount: placePredictionList.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
            )
          )
          :Container(),
        ],
      ),
    );
  }
  Future<void> findPlace(String placeName) async {
    if (placeName.length > 1)
      {
        String autoCompleteUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=1234567890&components=country:ke";

        var res = await RequestAssistant.getRequest(autoCompleteUrl);

        if (res == "failed")
          {
            return;
          }

        if(res["status"] == "OK")
          {
            var predictions = res["predictions"];

            var placeList = (predictions as List).map((e) => PlacesPredictions.fromJson(e)).toList();

            setState((){
              placePredictionList= placeList;
              }
            );
          }
      }
  }
}

class PredictionsTile extends StatelessWidget{
  final PlacesPredictions placePredictions;

  PredictionsTile({ required this.placePredictions});

  void getPlaceAddressDetails(String placeId) async{
    if (placeId.length > 1)
    {
      String placeDetailsUrl = "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapKey";

      var res = await RequestAssistant.getRequest(placeDetailsUrl);

      if (res == "failed")
      {
        return;
      }

      if(res["status"] == "OK")
      {
        Address address = Address(placeFormattedAddress: '', longitude: 0, latitude: 0, placeName: '', placeId: '');
        address.placeName = res["result"]["name"];
        address.placeId = placeId;
        address.latitude = res["result"]["geometry"]["location"]["lat"];
        address.longitude = res["result"]["geometry"]["location"]["lng"];

        print("Location:: ");
        print(address.placeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0.0),
      onPressed: (){

      },
      child: Container(
        child: Column(
          children: [
            SizedBox(width: 10.0,),
            Row(
              children: [
                Icon(Icons.add_location),
                SizedBox(width: 14.0,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(placePredictions.mainText, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16.0),),
                      SizedBox(height: 3.0,),
                      Text(placePredictions.secondaryText, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12.0, color: Colors.grey),),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(width: 10.0,),
          ],

        ),

      ),
    );
  }
}