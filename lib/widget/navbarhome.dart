import 'package:flutter/material.dart';
import 'package:NewApp/widget/textbox.dart';
import 'dropdown.dart';

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
              'Knew Barz',
              style: TextStyle(fontFamily: 'Oxygen-Regular'),
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
      actions: <Widget>[
        DropDown(),
        const SizedBox(
          width: 15,
        )
      ],
    );
  }
}
