import 'dart:convert';
import 'dart:io';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:strings/strings.dart';

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
    String goodContent = utf8.decode(widget.description.codeUnits);
    String goodBar = utf8.decode(widget.bar.codeUnits);
    String goodLocation = utf8.decode(widget.location.codeUnits);
    var newDate = HttpDate.parse(widget.timestamp);
    // TODO: Look into better way to get real time
    var date = newDate.add(Duration(hours: 5));
    return Card(
        color: Colors.black,
        child: Column(
          children: [
            // ListTile(
            Row(
              children: [
                Flexible(
                  child: Text(
                    capitalize(goodBar),
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Merriweather-Bold'),
                  ),
                ),
                Flexible(
                    child: Text(
                  'User Rating: ${widget.rating}/10',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Merriweather-Regular'),
                ))
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            // ),
            const Divider(
              color: Colors.white,
            ),
            (() {
              if (widget.picLink != '') {
                return Column(children: [
                  Image(image: NetworkImage('${widget.picLink}')),
                  const Divider(
                    color: Colors.white,
                  )
                ]);
              } else {
                return Container();
              }
            }()),
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
                (() {
                  if (widget.username != null) {
                    String goodUsername = utf8.decode(widget.username.codeUnits);
                    return Flexible(
                      child: Text(
                        '$goodUsername',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Merriweather-Regular'),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }()),
                (() {
                  if (widget.likes.length == 0) {
                    return Flexible(
                        child: Text(
                      'No Likes Yet',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Merriweather-Regular'),
                    ));
                  } else if (widget.likes.length == 1) {
                    return Flexible(
                        child: Text(
                      '${widget.likes.length} like',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Merriweather-Regular'),
                    ));
                  } else {
                    return Flexible(
                        child: Text(
                      '${widget.likes.length} likes',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Merriweather-Regular'),
                    ));
                  }
                }())
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
                    timeago.format(date.toLocal()),
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Merriweather-Italic'),
                    softWrap: true,
                  ),
                ),
                (() {
                  if (widget.neighborhood != null) {
                    String goodNbhood = utf8.decode(widget.neighborhood.codeUnits);
                    return Flexible(
                        child: Text(
                      '${capitalize(goodNbhood)}, $goodLocation',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Merriweather-Regular'),
                      softWrap: true,
                    ));
                  } else {
                    return Flexible(
                        child: Text(
                      '$goodLocation',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Merriweather-Regular'),
                      softWrap: true,
                    ));
                  }
                }())
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            const Divider(
              color: Colors.white,
            ),
            Row(
              children: [
                (() {
                  if (widget.comments.length == 0) {
                    return Flexible(
                        child: Text(
                      'No comments yet',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Merriweather-Regular'),
                    ));
                  } else if (widget.comments.length == 1) {
                    return Flexible(
                        child: Text(
                      '${widget.comments.length} comment',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Merriweather-Regular'),
                    ));
                  } else {
                    return Flexible(
                        child: Text(
                      '${widget.comments.length} comments',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Merriweather-Regular'),
                    ));
                  }
                }())
              ],
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
