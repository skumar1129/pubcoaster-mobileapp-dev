import 'package:flutter/material.dart';
import 'package:NewApp/widget/textbox.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String location = '';

  bool typing = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: typing
          ? TextBox()
          : const Text(
              'Pubcoasters',
              style: TextStyle(fontFamily: 'Oxygen-Regular', fontSize: 21),
            ),
      leading: IconButton(
        icon: Icon(typing ? Icons.chevron_left : Icons.search, size: 30),
        onPressed: () {
          if (mounted) {
            setState(() {
              typing = !typing;
            });
          }
        },
        tooltip: 'Search User',
      ),
      backgroundColor: Colors.red,
    );
  }
}
