import 'package:flutter/material.dart';
import 'package:NewApp/pages/locationposts.dart';

class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String location = '';

  clickLocationTab(String location) {
    String routeParam = '';
    switch (location) {
      case 'Columbus':
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
    return Container(
        child: Tooltip(
      message: 'Search Location',
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
          'Los Angeles',
          'Washinton DC'
        ]
            .map((String value) => DropdownMenuItem(
                  child: Text(
                    value,
                  ),
                  value: value,
                ))
            .toList(),
        isDense: true,
        onChanged: (String? value) {
          clickLocationTab(value!);
        },
        icon: Icon(Icons.location_city),
        iconEnabledColor: Colors.white,
        isExpanded: false,
      )),
    ));
  }
}
