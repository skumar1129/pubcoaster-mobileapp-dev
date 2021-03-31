import 'package:flutter/material.dart';

class LandPage extends StatelessWidget {
  final String status;
  LandPage(this.status);

  Widget loading() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          Text(
            'Loading....',
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
      ),
    );
  }

  Widget error() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          Text(
            'An error has occurred, try restarting the app',
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
      ),
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
