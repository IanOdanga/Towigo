class PlacesPredictions{

  late String secondaryText;
  late String mainText;
  late String placeId;

  PlacesPredictions({required this.secondaryText,required this.mainText,required this.placeId});

  PlacesPredictions.fromJson(Map<String, dynamic> json)
  {
    placeId=json["placeId"];
    mainText=json["structured_formatting"]["mainText"];
    secondaryText=json["structured_formatting"]["secondaryText"];
  }
}