import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreenState extends StatefulWidget {
  @override
  SplashScreen createState() => SplashScreen();
}

class SplashScreen extends State<SplashScreenState> {
  @override
  void initState() {
    super.initState();
    showScreen();
  }

  showScreen() {
    Timer(Duration(milliseconds: 750), () {
      navigateUser();
    });
  }

  navigateUser() async {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/img/splash_screen.jpg"),
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
