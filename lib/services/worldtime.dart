import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime{
  String location;
  String time;
  String flag;
  String url;
  bool isDayTime;

  WorldTime({this.location,this.flag,this.url});

  Future<void> getTime() async{

    try{
      Response response=await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      print(data);

      String dateTime=data['datetime'];
      // String offset=data['utc_offset'];

      String offsetHour=data['utc_offset'].toString().substring(0,3);
      String offsetMin=data['utc_offset'].toString().substring(4,6);


      print('$offsetHour - $offsetMin');

      DateTime now=DateTime.parse(dateTime);
      now=now.add(Duration(hours: int.parse(offsetHour),minutes: int.parse(offsetMin)));
      print(now);

      isDayTime=now.hour > 6 && now.hour < 18 ? true:false;

      time=DateFormat.jm().format(now);
    }catch(exception){
       time="Could Not Get Time";
    }


  }
}