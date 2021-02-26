import 'dart:io';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:strings/strings.dart';
import 'dart:convert';
import 'package:NewApp/pages/singlepost.dart';

class MyPostCard extends StatefulWidget {
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

  MyPostCard(
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
  _MyPostCardState createState() => _MyPostCardState();
}

class _MyPostCardState extends State<MyPostCard> {
  bool editMode = false;

  goToEditMode() {
    setState(() {
      editMode = true;
    });
  }

  cancelEdit() {
    setState(() {
      editMode = false;
    });
  }

  deletePost() {}

  @override
  Widget build(BuildContext context) {
    String goodContent = utf8.decode(widget.content.codeUnits);
    String goodBar = utf8.decode(widget.bar.codeUnits);
    String goodLocation = utf8.decode(widget.location.codeUnits);
    var newDate = HttpDate.parse(widget.timestamp);
    // TODO: Look into better way to get real time
    var date = newDate.add(Duration(hours: 5));
    if (!editMode) {
      return GestureDetector(
        child: Card(
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
                  RaisedButton(
                    onPressed: () {
                      goToEditMode();
                    },
                    child: Text(
                      'Edit Post',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                  ),
                  Flexible(
                      child: Text(
                    'User Rating: ${widget.rating}/10',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Merriweather-Regular'),
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
                      String goodUsername =
                          utf8.decode(widget.username.codeUnits);
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
                    if (widget.numLikes == 0) {
                      return Flexible(
                          child: Text(
                        'No Likes Yet',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Merriweather-Regular'),
                      ));
                    } else if (widget.numLikes == 1) {
                      return Flexible(
                          child: Text(
                        '${widget.numLikes} like',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Merriweather-Regular'),
                      ));
                    } else {
                      return Flexible(
                          child: Text(
                        '${widget.numLikes} likes',
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
                          color: Colors.white,
                          fontFamily: 'Merriweather-Italic'),
                      softWrap: true,
                    ),
                  ),
                  (() {
                    if (widget.editedAt != null) {
                      String goodNbhood =
                          utf8.decode(widget.neighborhood.codeUnits);
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
                    if (widget.numComments == 0) {
                      return Flexible(
                          child: Text(
                        'No comments yet',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Merriweather-Regular'),
                      ));
                    } else if (widget.numComments == 1) {
                      return Flexible(
                          child: Text(
                        '${widget.numComments} comment',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Merriweather-Regular'),
                      ));
                    } else {
                      return Flexible(
                          child: Text(
                        '${widget.numComments} comments',
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
        ),
        onTap: () {
          Navigator.pushReplacementNamed(context, SinglePost.route,
              arguments: widget.uuid);
        },
      );
    } else {
      return Card(
        color: Colors.black,
        child: Column(
          children: [
            // ListTile(
            Row(
              children: [
                Flexible(
                    child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: capitalize(goodBar),
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Merriweather-Bold')))),
                RaisedButton(
                  onPressed: () {
                    cancelEdit();
                  },
                  child: Text(
                    'Cancel Edit',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)),
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
                    String goodUsername =
                        utf8.decode(widget.username.codeUnits);
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
                  if (widget.numLikes == 0) {
                    return Flexible(
                        child: Text(
                      'No Likes Yet',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Merriweather-Regular'),
                    ));
                  } else if (widget.numLikes == 1) {
                    return Flexible(
                        child: Text(
                      '${widget.numLikes} like',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Merriweather-Regular'),
                    ));
                  } else {
                    return Flexible(
                        child: Text(
                      '${widget.numLikes} likes',
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
                  if (widget.editedAt != null) {
                    String goodNbhood =
                        utf8.decode(widget.neighborhood.codeUnits);
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
                  if (widget.numComments == 0) {
                    return Flexible(
                        child: Text(
                      'No comments yet',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Merriweather-Regular'),
                    ));
                  } else if (widget.numComments == 1) {
                    return Flexible(
                        child: Text(
                      '${widget.numComments} comment',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Merriweather-Regular'),
                    ));
                  } else {
                    return Flexible(
                        child: Text(
                      '${widget.numComments} comments',
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
}
