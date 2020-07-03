import 'package:flutter/material.dart';
import '../services/worldtime.dart';

class WTimeLocation extends StatefulWidget {

  @override
  _WTimeLocationState createState() => _WTimeLocationState();
}

class _WTimeLocationState extends State<WTimeLocation> {

  List<WorldTime> locations=[
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Europe/Moscow', location: 'Moscow', flag: 'ru.png'),
    WorldTime(url: 'Europe/Kiev', location: 'Kiev', flag: 'ua.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'America/Los_Angeles', location: 'Los_Angeles', flag: 'usa.png'),
    WorldTime(url: 'Pacific/Honolulu', location: 'Honolulu', flag: 'usa.png'),
    WorldTime(url: 'America/Toronto', location: 'Toronto', flag: 'ca.png'),
    WorldTime(url: 'America/Vancouver', location: 'Vancouver', flag: 'ca.png'),
    WorldTime(url: 'America/Mexico_City', location: 'Mexico_City', flag: 'mx.png'),
    WorldTime(url: 'America/Argentina/Buenos_Aires', location: 'Buenos_Aires', flag: 'ar.png'),
    WorldTime(url: 'Australia/Melbourne', location: 'Melbourne', flag: 'au.png'),
    WorldTime(url: 'Australia/Sydney', location: 'Sydney', flag: 'au.png'),
    WorldTime(url: 'Asia/Tokyo', location: 'Tokyo', flag: 'jp.png'),
    WorldTime(url: 'Asia/Singapore', location: 'Singapore', flag: 'sg.png'),
    WorldTime(url: 'Asia/Shanghai', location: 'Shanghai', flag: 'cn.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
    WorldTime(url: 'Asia/Kuala_Lumpur', location: 'Kuala_Lumpur', flag: 'my.png'),
    WorldTime(url: 'Asia/Hong_Kong', location: 'Hong_Kong', flag: 'hk.png'),
    WorldTime(url: 'Asia/Bangkok', location: 'Bangkok', flag: 'th.png'),
    WorldTime(url: 'Indian/Maldives', location: 'Maldives', flag: 'mv.png'),
    WorldTime(url: 'Pacific/Tahiti', location: 'Tahiti', flag: 'pf.png'),
    WorldTime(url: 'Asia/Riyadh', location: 'Riyadh', flag: 'sa.png'),
    WorldTime(url: 'Asia/Jerusalem', location: 'Jerusalem', flag: 'il.png'),
    WorldTime(url: 'Asia/Dubai', location: 'Dubai', flag: 'ae.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),


  ];

  void updateTime(index) async{
    WorldTime worldTime=locations[index];
    await worldTime.getTime();
    //Navigate to Home Screen
    Navigator.pop(context,{
      'location':worldTime.location,
      'flag':worldTime.flag,
      'time':worldTime.time,
      'isDayTime':worldTime.isDayTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Choose a Location"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
