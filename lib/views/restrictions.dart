import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:ui' as prefix0;
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:travel_watch/services/admob_service.dart';


class RestrictList extends StatefulWidget {
  @override
  _RestrictListState createState() => _RestrictListState();
}

class _RestrictListState extends State<RestrictList> {
  TextEditingController searchTextController = new TextEditingController();

  // Get json result and convert it to model. Then add
  Future<Null> getCountryDetails() async {
    final response = await http.get(url);
    final responseJson = json.decode(response.body);

    setState(() {
      for (Map country in responseJson) {
        _countryDetails.add(CountryDetails.fromJson(country));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _searchResult.clear();
    _countryDetails.clear(); //removing previous data
    getCountryDetails(); //updating new data
  }

  final ams = AdmobService();

  @override
  Widget build(BuildContext context) {
    Admob.initialize(ams.getAddMobAppId());
    return new Scaffold(
      backgroundColor: Colors.black87,
      appBar: new AppBar(
        title: new Text('Travel Restrictions'),
        backgroundColor: Colors.black87,
        elevation: 0.0,
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(14.0)),
            ),
            child: TextField(
              onChanged: onSearchTextChanged,
              style: TextStyle(color: Colors.black, fontSize: 18.0),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 18.0),
                hintText: 'Search Country',
                prefixIcon: Icon(
                  Icons.search,
                  size: 30.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          new Expanded(
            child: _searchResult.length != 0 ||
                searchTextController.text.isNotEmpty
                ? new ListView.builder(
              itemCount: _searchResult.length,
              itemBuilder: (context, i) {
                return new Card(
                  elevation: 20.0,
                  color: Colors.grey[850],
                  margin: EdgeInsets.only(left: 1,right: 1, bottom: 3),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.4, horizontal:8.0),
                    child: new ListTile(
                      leading: SvgPicture.network(
                        "https://hatscripts.github.io/circle-flags/flags/${_searchResult[i].isoalpha2}.svg",
                        placeholderBuilder: (context) => CircularProgressIndicator(),
                        height: 40.0,
                      ),
                      title: new Text(_searchResult[i].country,
                        style: TextStyle(
                          color: Colors.white),),
                      subtitle: new Text(_searchResult[i].report1,
                        style: TextStyle(
                          color: Colors.grey[400]),),
                      trailing: Icon(
                        Icons.arrow_forward,
                        size: 20.0,
                        color: Colors.white54,
                      ),
                      onTap: () {
                          Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) => new Screen2(
                                countrygroup: _searchResult[i].countrygroup,
                                isoalpha2: _searchResult[i].isoalpha2,
                                flagurl: _searchResult[i].flagurl,
                                country: _searchResult[i].country, 
                                report1: _searchResult[i].report1,
                                report2: _searchResult[i].report2,
                                covidcases: _searchResult[i].covidcases)
                            ),);
                      },
                    ),
                  ),
                );
              },
            )
            
            : new ListView.builder(
              itemCount: _countryDetails.length,
              itemBuilder: (context, index) {
                return new Card(
                  elevation: 20.0,
                  color: Colors.grey[850],
                  margin: EdgeInsets.only(left: 1,right: 1, bottom: 3),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.4, horizontal:8.0),
                    child: ListTile(
                      leading: SvgPicture.network(
                        "https://hatscripts.github.io/circle-flags/flags/${_countryDetails[index].isoalpha2}.svg",
                        placeholderBuilder: (context) => CircularProgressIndicator(),
                        height: 40.0,
                      ),
                      title: new Text(_countryDetails[index].country, 
                        style: TextStyle(
                            color: Colors.white),),
                      subtitle: new Text(_countryDetails[index].report1,
                        style: TextStyle(
                            color: Colors.grey[400]),),
                      trailing: Icon(
                        Icons.arrow_forward,
                        size: 20.0,
                        color: Colors.white54,
                      ),
                      onTap: () {
                        Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) => new Screen2(
                              countrygroup: _countryDetails[index].countrygroup,
                              isoalpha2: _countryDetails[index].isoalpha2,
                              flagurl: _countryDetails[index].flagurl,
                              country: _countryDetails[index].country, 
                              report1: _countryDetails[index].report1,
                              report2: _countryDetails[index].report2,
                              covidcases: _countryDetails[index].covidcases)
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar:
        BottomAppBar(
          elevation: 0.0,
          child: Container(
            color: Colors.black87,
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AdmobBanner(adUnitId: ams.getBannerAppId(), adSize: AdmobBannerSize.BANNER,),
              ],
            ),
          ),
        ),

    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _countryDetails.forEach((countryDetail) {
      if (countryDetail.country.toLowerCase().contains(text))
        _searchResult.add(countryDetail);
    });

    setState(() {});
  }

}


List<CountryDetails> _searchResult = [];
List<CountryDetails> _countryDetails = [];

// final String url = 'https://next.json-generator.com/api/json/get/V1gMxow6d';
final String url = 'https://raw.githubusercontent.com/valevich/jsonhost/master/travelwatch/kayak_restrictions.json';

class CountryDetails {

