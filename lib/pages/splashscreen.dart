import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:NewApp/pages/signin.dart';
import 'package:NewApp/pages/verifyemail.dart';
import 'package:NewApp/pages/adduserinfo.dart';
import 'package:NewApp/pages/home.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user;
            if (snapshot.hasData) {
              user = snapshot.data as User;
            }
            if (user == null) {
              return SignIn();
            } else if (user.emailVerified == false) {
              return VerifyEmail();
            } else if (user.displayName == null) {
              return AddUserInfo();
            } else {
              return Home();
            }
          } else {
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
        });
  }
}
