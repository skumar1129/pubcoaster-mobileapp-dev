import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:NewApp/pages/feedpostpage.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/signin');
  }

  Widget _signOutDialog() {
    return AlertDialog(
      title: Text(
        'Are you sure you want to sign out?',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 23),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.white,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            child: Icon(Icons.cancel),
            onPressed: () => Navigator.of(context).pop(),
            tooltip: 'Cancel',
            backgroundColor: Colors.red,
          ),
          FloatingActionButton(
            child: Icon(Icons.check),
            tooltip: 'Confirm',
            onPressed: () => _signOut(),
            backgroundColor: Colors.red,
          )
        ],
      ),
    );
  }

  _bottomTap(int index) async {
    switch (index) {
      case 0:
        {
          String? user = FirebaseAuth.instance.currentUser?.displayName;
          if (user != null) {
            Navigator.pushReplacementNamed(context, FeedPostPage.route,
                arguments: user);
          } else {
            Navigator.pushReplacementNamed(context, '/signin');
          }
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
        {
          showDialog(
            context: context,
            builder: (BuildContext content) {
              return _signOutDialog();
            },
          );
        }
        break;
    }
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
              icon: Icon(Icons.chevron_right), label: 'Log Out'),
        ],
        onTap: _bottomTap,
      ),
    );
  }
}
