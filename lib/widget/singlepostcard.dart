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

  String newComment;

  @override
  Widget build(BuildContext context) {
    String goodContent = utf8.decode(widget.description.codeUnits);
    String goodBar = utf8.decode(widget.bar.codeUnits);
    String goodLocation = utf8.decode(widget.location.codeUnits);
    var newDate = HttpDate.parse(widget.timestamp);
    // TODO: Look into better way to get real time
    var date = newDate.add(Duration(hours: 5));
    return Container(
        height: MediaQuery.of(context).size.height * .6,
        child: Card(
        color: Colors.black,
        child: Column(
          children: [
            const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            // ListTile(
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      capitalize(goodBar),
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Merriweather-Bold', fontSize: 20),
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Text(
                    'User Rating: ${widget.rating}/10',
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Merriweather-Regular', fontSize: 15),
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            // ),
            const Divider(
              thickness: 1,
              color: Colors.white,
            ),
            (() {
              if (widget.picLink != '') {
                return Column(children: [
                  Image(image: NetworkImage('${widget.picLink}')),
                  const Divider(
                    thickness: 1,
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
                  color: Colors.white, fontFamily: 'Merriweather-Regular', fontSize: 25),
            ),
            const Divider(
              color: Colors.white,
              thickness: 1,
            ),
            Row(
              children: [
                (() {
                  if (widget.username != null) {
                    String goodUsername = utf8.decode(widget.username.codeUnits);
                    return Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Text(
                        '$goodUsername',
                        style: TextStyle(
                            fontSize: 18,
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
                    return Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: Text(
                      'No Likes Yet',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Merriweather-Regular'),
                    ));
                  } else if (widget.likes.length == 1) {
                    return Padding(
                      padding: EdgeInsets.only(right: 4),
                        child: Text(
                      '${widget.likes.length} like',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Merriweather-Regular'),
                    ));
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(right: 4),
                        child: Text(
                      '${widget.likes.length} likes',
                      style: TextStyle(
                          fontSize: 18,
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
              thickness: 1,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Text(
                    timeago.format(date.toLocal()),
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Merriweather-Italic', fontSize: 18),
                    softWrap: true,
                  ),
                ),
                (() {
                  if (widget.neighborhood != null) {
                    String goodNbhood = utf8.decode(widget.neighborhood.codeUnits);
                    return Padding(
                      padding: EdgeInsets.only(right: 4),
                        child: Text(
                      '${capitalize(goodNbhood)}, $goodLocation',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Merriweather-Regular', fontSize: 18),
                      softWrap: true,
                    ));
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(right: 4),
                        child: Text(
                      '$goodLocation',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
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
              thickness: 1,
            ),
            (() {
              if (widget.comments.length == 0) {
                return new Row(children:[ 
                  Center(
                    child: Text(
                    'No comments yet',
                    style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Merriweather-Regular'),
                ))]
                );
              } else {
                  return Expanded(
                    child: ListView.separated(
                    padding: EdgeInsets.all(1),
                    itemCount: widget.comments.length,
                    itemBuilder: (BuildContext context, int index) {
                      var newDate = HttpDate.parse(widget.comments[index]['createdAt']);
                      // TODO: Look into better way to get real time
                      var date = newDate.add(Duration(hours: 5));
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: Text(
                              "${widget.comments[index]['createdBy']} : ${widget.comments[index]['text']}",
                              style: TextStyle(
                                 color: Colors.white, fontFamily: 'Merriweather-Bold'),
                          ),
                         ),
                        Padding(
                          padding: EdgeInsets.only(right: 4),
                          child: Text(
                          "${timeago.format(date.toLocal())}",
                          style: TextStyle(
                          color: Colors.white, fontFamily: 'Merriweather-Regular'),
                        ))
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.blueGrey)
                    ));
              }
            }()),
            const Divider(
              color: Colors.white,
              thickness: 1,
            ),
            Row(
              children: [
                Expanded(child:
                  Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Comment',
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.all(8),
                      ),
                      onChanged: (String value) {
                        newComment = value;
                      }
                ),
                  )),
                Expanded(child:
                  Icon(
                    Icons.send,
                    color: Colors.grey,
                    size: 24.0,
                    semanticLabel: 'Send your comment',
                )),
              ],
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
            )
          ],
        ),
      ));
  }

 
}
