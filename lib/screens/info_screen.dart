import 'package:flutter/material.dart';
import 'package:towigo/screens/details_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class RentPage extends StatefulWidget {
  @override
  _RentPageState createState() => _RentPageState();
}

class _RentPageState extends State<RentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ListTile(
          trailing: Icon(
            Icons.clear_all,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Explore",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 2.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[Color(0xFF2508FF), Color(0xFFFF1000)]),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.transparent,
              height: 175,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: <Color>[Colors.deepPurpleAccent, Colors.purpleAccent]),
                        borderRadius: new BorderRadius.circular(10)),
                    height: 175,
                    width: 125,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPage()));
                      },
                      child: Hero(
                        tag: "bmwspares",
                        child: Card(
                          color: Colors.transparent,
                          elevation: 0,
                          child: Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "BMW",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Image.asset(
                                    "assets/bmw.png",
                                    fit: BoxFit.contain,
                                    height: 40,
                                    width: 50,
                                  ),
                                ],
                              ),
                              Image.asset(
                                "assets/bmwCar_card.png",
                                fit: BoxFit.contain,
                                height: 75,
                                width: 155,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "All Series",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\$350",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    "per tyre",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: <Color>[Colors.lightBlueAccent, Colors.blue]),
                        borderRadius: new BorderRadius.circular(10)),
                    height: 175,
                    width: 125,
                    child: Card(
                      color: Colors.transparent,
                      elevation: 0,
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Benz",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Image.asset(
                                "assets/benzlogo.png",
                                fit: BoxFit.contain,
                                height: 40,
                                width: 50,
                                // width: double.infinity,
                              ),
                            ],
                          ),
                          Image.asset(
                            "assets/benzcar_card.png",
                            fit: BoxFit.contain,
                            height: 75,
                            width: 155,
                            // width: double.infinity,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "All Series",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "\$320",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "per tyre",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: <Color>[Colors.orangeAccent, Colors.orange]),
                        borderRadius: new BorderRadius.circular(10)),
                    height: 175,
                    width: 125,
                    child: Card(
                      color: Colors.transparent,
                      elevation: 0,
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Jaguar Spares",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Image.asset(
                                "assets/jaguarlogo.png",
                                fit: BoxFit.contain,
                                height: 40,
                                width: 50,
                                // width: double.infinity,
                              ),
                            ],
                          ),
                          Image.asset(
                            "assets/jaguarcar.png",
                            fit: BoxFit.contain,
                            height: 75,
                            width: 155,
                            // width: double.infinity,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "All Series",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "\$200",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "per tyre",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: <Color>[Colors.lightGreenAccent, Colors.green]),
                        borderRadius: new BorderRadius.circular(10)),
                    height: 175,
                    width: 125,
                    child: Card(
                      color: Colors.transparent,
                      elevation: 0,
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Audi",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Image.asset(
                                "assets/audilogo.png",
                                fit: BoxFit.contain,
                                height: 40,
                                width: 50,
                                // width: double.infinity,
                              ),
                            ],
                          ),
                          Image.asset(
                            "assets/audicar.webp",
                            fit: BoxFit.contain,
                            height: 75,
                            width: 155,
                            // width: double.infinity,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "All Series",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "\$280",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "per tyre",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 2.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[
                        Color(0xFFFF1000),
                        Color(0xFF2508FF)
                      ]),
                    ),
                  ),
                ),
                Text("Top Rated  ",
                    style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center),
                Expanded(
                  child: Container(
                    height: 2.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[
                        Color(0xFF2508FF),
                        Color(0xFFFF1000)
                      ]),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.42,
                child: Expanded(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      FittedBox(
                        child: GestureDetector(
                          onTap: () {},
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 5,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 90,
                                  height: 60,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image(
                                      fit: BoxFit.contain,
                                      alignment: Alignment.center,
                                      image: AssetImage('assets/toyota.webp'),
                                    ),
                                  ),
                                ),
                                toyotacar(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      FittedBox(
                        child: GestureDetector(
                          onTap: () {},
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 5,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 90,
                                  height: 60,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image(
                                      fit: BoxFit.contain,
                                      alignment: Alignment.center,
                                      image: AssetImage('assets/hundai.png'),
                                    ),
                                  ),
                                ),
                                hundaicar(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      FittedBox(
                        child: GestureDetector(
                          onTap: () {},
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 5,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 90,
                                  height: 60,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image(
                                      fit: BoxFit.contain,
                                      alignment: Alignment.center,
                                      image:
                                      AssetImage('assets/volkswagen.png'),
                                    ),
                                  ),
                                ),
                                volkswagencar(),
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
          ],
        ),
      ),
    );
  }
}

