import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/worldtime.dart';

class WTimeLoading extends StatefulWidget {
  @override
  _WTimeLoadingState createState() => _WTimeLoadingState();
}

class _WTimeLoadingState extends State<WTimeLoading> {

  void setUpWorldTime() async{
    WorldTime worldTime=WorldTime(location:'London',flag: 'null',url: 'Europe/London');
    await worldTime.getTime();

    Navigator.pushReplacementNamed(context,'/wthome',arguments: {
      'location':worldTime.location,
      'flag':worldTime.flag,
      'time':worldTime.time,
      'isDayTime':worldTime.isDayTime,
    });

  }

  @override
  void initState() {
    super.initState();
    setUpWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
          child: SpinKitCubeGrid(
        color: Colors.white,
        size: 50.0,
      ),
      ),
    );
  }
}
