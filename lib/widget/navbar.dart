import 'package:flutter/material.dart';
import 'package:NewApp/pages/locationposts.dart';
import 'package:NewApp/pages/userposts.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String location = '';
  String user;

  searchUser(String search) {
    Navigator.pushNamed(context, UserPosts.route, arguments: search);
  }

  clickLocationTab(String location) {
    String routeParam = '';
    switch (location) {
      case 'Columubs':
        {
          routeParam = 'Columbus';
        }
        break;

      case 'Chicago':
        {
          routeParam = 'Chicago';
        }
        break;

      case 'New York':
        {
          routeParam = 'New York';
        }
        break;

      case 'Denver':
        {
          routeParam = 'Denver';
        }
        break;

      case 'Washington DC':
        {
          routeParam = 'Washington DC';
        }
        break;

      case 'Los Angeles':
        {
          routeParam = 'Los Angeles';
        }
        break;

      case 'Phoenix':
        {
          routeParam = 'Phoenix';
        }
        break;

      case 'Orlando':
        {
          routeParam = 'Orlando';
        }
        break;

      case 'Boston':
        {
          routeParam = 'Boston';
        }
        break;

      case 'San Francisco':
        {
          routeParam = 'San Francisco';
        }
        break;
    }
    Navigator.pushReplacementNamed(
      context,
      LocationPosts.route,
      arguments: routeParam,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Barz BRO',
        style: TextStyle(fontFamily: 'Oxygen-Regular'),
      ),
      backgroundColor: Colors.red,
      actions: <Widget>[
        Expanded(
          child: TextField(
            decoration: InputDecoration(
                border: UnderlineInputBorder(), hintText: 'Search User'),
            onChanged: (value) => {
              if (mounted)
                {
                  setState(() => {user = value})
                }
            },
          ),
        ),
        Container(
          child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
            focusColor: Colors.grey,
            items: [
              'Chicago',
              'Columbus',
              'Denver',
              'Los Angeles',
              'New York',
              'San Francisco',
              'Orlando',
              'Phoenix',
              'Boston',
              'Los Angeles'
            ]
                .map((String value) => DropdownMenuItem(
                      child: Text(
                        value,
                      ),
                      value: value,
                    ))
                .toList(),
            isDense: true,
            onChanged: (String value) {
              clickLocationTab(value);
            },
            icon: Icon(Icons.location_city),
            iconEnabledColor: Colors.white,
            isExpanded: false,
          )),
        ),
      ],
    );
  }
}