Widget toyotacar() {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            "Toyota",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 5,
            ),
            Container(
              width: 45,
              decoration: BoxDecoration(
                color: Colors.lightBlue[100],
                borderRadius: BorderRadius.circular(3),
              ),
              alignment: Alignment.center,
            ),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: (){
                _launchURL();
              },
              child: Container(
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.orange[300],
                  borderRadius: BorderRadius.circular(3),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Website",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5, fontFamily: "Brand Bold"),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              width: 35,
              decoration: BoxDecoration(
                color: Colors.green[200],
                borderRadius: BorderRadius.circular(3),
              ),
              alignment: Alignment.center,
              child: Text(
                "Call: 0800 723 222 ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Ratings",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 7,
                  color: Colors.grey),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.star,
              size: 10,
              color: Colors.orangeAccent,
            ),
            Icon(
              Icons.star,
              size: 10,
              color: Colors.orangeAccent,
            ),
            Icon(
              Icons.star,
              size: 10,
              color: Colors.orangeAccent,
            ),
            Icon(
              Icons.star,
              size: 10,
              color: Colors.orangeAccent,
            ),
            Icon(
              Icons.star,
              size: 10,
              color: Colors.orangeAccent,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget hundaicar() {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            " Mercedes    ",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: (){
                _launchURI();
              },
              child: Container(
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.orange[300],
                  borderRadius: BorderRadius.circular(3),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Website",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              width: 45,
              decoration: BoxDecoration(
                color: Colors.green[200],
                borderRadius: BorderRadius.circular(3),
              ),
              alignment: Alignment.center,
              child: Text(
                "Call: +254 722 983 322",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Ratings",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 7,
                  color: Colors.grey),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.star,
              size: 10,
              color: Colors.orangeAccent,
            ),
            Icon(
              Icons.star,
              size: 10,
              color: Colors.orangeAccent,
            ),
            Icon(
              Icons.star,
              size: 10,
              color: Colors.orangeAccent,
            ),
            Icon(
              Icons.star,
              size: 10,
              color: Colors.orangeAccent,
            ),
            Icon(
              Icons.star,
              size: 10,
              color: Colors.grey,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget volkswagencar() {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            " VolksWagen   ",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: (){
                _launchLink();
              },
              child: Container(
                width: 45,
                decoration: BoxDecoration(
                  color: Colors.lightBlue[100],
                  borderRadius: BorderRadius.circular(3),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Website",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              width: 35,
              decoration: BoxDecoration(
                color: Colors.orange[300],
                borderRadius: BorderRadius.circular(3),
              ),
              alignment: Alignment.center,
              child: Text(
                "Call: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Ratings",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 7,
                  color: Colors.grey),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.star,
              size: 10,
              color: Colors.orangeAccent,
            ),
            Icon(
              Icons.star,
              size: 10,
              color: Colors.orangeAccent,
            ),
            Icon(
              Icons.star,
              size: 10,
              color: Colors.orangeAccent,
            ),
            Icon(
              Icons.star,
              size: 10,
              color: Colors.orangeAccent,
            ),
            Icon(
              Icons.star,
              size: 10,
              color: Colors.grey,
            ),
          ],
        ),
      ],
    ),
  );
}
String _url = 'Website: https://toyotakenya.com/spare-parts/';
String url = 'https://www.kompressor.co.ke/';
String link = 'https://parts.vw.com/?utm_source=vwserviceandparts.com&utm_medium=referral&utm_term=service&utm_content=shopnow&utm_campaign=vws+p';

void _launchURL() async {
  if (!await launch(_url)) throw 'Could not launch $_url';
}

void _launchURI() async {
  if (!await launch(url)) throw 'Could not launch $url';
}

void _launchLink() async {
  if (!await launch(link)) throw 'Could not launch $link';
}