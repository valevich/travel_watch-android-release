import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:ui' as prefix0;
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:travel_watch/services/admob_service.dart';

class Advisories extends StatefulWidget {
  @override
  _AdvisoriesState createState() => _AdvisoriesState();
}

class _AdvisoriesState extends State<Advisories> {
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
      backgroundColor: Colors.grey[300],
      appBar: new AppBar(
        title: new Text('Travel Advisories'),
        backgroundColor: Colors.black87,
        elevation: 0.0,
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(14.0)),
            ),
            child: TextField(
              onChanged: onSearchTextChanged,
              style: TextStyle(color: Colors.black, fontSize: 18.0),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                hintStyle: TextStyle(color: Colors.grey[600], fontSize: 18.0),
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
                        color: Colors.grey[800],
                        margin: EdgeInsets.only(left: 1, right: 1, bottom: 3),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.4, horizontal: 8.0),
                          child: new ListTile(
                            leading: SvgPicture.network(
                              "https://hatscripts.github.io/circle-flags/flags/${_searchResult[i].isoalpha2.toLowerCase()}.svg",
                              placeholderBuilder: (context) =>
                                  CircularProgressIndicator(),
                              height: 40.0,
                            ),
                            title: new Text(
                              _searchResult[i].name,
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: new Text(
                              _searchResult[i].score,
                              style: TextStyle(color: Colors.grey[100]),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward,
                              size: 20.0,
                              color: Colors.white54,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => new Screen2(
                                        code: _searchResult[i].code,
                                        isoalpha2: _searchResult[i].isoalpha2,
                                        continent: _searchResult[i].continent,
                                        name: _searchResult[i].name,
                                        score: _searchResult[i].score,
                                        updated: _searchResult[i].updated,
                                        description:
                                            _searchResult[i].description)),
                              );
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
                        color: Colors.grey[300],
                        margin: EdgeInsets.only(left: 1, right: 1, bottom: 3),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.4, horizontal: 8.0),
                          child: ListTile(
                            leading: SvgPicture.network(
                              "https://hatscripts.github.io/circle-flags/flags/${_countryDetails[index].isoalpha2.toLowerCase()}.svg",
                              placeholderBuilder: (context) =>
                                  CircularProgressIndicator(),
                              height: 40.0,
                            ),
                            title: new Text(
                              _countryDetails[index].name,
                              style: TextStyle(color: Colors.black87),
                            ),
                            subtitle: new Text(
                              _countryDetails[index].score,
                              style: TextStyle(color: Colors.grey[800]),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward,
                              size: 20.0,
                              color: Colors.grey[800],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => new Screen2(
                                        code: _countryDetails[index].code,
                                        isoalpha2:
                                            _countryDetails[index].isoalpha2,
                                        continent:
                                            _countryDetails[index].continent,
                                        name: _countryDetails[index].name,
                                        score: _countryDetails[index].score,
                                        updated: _countryDetails[index].updated,
                                        description: _countryDetails[index]
                                            .description)),
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

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _countryDetails.forEach((countryDetail) {
      if (countryDetail.name.toLowerCase().contains(text))
        _searchResult.add(countryDetail);
    });

    setState(() {});
  }
}

List<CountryDetails> _searchResult = [];
List<CountryDetails> _countryDetails = [];

// final String url = 'https://next.json-generator.com/api/json/get/V1gMxow6d';
// final String url = 'https://next.json-generator.com/api/json/get/NyVdbQqTu';
final String url =
    'https://raw.githubusercontent.com/valevich/jsonhost/master/travelwatch/restrictionsadvisories.json';

class CountryDetails {
  final String code, isoalpha2, continent, name, score, updated, description;

  CountryDetails(
      {this.code,
      this.isoalpha2,
      this.continent,
      this.name,
      this.score,
      this.updated,
      this.description});

  factory CountryDetails.fromJson(Map<String, dynamic> json) {
    return new CountryDetails(
      code: json['code'],
      isoalpha2: json['iso_alpha2'],
      continent: json['continent'],
      name: json['name'],
      score: json['score'],
      updated: json['updated'],
      description: json['description'],
    );
  }
}

class Screen2 extends StatefulWidget {
  Screen2(
      {this.code,
      this.isoalpha2,
      this.continent,
      this.name,
      this.score,
      this.updated,
      this.description});
  final String code;
  final String isoalpha2;
  final String continent;
  final String name;
  final String score;
  final String updated;
  final String description;

  @override
  State<StatefulWidget> createState() {
    return new Screen2State();
  }
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
              SizedBox(height: 10.0),
              Text(
                "Extreme Warning (index value: 4.5 - 5)",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    fontFamily: 'Montserrat'),
              ),
              SizedBox(height: 5.0),
              Text(
                "High Risk (index value: 3.5 - 4.5)",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    fontFamily: 'Montserrat'),
              ),
              SizedBox(height: 5.0),
              Text(
                "Medium Risk (index value: 2.5 - 3.5)",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    fontFamily: 'Montserrat'),
              ),
              SizedBox(height: 5.0),
              Text(
                "Low Risk (index value: 0 - 2.5)",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    fontFamily: 'Montserrat'),
              ),
              SizedBox(height: 10.0),
              Divider(color: Colors.black87),

              Image.network(
                "https://www.countryflags.io/${widget.isoalpha2}/flat/64.png",
              ),

              new Text(widget.name ?? "",
                  style: TextStyle(
                      fontWeight: prefix0.FontWeight.w500, fontSize: 25.0)),

              SizedBox(height: 3.0),
              Text(widget.continent ?? ""),

              SizedBox(height: 5.0),
              Divider(color: Colors.black87),

              SizedBox(height: 10.0),
              Text(
                "Travel Risk Level",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    fontFamily: 'Montserrat'),
              ),
              Center(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Text(widget.score ?? "",
                          style: TextStyle(fontSize: 15)))),

              // Text("Details",
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontWeight: FontWeight.bold,
              //     fontSize: 16.0,
              //     fontFamily: 'Montserrat'),),
              // SizedBox(width: 14.0),
              Center(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
                      child: Text(widget.description ?? "",
                          style: TextStyle(fontSize: 15)))),
            ],
          ),
        ),
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
