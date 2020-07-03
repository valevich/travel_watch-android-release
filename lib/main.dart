import 'package:flutter/material.dart';
import 'views/home.dart';
import 'views/splashscreen.dart';
import 'views/wtime_home.dart';
import 'views/wtime_loading.dart';
import 'views/wtime_location.dart';

// void main() => runApp(MyApp());
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }


void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  routes: {
    '/': (context) => SplashScreen(),
    '/myhomepage': (context) => MyHomePage(),
    '/wthome': (context) => WTimeHome(),
    '/wtloading': (context) => WTimeLoading(),
    '/wtlocation': (context) => WTimeLocation()
  },
));


