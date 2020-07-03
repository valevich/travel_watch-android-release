import 'dart:ui' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:admob_flutter/admob_flutter.dart';
import 'package:travel_watch/services/admob_service.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Tipping extends StatefulWidget {
  @override
  _TippingState createState() => _TippingState();
}

class _TippingState extends State<Tipping> {
  List data;
  // String url = "https://next.json-generator.com/api/json/get/Ek7T0um3_";
  String url =
      "https://raw.githubusercontent.com/valevich/jsonhost/master/travelwatch/tipsbycountry.json";

  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var extractdata = jsonDecode(response.body);
      data = extractdata['results'];
    });

    return null;
  }

  @override
  void initState() {
    super.initState();
    this.makeRequest();
  }

  final ams = AdmobService();

  @override
  Widget build(BuildContext context) {
    Admob.initialize(ams.getAddMobAppId());
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: new Text("Country Tipping"),
      ),
      body: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int i) {
            return new ListTile(
              title: new Text(data[i]['Country']),
              subtitle: new Text(data[i]['iso_alpha2']),
              // leading: CircleAvatar(
              //   backgroundImage: NetworkImage("https://www.countryflags.io/${data[i]['iso_alpha2']}/flat/32.png"),
              // ),
              leading: SvgPicture.network(
                "https://hatscripts.github.io/circle-flags/flags/${data[i]['iso_alpha2'].toLowerCase()}.svg",
                placeholderBuilder: (context) => CircularProgressIndicator(),
                height: 40.0,
              ),
              trailing: Icon(
                Icons.arrow_forward,
                size: 20.0,
                color: Colors.brown[900],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new DetailPage(data[i])));
              },
            );
          }),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        child: Container(
          color: Colors.black87,
          height: 60,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AdmobBanner(
                adUnitId: ams.getBannerAppId(),
                adSize: AdmobBannerSize.BANNER,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  DetailPage(this.data);
  final data;
  final ams = AdmobService();

  @override
  Widget build(BuildContext context) {
    Admob.initialize(ams.getAddMobAppId());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: Text('Tip Recommendation'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 5.0),
          Image.network(
            "https://www.countryflags.io/${data['iso_alpha2']}/flat/64.png",
          ),

          // SizedBox(height: 5.0),
          Text(data['Country'],
              style: TextStyle(
                  fontWeight: prefix0.FontWeight.w500, fontSize: 25.0)),

          // SizedBox(height: 10.0),
          // Text("Region:  " + data['iso_alpha2'],
          // style: TextStyle(
          //   // fontWeight: prefix0.FontWeight.w500,
          //   fontSize: 18.0
          // )),

          Column(
            children: [
              SizedBox(height: 10.0),
              Divider(color: Colors.black87),

              SizedBox(height: 15.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.restaurant),
                    SizedBox(width: 14.0),
                    Text(
                      "Restaurants",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          fontFamily: 'Montserrat'),
                    ),
                  ]),
              SizedBox(height: 3.0),
              Text(data['Restaurants']),

              SizedBox(height: 15.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.local_taxi),
                    SizedBox(width: 20.0),
                    Text(
                      "Taxis",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          fontFamily: 'Montserrat'),
                    ),
                  ]),
              SizedBox(height: 3.0),
              Text(data['Taxis']),

              SizedBox(height: 15.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.hotel),
                    SizedBox(width: 20.0),
                    Text(
                      "Hotels",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          fontFamily: 'Montserrat'),
                    ),
                  ]),
              SizedBox(height: 3.0),
              Text(data['Porters']),

              SizedBox(height: 30.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 20.0),
                    Icon(Icons.info),
                    SizedBox(width: 10.0),
                    Text(
                      "Other things to keep in mind:",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          fontFamily: 'Montserrat'),
                    ),
                  ]),
              // SizedBox(height: 10.0),
              Container(
                margin: EdgeInsets.all(20.0),
                child: Text(
                  "Beware of service charges—you might think that a “service charge” on your bill indicates that you don’t need to leave a tip, but this may or may not be the case depending on where you’re traveling.",
                  style: TextStyle(
                    fontSize: 12.0,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        child: Container(
          color: Colors.black87,
          height: 60,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AdmobBanner(
                adUnitId: ams.getBannerAppId(),
                adSize: AdmobBannerSize.BANNER,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
