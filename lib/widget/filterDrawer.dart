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
  String bar = '';
  String nbhood = '';
  String user = '';

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
          Container(
            height: 120,
            child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.red),
                child: Text(
                  'Search ${widget.location} by...',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2, bottom: 12, right: 2),
            child: TextField(
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  hintText: 'Bar',
                  hintStyle: TextStyle(color: Colors.black, fontSize: 17),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      goToLocBarPage(bar);
                    },
                  )),
              onChanged: (value) => {
                if (mounted)
                  {
                    setState(() => {bar = value})
                  }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2, bottom: 12, right: 2),
            child: TextField(
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  hintText: 'Neighborhood',
                  hintStyle: TextStyle(color: Colors.black, fontSize: 17),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      goToLocNbhoodPage(nbhood);
                    },
                  )),
              onChanged: (value) => {
                if (mounted)
                  {
                    setState(() => {nbhood = value})
                  }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2, bottom: 12, right: 2),
            child: TextField(
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  hintText: 'User',
                  hintStyle: TextStyle(color: Colors.black, fontSize: 17),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      goToLocUserPage(user);
                    },
                  )),
              onChanged: (value) => {
                if (mounted)
                  {
                    setState(() => {user = value})
                  }
              },
            ),
          ),
        ],
      ),
    );
  }
}
