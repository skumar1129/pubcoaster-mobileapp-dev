import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:strings/strings.dart';
import 'dart:convert';

class FeedPostCard extends StatelessWidget {
  final String bar;
  final String location;
  final String username;
  final String content;
  final int rating;
  final String timestamp;
  final String neighborhood;
  final int numComments;
  final int numLikes;
  final bool anonymous;
  final String editedAt;
  final String picLink;
  final String uuid;

  FeedPostCard(
      this.bar,
      this.location,
      this.username,
      this.content,
      this.rating,
      this.timestamp,
      this.neighborhood,
      this.numComments,
      this.numLikes,
      this.anonymous,
      this.editedAt,
      this.picLink,
      this.uuid);

  @override
  Widget build(BuildContext context) {
    String goodContent = utf8.decode(content.codeUnits);
    // String goodUsername = utf8.decode(username.codeUnits);
    // String goodNbhood = utf8.decode(neighborhood.codeUnits);
    String goodBar = utf8.decode(bar.codeUnits);
    String goodLocation = utf8.decode(location.codeUnits);
    // var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return Card(
      color: Colors.black,
      child: Column(
        children: [
          ListTile(
            title: Text(
              capitalize(goodBar),
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Merriweather-Bold'),
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
          Text(
            goodContent,
            style: TextStyle(
                color: Colors.white, fontFamily: 'Merriweather-Regular'),
          ),
          const Divider(
            color: Colors.white,
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  'Username',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Merriweather-Regular'),
                ),
              ),
              Flexible(
                  child: Text(
                'User Rating: $rating/10',
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Merriweather-Regular'),
              ))
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          const Divider(
            color: Colors.black,
            thickness: 0.5,
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  // timeago.format(date),
                  'Yo',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Merriweather-Italic'),
                  softWrap: true,
                ),
              ),
              Flexible(
                  child: Text(
                '$goodLocation',
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Merriweather-Regular'),
                softWrap: true,
              ))
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          const Divider(
            color: Colors.black,
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}
