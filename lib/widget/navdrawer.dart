import 'package:flutter/material.dart';
import 'package:NewApp/pages/locationposts.dart';

class NavDrawer extends StatelessWidget {
  final cities = [
    'Chicago',
    'Columbus',
    'Denver',
    'Los Angeles',
    'New York',
    'San Francisco',
    'Orlando',
    'Phoenix',
    'Boston',
    'Washington DC'
  ];
  final colleges = [
    'Ohio State',
    'University of Michigan',
    'Michigan State',
    'Penn State',
    'University of Illinois',
    'University of Wisconsin'
  ];

  clickCitiesTab(String location, context) {
    Navigator.pushReplacementNamed(
      context,
      LocationPosts.route,
      arguments: location,
    );
  }

  clickCollegeOption(String location, context) {
    Navigator.pushReplacementNamed(
      context,
      LocationPosts.route,
      arguments: location,
    );
  }

  List<Widget> _cityOption(context) {
    List<Widget> options = [];
    for (int i = 0; i < cities.length; i++) {
      Widget divider = Divider(
        color: Colors.grey,
      );
      options.add(divider);
      Widget temp = GestureDetector(
        child: _optionContainer(cities[i]),
        onTap: () => clickCitiesTab(cities[i], context),
      );
      options.add(temp);
    }
    return options;
  }

  List<Widget> _collegeOption(context) {
    List<Widget> options = [];
    for (int i = 0; i < colleges.length; i++) {
      Widget divider = Divider(
        color: Colors.grey,
      );
      options.add(divider);
      Widget temp = GestureDetector(
        child: _optionContainer(colleges[i]),
        onTap: () => clickCollegeOption(colleges[i], context),
      );
      options.add(temp);
    }
    return options;
  }

  Widget _optionContainer(option) {
    return Container(
      margin: const EdgeInsets.all(9.0),
      padding: const EdgeInsets.all(3.0),
      child: Text(
        option,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 120,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.red),
              child: Text(
                'Search these locations',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ExpansionTile(
            title: Text(
              'Cities',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            children: _cityOption(context),
          ),
          ExpansionTile(
            title: Text(
              'Colleges',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            children: _collegeOption(context),
          ),
        ],
      ),
    );
  }
}
