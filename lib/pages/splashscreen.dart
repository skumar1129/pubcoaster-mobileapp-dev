import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
