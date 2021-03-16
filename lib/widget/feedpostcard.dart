import 'dart:io';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:strings/strings.dart';
import 'dart:convert';
import 'package:NewApp/pages/singlepost.dart';
import 'package:NewApp/models/postargs.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedPostCard extends StatelessWidget {
  final String bar;
  final String location;
  final String? username;
  final String content;
  final int rating;
  final String timestamp;
  final String? neighborhood;
  final int numComments;
  final int numLikes;
  final bool? anonymous;
  final String? editedAt;
  final String? picLink;
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

  goToSinglePost(context) async {
    String user = FirebaseAuth.instance.currentUser!.displayName!;
    Navigator.pushReplacementNamed(
      context,
      SinglePost.route,
      arguments: PostArgs(uuid: uuid, currentUser: user),
    );
  }

  Widget user(username) {
     if (username != null) {
      String goodUsername = utf8.decode(username!.codeUnits);
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

  Widget likes(numLikes) {
    if (numLikes == 0) {
      return Flexible(
          child: Text(
        'No Likes Yet',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Merriweather-Regular'),
      ));
    } else if (numLikes == 1) {
      return Flexible(
          child: Text(
        '$numLikes like',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Merriweather-Regular'),
      ));
    } else {
      return Flexible(
          child: Text(
        '$numLikes likes',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Merriweather-Regular'),
      ));
    }
  }

  Widget picture(picLink) {
     if (picLink != '') {
      return Column(children: [
        Image(image: NetworkImage('$picLink')),
        const Divider(
          color: Colors.white,
        )
      ]);
    } else {
      return Container();
    }
  }

  Widget nbhood(neighborhood, goodLocation) {
    if (neighborhood != null) {
      String goodNbhood = utf8.decode(neighborhood!.codeUnits);
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

  Widget comments(numComments) {
    if (numComments == 0) {
      return Flexible(
          child: Text(
        'No comments yet',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Merriweather-Regular'),
      ));
    } else if (numComments == 1) {
      return Flexible(
          child: Text(
        '$numComments comment',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Merriweather-Regular'),
      ));
    } else {
      return Flexible(
          child: Text(
        '$numComments comments',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Merriweather-Regular'),
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    String goodContent = utf8.decode(content.codeUnits);
    String goodBar = utf8.decode(bar.codeUnits);
    String goodLocation = utf8.decode(location.codeUnits);
    var newDate = HttpDate.parse(timestamp);
    // TODO: Look into better way to get real time
    var date = newDate.add(Duration(hours: 5));
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
                Flexible(
                    child: Text(
                  'User Rating: $rating/10',
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
            picture(picLink),
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
                user(username),
                likes(numLikes)
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
                nbhood(neighborhood, goodLocation)
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            const Divider(
              color: Colors.white,
            ),
            Row(
              children: [
                comments(numComments)
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
        goToSinglePost(context);
      },
    );
  }
}
