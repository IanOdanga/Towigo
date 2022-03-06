class RequestModel {
  String? uid;
  String? requestid;
  String? servicetype;
  String? location;

  RequestModel({this.uid, this.requestid, this.servicetype, this.location});

  // receiving data from server
  factory RequestModel.fromMap(map) {
    return RequestModel(
      uid: map['uid'],
      requestid: map['requestid'],
      servicetype: map['servicetype'],
      location: map['location'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'requestid': requestid,
      'servicetype': servicetype,
      'location': location,
    };
  }
}
