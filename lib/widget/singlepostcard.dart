import 'package:flutter/material.dart';

class SinglePostCard extends StatefulWidget {
  final String bar;
  final String location;
  final String username;
  final int rating;
  final String timestamp;
  final String neighborhood;
  final String editedAt;
  final String picLink;
  final String uuid;
  final bool anonymous;
  final String description;
  final List<dynamic> comments;
  final List<dynamic> likes;
  SinglePostCard(
      this.bar,
      this.location,
      this.username,
      this.rating,
      this.timestamp,
      this.neighborhood,
      this.editedAt,
      this.picLink,
      this.uuid,
      this.description,
      this.anonymous,
      this.comments,
      this.likes);

  @override
  _SinglePostCardState createState() => _SinglePostCardState();
}

class _SinglePostCardState extends State<SinglePostCard> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
