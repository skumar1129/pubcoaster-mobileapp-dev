import 'package:flutter/material.dart';

class LandPage extends StatelessWidget {
  final String status;
  LandPage(this.status);

  Widget loading() {
    return Stack(
      children: [
        Text(
          'Loading....',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: 'Hindsiliguri-Bold',
              color: Colors.black),
        ),
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/splash_screen.jpg"),
                fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }

  Widget error() {
    return Stack(
      children: [
        Text(
          'An error has occurred, try restarting the app',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: 'Hindsiliguri-Bold',
              color: Colors.black),
        ),
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/splash_screen.jpg"),
                fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (status == 'loading') {
      return loading();
    } else {
      return error();
    }
  }
}
