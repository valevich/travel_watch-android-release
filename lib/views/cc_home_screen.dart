import 'package:flutter/material.dart';
import '../views/cc_row_buttons.dart';
import '../views/cc_Info_page.dart';
import '../views/cc_converter_page.dart';
import 'home.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:travel_watch/services/admob_service.dart';

class CurrencyHomeScreen extends StatefulWidget {
  @override
  _CurrencyHomeScreenState createState() => _CurrencyHomeScreenState();
}

class _CurrencyHomeScreenState extends State<CurrencyHomeScreen> {
  int _pageIndexHolder = 0;
  final ams = AdmobService();

  List<Widget> _listPages = [ConverterPage(), InfoPage()];
  @override
  Widget build(BuildContext context) {
    Admob.initialize(ams.getAddMobAppId());
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: new Text("Currency Converter"),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          },
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            RowButtons(
              onSave: (pageIndexValue) {
                if (mounted)
                  setState(() {
                    _pageIndexHolder = pageIndexValue;
                  });
              },
              activePageIndex: _pageIndexHolder,
            ),
            Expanded(
              child: _listPages[_pageIndexHolder],
            )
          ],
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
