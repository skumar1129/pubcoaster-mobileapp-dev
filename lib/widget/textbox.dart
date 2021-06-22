import 'package:flutter/material.dart';
import 'package:NewApp/pages/userposts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:NewApp/models/userpagesargs.dart';

class TextBox extends StatefulWidget {
  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  searchUser(String search) {
    Navigator.pushNamed(context, UserPosts.route,
        arguments: UserPages(user: user, myUser: myUser!));
  }

  String user = '';
  String? myUser = FirebaseAuth.instance.currentUser!.displayName;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Username',
              hintStyle: TextStyle(fontSize: 17),
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  searchUser(user);
                },
              )),
          onChanged: (value) => {
            if (mounted)
              {
                setState(() => {user = value})
              }
          },
        ),
      ),
    );
  }
}
