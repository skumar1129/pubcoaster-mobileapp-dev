import 'package:flutter/material.dart';
import 'package:NewApp/pages/locbarposts.dart';
import 'package:NewApp/pages/locnbhoodposts.dart';
import 'package:NewApp/pages/locuserposts.dart';

class FilterDrawer extends StatefulWidget {
  FilterDrawer(this.location);
  final String location;
  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  String bar;
  String nbhood;
  String user;

  goToLocBarPage(String input) {
    Navigator.pushReplacementNamed(context, LocBarPosts.route,
        arguments: '${widget.location}-$input');
  }

  goToLocNbhoodPage(String input) {
    Navigator.pushReplacementNamed(context, LocNbhoodPosts.route,
        arguments: '${widget.location}-$input');
  }

  goToLocUserPage(String input) {
    Navigator.pushReplacementNamed(context, LocUserPosts.route,
        arguments: '${widget.location}-$input');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: Colors.red),
              child: Text(
                'Search ${widget.location} by',
                style: TextStyle(color: Colors.white),
              )),
          TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Bar',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    goToLocBarPage(bar);
                  },
                )),
            onChanged: (value) => {
              setState(() => {bar = value})
            },
          ),
          TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Neighborhood',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    goToLocNbhoodPage(nbhood);
                  },
                )),
            onChanged: (value) => {
              setState(() => {nbhood = value})
            },
          ),
          TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'User',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    goToLocUserPage(user);
                  },
                )),
            onChanged: (value) => {
              setState(() => {user = value})
            },
          ),
        ],
      ),
    );
  }
}
