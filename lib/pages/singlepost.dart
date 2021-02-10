import 'package:flutter/material.dart';

class SinglePost extends StatefulWidget {
  SinglePost(this.uuid);
  final String uuid;
  static const route = '/singlepost';

  @override
  _SinglePostState createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
