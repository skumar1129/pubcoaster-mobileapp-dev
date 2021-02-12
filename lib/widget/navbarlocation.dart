import 'package:flutter/material.dart';
import 'dropdown.dart';

class NavBarLoc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NEW APP',
          style: TextStyle(fontFamily: 'Oxygen-Regular'),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        actions: [
          DropDown(),
          const SizedBox(
            width: 15,
          )
        ],
        backgroundColor: Colors.red,
      ),
    );
  }
}
