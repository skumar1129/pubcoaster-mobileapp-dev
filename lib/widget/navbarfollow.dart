import 'package:flutter/material.dart';

class NavBarFollow extends StatelessWidget {
  NavBarFollow(this.route, this.user, this.myUser);
  final String route;
  final String user;
  final String? myUser;
  goBack(context) {
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Pubcoasters',
        style: TextStyle(fontFamily: 'Oxygen-Regular', fontSize: 21),
      ),
      leading: IconButton(
        icon: Icon(Icons.chevron_left),
        onPressed: () {
          goBack(context);
        },
      ),
      backgroundColor: Colors.red,
    );
  }
}
