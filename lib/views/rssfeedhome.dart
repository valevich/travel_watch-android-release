import 'package:flutter/material.dart';
import '../models/rssfeed_model.dart';
import 'rssfeedlist.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:travel_watch/services/admob_service.dart';


class RSSFeedHome extends StatefulWidget {

  @override
  _RSSFeedHomeState createState() => _RSSFeedHomeState();
}

class _RSSFeedHomeState extends State<RSSFeedHome> {

  List data;
  // String url = "https://next.json-generator.com/api/json/get/Vy02nG83_";
  String url = "https://raw.githubusercontent.com/valevich/jsonhost/master/travelwatch/traveldeals.json";


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
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.redAccent,
        backgroundColor: Colors.black87,
        title: Text("Choose Travel Feed"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: data == null ? 0: data.length,
        // itemCount: feedurl.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  // updateTime(index);
                  RSSFeeds.myfeed = data[index]['rss_url'];
                  Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RSSFeedList(),
                                  ),
                              );
                },
                title: Text(data[index]['title']),
                subtitle: Text(data[index]['description']),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(data[index]['image_url']),
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  size: 15.0,
                  color: Colors.brown[900],
                ),
              ),
            ),
          );
        },
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
}
