import 'package:flutter/material.dart';
import 'package:NewApp/pages/home.dart';
import 'package:NewApp/pages/splashscreen.dart';
import 'package:NewApp/pages/createpost.dart';
import 'package:NewApp/pages/locationposts.dart';
import 'package:NewApp/pages/locbarposts.dart';
import 'package:NewApp/pages/locnbhoodposts.dart';
import 'package:NewApp/pages/locuserposts.dart';
import 'package:NewApp/pages/myposts.dart';
import 'package:NewApp/pages/signup.dart';
import 'package:NewApp/pages/singlepost.dart';
import 'package:NewApp/pages/userposts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        fontFamily: 'CrimsonText-Bold',
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {'/': (context) => SplashScreenState()},
      onGenerateRoute: (RouteSettings settings) {},
    );
  }
}
