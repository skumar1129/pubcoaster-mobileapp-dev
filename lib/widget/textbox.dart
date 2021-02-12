import 'package:flutter/material.dart';
import 'package:NewApp/pages/userposts.dart';

class TextBox extends StatefulWidget {
  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  searchUser(String search) {
    Navigator.pushNamed(context, UserPosts.route, arguments: search);
  }

  String user = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Username',
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                searchUser(user);
              },
            )),
        onChanged: (value) => {
          setState(() => {user = value})
        },
      ),
    );
  }
}
