import 'package:flutter/material.dart';
import 'package:NewApp/widget/navbarhome.dart';
import 'package:NewApp/widget/bottomnav.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
        NavBar(),
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Divider(thickness: 0.5, color: Colors.white),
              SizedBox(height: MediaQuery.of(context).size.height * .03),
              Padding(
                padding: const EdgeInsets.only(right: 3, left: 3),
                child: Text(
                  'Welcome to Knew Barz!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Hindsiliguri-Bold',
                    decoration: TextDecoration.underline
                  ),
                ),
              ),
              const Divider(thickness: .5, color: Colors.white),
              Padding(
                padding: const EdgeInsets.only(right: 3, left: 3),
                child: Text(
                  'Check out the vibes of the bars tonight or check out top bars in your area!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Hindsiliguri-Regular'),
                ),
              ),
              const Divider(thickness: 0.5, color: Colors.white),
              Padding(
                padding: const EdgeInsets.only(right: 3, left: 3),
                child: Text(
                  'All rated by fellow bros! Pick a city or search for a specific user to get started!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Hindsiliguri-Regular'),
                ),
              ),
              const Divider(thickness: 15, color: Colors.white),
              Image(
                image: AssetImage('assets/img/home_page.jpg'),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .3
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .05)
            ],
          ),
        ),
      ]),
      bottomNavigationBar: BottomNav(),
    );
  }
}
