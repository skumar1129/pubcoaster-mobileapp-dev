import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
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
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, '/signin');
      } else if (user.emailVerified == false) {
        Navigator.pushReplacementNamed(context, '/verifyemail');
      } else if (user.displayName == null) {
        Navigator.pushReplacementNamed(context, '/adduserinfo');
      } else {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
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
