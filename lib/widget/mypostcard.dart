import 'dart:io';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:strings/strings.dart';
import 'dart:convert';
import 'package:NewApp/pages/singlepost.dart';
import 'package:NewApp/services/postservice.dart';
import 'package:NewApp/models/postargs.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyPostCard extends StatefulWidget {
  final String bar;
  final String location;
  final String? username;
  final String content;
  final int rating;
  final String timestamp;
  final String? neighborhood;
  final int numComments;
  final int numLikes;
  final bool anonymous;
  final String? editedAt;
  final String? picLink;
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
  final postService = new PostService();
  bool editMode = false;
  String? newBar;
  String? newContent;
  String? newNbhood;
  int? newRating;

  goToEditMode() {
    if (mounted) {
      setState(() {
        editMode = true;
      });
    }
  }

  cancelEdit() {
    if (mounted) {
      setState(() {
        newBar = null;
        dropdownValue = null;
        newContent = null;
        newNbhood = null;
        newRating = null;
        editMode = false;
      });
    }
  }

  editPost() async {
    bool succeed;
    var item = {
      'nbhood': newNbhood,
      'rating': newRating,
      'bar': newBar,
      'description': newContent
    };
    succeed = await postService.updatePost(widget.uuid, item);
    if (succeed) {
      Navigator.pushReplacementNamed(context, '/mypost');
    }
  }

  deletePost() async {
    bool succeed;
    succeed = await postService.deletePost(widget.uuid);
    if (succeed) {
      Navigator.pushReplacementNamed(context, '/mypost');
    }
  }

  goToSinglePost() async {
    String user = FirebaseAuth.instance.currentUser!.displayName!;
    Navigator.pushReplacementNamed(
      context,
      SinglePost.route,
      arguments: PostArgs(uuid: widget.uuid, currentUser: user),
    );
  }

  Widget picture() {
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
  }

  Widget user() {
     if (widget.username != null) {
        String goodUsername =
            utf8.decode(widget.username!.codeUnits);
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
  }

  Widget likes() {
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
  }

  Widget neighborhood(goodLocation) {
    if (widget.neighborhood != null) {
      String goodNbhood =
          utf8.decode(widget.neighborhood!.codeUnits);
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
  }

  Widget comments() {
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
  }



  String? dropdownValue;
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
                  IconButton(
                    onPressed: () {
                      goToEditMode();
                    },
                    tooltip: 'Edit Post',
                    icon: Icon(Icons.edit),
                    color: Colors.red,
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
              picture(),
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
                  user(),
                  likes()
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
                  neighborhood(goodLocation)
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              const Divider(
                color: Colors.white,
              ),
              Row(
                children: [
                 comments()
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
          goToSinglePost();
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
                      labelText: 'Name of bar',
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Merriweather-Bold')),
                  onChanged: (String value) {
                    newBar = value;
                  },
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Merriweather-Bold'),
                )),
                IconButton(
                  onPressed: () {
                    cancelEdit();
                  },
                  icon: Icon(Icons.cancel),
                  tooltip: 'Cancel Edit',
                  color: Colors.red,
                ),
                Text('Rating: ',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Merriweather-Regular',
                    )),
                Flexible(
                  child: DropdownButton(
                    value: dropdownValue == null
                        ? widget.rating.toString()
                        : dropdownValue,
                    dropdownColor: Colors.black,
                    items: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
                        .map((String value) {
                      return DropdownMenuItem(
                          child: Text(
                            value,
                            style: TextStyle(
                                fontFamily: 'Merriweather-Regular',
                                color: Colors.white),
                          ),
                          value: value);
                    }).toList(),
                    onChanged: (String? value) {
                      if (mounted) {
                        setState(() {
                          dropdownValue = value;
                          newRating = int.parse(value!);
                        });
                      }
                    },
                  ),
                ),
                Text('/10',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Merriweather-Regular',
                    ))
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            // ),
            const Divider(
              color: Colors.white,
            ),
            picture(),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                      color: Colors.white, fontFamily: 'Merriweather-Bold'),
                  labelText: 'Post description'),
              onChanged: (String value) {
                newContent = value;
              },
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Merriweather-Bold'),
            ),
            const Divider(
              color: Colors.white,
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    deletePost();
                  },
                  color: Colors.red,
                  tooltip: 'Delete Post',
                ),
                IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    editPost();
                  },
                  color: Colors.red,
                  tooltip: 'Edit Post',
                ),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Merriweather-Bold'),
                        labelText: 'Neighborhood'),
                    onChanged: (String value) {
                      newNbhood = value;
                    },
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Merriweather-Bold'),
                  ),
                ),
                Text(
                  ', $goodLocation',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Merriweather-Bold'),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            const Divider(
              color: Colors.white,
            ),
          ],
        ),
      );
    }
  }
}
