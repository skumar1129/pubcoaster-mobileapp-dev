import 'package:flutter/material.dart';
import 'package:NewApp/models/userpagesargs.dart';

class NavBarFollow extends StatelessWidget {
  NavBarFollow(this.route, [this.user, this.myUser]);
  final String route;
  final String? user;
  final String? myUser;

  goBack(context) {
    if (route == '/mypost') {
      Navigator.pushReplacementNamed(context, route);
    } else {
      Navigator.pushReplacementNamed(context, route,
          arguments: UserPages(user: user!, myUser: myUser!));
    }
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
