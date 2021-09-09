import 'package:flutter/material.dart';

class NavBarLoc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Pubcoasters',
        style: TextStyle(fontFamily: 'Oxygen-Regular', fontSize: 21),
      ),
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      backgroundColor: Colors.red,
    );
  }
}