  final String countrygroup, isoalpha2, flagurl, country, report1, report2, covidcases;

  CountryDetails(
      {this.countrygroup,
        this.isoalpha2,
        this.flagurl,
        this.country,
        this.report1,
        this.report2,
        this.covidcases});

  factory CountryDetails.fromJson(Map<String, dynamic> json) {
    return new CountryDetails(
      countrygroup: json['countrygroup'],
      isoalpha2: json['iso_alpha2'],
      flagurl: json['flagurl'],
      country: json['country'],
      report1: json['report1'],
      report2: json['report2'],
      covidcases: json['covidcases'],
    );
  }
}


class Screen2 extends StatefulWidget{
 Screen2({this.countrygroup, this.isoalpha2, this.flagurl, this.country, this.report1, this.report2, this.covidcases});
  final String countrygroup;
  final String isoalpha2;
  final String flagurl;
  final String country;
  final String report1;
  final String report2;
  final String covidcases;

  @override
  State<StatefulWidget> createState() { return new Screen2State();}
}

class Screen2State extends State<Screen2> {
  final ams = AdmobService();
  @override
  Widget build(BuildContext context) {
    Admob.initialize(ams.getAddMobAppId());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Travel Restrictions'),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5.0),
              Image.network(
                "https://www.countryflags.io/${widget.isoalpha2}/flat/64.png",
              ),

              new Text(widget.country ?? "",
              style: TextStyle(
                fontWeight: prefix0.FontWeight.w500,
                fontSize: 25.0
              )),

              SizedBox(height: 3.0),
              Text(widget.countrygroup ?? ""),

              SizedBox(height: 10.0),
              Divider(color: Colors.black87),

              SizedBox(height: 20.0),
              Text("Summary",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  fontFamily: 'Montserrat'),),
              // SizedBox(width: 14.0),
              Center(child:Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text(widget.report1 ?? "", 
                style: TextStyle(fontSize: 15)))),

              // SizedBox(height: 5.0),
              Text("Details",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  fontFamily: 'Montserrat'),),
              // SizedBox(width: 14.0),
              Center(child:Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text(widget.report2 ?? "", 
                style: TextStyle(fontSize: 15)))),

              // SizedBox(height: 30.0),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: <Widget>[
              //     SizedBox(width: 20.0),
              //     Icon(Icons.info),
              //     SizedBox(width: 10.0),
              //     Text("Other things to keep in mind:",
              //     style: TextStyle(
              //       color: Colors.black,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 12.0,
              //       fontFamily: 'Montserrat'),),
              //   ]
              // ),
              // // SizedBox(height: 10.0),
              // Container(
              //   margin: EdgeInsets.all(20.0),
              //   child: Text(widget.covidcases ?? "",
              //       style: TextStyle(
              //         fontSize: 13.0,
              //         fontStyle: FontStyle.normal,
              //       ),
              //   ),
              // ),
              
            ],

           ),),),
      

      bottomNavigationBar:
        BottomAppBar(
          elevation: 0.0,
          child: Container(
            color: Colors.black87,
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AdmobBanner(adUnitId: ams.getBannerAppId(), adSize: AdmobBannerSize.BANNER,),
              ],
            ),
          ),
        ),

    );
  }
}


