import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  _bottomTap(int index) async {
    switch (index) {
      case 0:
        {
          Navigator.pushReplacementNamed(context, '/home');
        }
        break;
      case 1:
        {
          Navigator.pushReplacementNamed(context, '/mypost');
        }
        break;
      case 2:
        {
          Navigator.pushReplacementNamed(context, '/createpost');
        }
        break;
      case 3:
        {}
        break;
      case 4:
        {
          await FirebaseAuth.instance.signOut();
          Navigator.pushReplacementNamed(context, '/signin');
        }
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.red),
      child: BottomNavigationBar(
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.comment), label: 'My Posts'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle), label: 'Add Post'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chevron_right), label: 'Log Out'),
        ],
        onTap: _bottomTap,
      ),
    );
  }
}
