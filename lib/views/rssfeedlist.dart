import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/rssfeed_model.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:travel_watch/services/admob_service.dart';


enum FeedType { RSS, Atom }

Future<RssFeed> _getFeedData(
  http.Client client, String url, FeedType type) async {
    http.Response response = await client.get(url);
    String body = response.body;

    var feed;
    switch (type) {
      case FeedType.RSS:
        feed = RssFeed.parse(body);
        break;
      case FeedType.Atom:
        feed = AtomFeed.parse(body);
        break;
      default:
        print("Type must be RSS or Atom");
  }

  return feed;
}



class RSSFeedList extends StatefulWidget {
  RSSFeedList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RSSFeedListState createState() => new _RSSFeedListState();
}

class _RSSFeedListState extends State<RSSFeedList> {
  var client = http.Client();
  final ams = AdmobService();

  @override
  Widget build(BuildContext context) {
    Admob.initialize(ams.getAddMobAppId());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Travel Deals'),
      ),
      body: FutureBuilder(
        future: _getFeedData(client, RSSFeeds.myfeed, FeedType.RSS),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError)
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              else {
                final feed = snapshot.data;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    // final imageUrl = feed.items[index].description.substring(
                    //     feed.items[index].description.indexOf('<img src="') +
                    //         '<img src="'.length,
                    //     feed.items[index].description.indexOf('" />'));
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            // FadeInImage.memoryNetwork(
                            //     placeholder: kTransparentImage,
                            //     image: imageUrl),
                            ExpansionTile(
                              title: Text(feed.items[index].title),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child:
                                      Html(data: feed.items[index].description),
                                ),
                                MaterialButton(
                                  onPressed: () async {
                                    String url = feed.items[index].link;
                                    if (await canLaunch(url)) {
                                      await launch(
                                        url,
                                        forceSafariVC: true,
                                        forceWebView: true,
                                      );
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  color: Theme.of(context).primaryColor,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.launch),
                                      SizedBox(
                                        width: 8.0,
                                      ),
                                      Text('launch'.toUpperCase())
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: feed.items.length,
                );
              }
          }
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
