import 'package:flutter/material.dart';
import 'package:NewApp/pages/userlocation.dart';
import 'package:NewApp/pages/userbar.dart';
import 'package:NewApp/pages/usernbhood.dart';
import 'package:NewApp/pages/userposts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:NewApp/models/userpagesargs.dart';

class UserFilter extends StatefulWidget {
  UserFilter(this.user);
  final String user;
  @override
  _UserFilterState createState() => _UserFilterState();
}

class _UserFilterState extends State<UserFilter> {
  String bar = '';
  String location = '';
  String nbhood = '';
  String newUser = '';
  String? myUser = FirebaseAuth.instance.currentUser?.displayName;

  goToUserLocationPage(String input) {
    Navigator.pushReplacementNamed(context, UserLocation.route,
        arguments: UserPages(user: '${widget.user}-$input', myUser: myUser!));
  }

  goToUserBarPage(String input) {
    Navigator.pushReplacementNamed(context, UserBar.route,
        arguments: UserPages(user: '${widget.user}-$input', myUser: myUser!));
  }

  goToUserNbhoodPage(String input) {
    Navigator.pushReplacementNamed(context, UserNbhood.route,
        arguments: UserPages(user: '${widget.user}-$input', myUser: myUser!));
  }

  goToUserPage(String input) {
    Navigator.pushReplacementNamed(context, UserPosts.route,
        arguments: UserPages(user: newUser, myUser: myUser!));
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
                'Search ${widget.user}\'s posts by...',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2, bottom: 12, right: 2),
            child: TextField(
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  hintText: 'Location',
                  hintStyle: TextStyle(color: Colors.black, fontSize: 17),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      goToUserLocationPage(location);
                    },
                  )),
              onChanged: (value) => {
                if (mounted)
                  {
                    setState(() => {location = value})
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
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  hintText: 'Bar',
                  hintStyle: TextStyle(color: Colors.black, fontSize: 17),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      goToUserBarPage(bar);
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
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  hintText: 'Neighborhood',
                  hintStyle: TextStyle(color: Colors.black, fontSize: 17),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      goToUserNbhoodPage(nbhood);
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
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  hintText: 'Search For Different User',
                  hintStyle: TextStyle(color: Colors.black, fontSize: 17),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      goToUserPage(newUser);
                    },
                  )),
              onChanged: (value) => {
                if (mounted)
                  {
                    setState(() => {newUser = value})
                  }
              },
            ),
          ),
        ],
      ),
    );
  }
}
