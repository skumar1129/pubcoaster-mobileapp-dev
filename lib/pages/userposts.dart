import 'package:flutter/material.dart';

class UserPosts extends StatefulWidget {
  UserPosts(this.user);
  final String user;
  static const route = '/userposts';

  @override
  _UserPostsState createState() => _UserPostsState();
}

class _UserPostsState extends State<UserPosts> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
