import 'package:flutter/material.dart';
import 'advisories.dart';
import 'tipping.dart';
import 'rssfeedhome.dart';
import 'restrictions.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:travel_watch/services/admob_service.dart';
import 'cc_home.dart';
import 'wtime_loading.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedTile = '';

  final ams = AdmobService();
  @override
  void initState() {
    super.initState();
    Admob.initialize(ams.getAddMobAppId());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 400.0,
                ),
                ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black, Colors.transparent])
                          .createShader(
                              Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: Image.asset('assets/3431379.jpg',
                        height: 300.0, fit: BoxFit.cover)),
                RotatedBox(
                  quarterTurns: 3,
                  child: Text('WORLD',
                      style: TextStyle(
                          fontSize: 75,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.3),
                          letterSpacing: 10.0)),
                ),
                // Positioned(
                //   top: 4.0,
                //   right: 4.0,
                //   child: Container(
                //     height: 40.0,
                //     width: 40.0,
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(20.0),
                //         color: Colors.white),
                //     child: Center(
                //       child: Icon(Icons.menu),
                //     ),
                //   ),
                // ),
                // Positioned(
                //   top: 2.0,
                //   right: 5.0,
                //   child: Container(
                //     height: 12.0,
                //     width: 12.0,
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(6.0),
                //         color: Color(0xFFFD3664)),
                //   ),
                // ),
                Positioned(
                    top: 260.0,
                    left: 40.0,
                    child: Column(
                      children: <Widget>[
                        Text('WELCOME TO',
                            style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: 32.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white))
                      ],
                    )),
                Positioned(
                    top: 300.0,
                    left: 40.0,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('TRAVEL',
                                style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontSize: 50.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFD3664))),
                            Text('',
                                style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontSize: 50.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            SizedBox(width: 10.0),
                            Text('WATCH',
                                style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontSize: 50.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ],
                        )
                      ],
                    )),
                // Search Box Here....
                // Positioned(
                //     top: 320.0,
                //     left: 25.0,
                //     right: 25.0,
                //     child: Container(
                //         height: 50.0,
                //         decoration: BoxDecoration(
                //             color: Color(0xFF262626),
                //             borderRadius: BorderRadius.only(
                //                 bottomRight: Radius.circular(15.0),
                //                 bottomLeft: Radius.circular(15.0),
                //                 topLeft: Radius.circular(15.0),
                //                 topRight: Radius.circular(15.0))),
                //         child: TextField(
                //           decoration: InputDecoration(
                //               border: InputBorder.none,
                //               hintText: 'Lets explore world travel here...',
                //               hintStyle: TextStyle(
                //                   color: Colors.grey,
                //                   fontFamily: 'Montserrat',
                //                   fontSize: 12.0),
                //               contentPadding: EdgeInsets.only(top: 15.0),
                //               prefixIcon: Icon(Icons.search, color: Colors.grey)),
                //         )))
              ],
            ),

            //Get out of the stack for the options
            // SizedBox(height: 25.0),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _buildMenuItem('TRAVEL RESTRICTIONS', Icons.flight_takeoff),
              _buildMenuItem('TRAVEL ADVISORIES', Icons.info_outline),
              _buildMenuItem('CURRENCY EXCHANGE', Icons.monetization_on),
            ]),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildMenuItem('TIPS BY COUNTRY', Icons.euro_symbol),
                _buildMenuItem('WORLD TIME', Icons.watch_later),
                _buildMenuItem('TRAVEL DEALS', Icons.airplanemode_active),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: <Widget>[
            //     _buildMenuItem('ASIA', Icons.beach_access),
            //     _buildMenuItem('OCEANIA', Icons.directions_railway),
            //     _buildMenuItem('------', Icons.map),
            //   ],
            // )
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
                ))));
  }

  Widget _buildMenuItem(String tileName, iconData) {
    return InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          selectMenuOption(tileName);
          if (tileName == 'TRAVEL RESTRICTIONS') {
            // Navigator.push(context,MaterialPageRoute(builder: (context) => AllCountries()),);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RestrictList()),
            );
          } else if (tileName == 'TRAVEL ADVISORIES') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Advisories()),
            );
          } else if (tileName == 'CURRENCY EXCHANGE') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ConvertHome()),
            );
          } else if (tileName == 'TIPS BY COUNTRY') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Tipping()),
            );
            // } else if (tileName == 'WORLD TIME') {
            //   Navigator.pushNamed(context, '/wtloading');
          } else if (tileName == 'WORLD TIME') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WTimeLoading()),
            );
          } else if (tileName == 'TRAVEL DEALS') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RSSFeedHome()),
            );
          }
        },
        child: AnimatedContainer(
            curve: Curves.easeIn,
            duration: Duration(milliseconds: 300),
            height: selectedTile == tileName ? 100.0 : 75.0,
            width: selectedTile == tileName ? 100.0 : 75.0,
            color: selectedTile == tileName
                ? Color(0xFFFD3566)
                : Colors.transparent,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                iconData,
                color: selectedTile == tileName ? Colors.white : Colors.grey,
                size: 25.0,
              ),
              SizedBox(height: 12.0),
              Text(tileName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color:
                          selectedTile == tileName ? Colors.white : Colors.grey,
                      fontSize: 10.0))
            ])));
  }

  selectMenuOption(String tileName) {
    setState(() {
      selectedTile = tileName;
    });
  }
}

// MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//   keywords: <String>['travel', 'alerts'],
//   contentUrl: 'https://flutter.io',
//   // birthday: DateTime.now(),
//   childDirected: false,
//   // designedForFamilies: false,
//   // gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
//   testDevices: <String>[], // Android emulators are considered test devices
// );

// BannerAd myBanner = BannerAd(
//   // Replace the testAdUnitId with an ad unit id from the AdMob dash.
//   // https://developers.google.com/admob/android/test-ads
//   // https://developers.google.com/admob/ios/test-ads
//   adUnitId: BannerAd.testAdUnitId,
//   size: AdSize.banner,
//   targetingInfo: targetingInfo,
//   listener: (MobileAdEvent event) {
//     print("BannerAd event is $event");
//   },
// );
