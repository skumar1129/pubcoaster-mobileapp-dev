import 'package:flutter/material.dart';
import 'package:NewApp/services/followerservice.dart';

class FollowCard extends StatefulWidget {
  FollowCard(this.info, this.user);
  final dynamic info;
  final String user;
  @override
  _FollowCardState createState() => _FollowCardState();
}

class _FollowCardState extends State<FollowCard> {
  final followService = new FollowerService();
  bool? follow;

  deletefollow() async {
    try {
      bool succeed =
          await followService.deleteFollowing(widget.user, widget.info.user);
      if (succeed) {
        if (mounted) {
          setState(() {
            follow = false;
          });
        }
      } else {
        final snackBar = SnackBar(
            content: Text(
              'Error with unfollowing. Check network connection.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20),
            ),
            backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print(e);
    }
  }

  createFollow() async {
    try {
      bool succeed =
          await followService.createFollowing(widget.user, widget.info.user);
      if (succeed) {
        if (mounted) {
          setState(() {
            follow = true;
          });
        }
      } else {
        final snackBar = SnackBar(
            content: Text(
                'Error with following user. Check network connection and make sure you are not following yourself.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 20)),
            backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print(e);
    }
  }

  Widget _avatar() {
    if (widget.info.picLink == '') {
      return CircleAvatar(
        radius: MediaQuery.of(context).size.width * .05,
        child: Icon(Icons.no_photography),
        backgroundColor: Colors.red,
      );
    } else {
      return CircleAvatar(
        backgroundImage: NetworkImage(widget.info.picLink),
        radius: MediaQuery.of(context).size.width * .05,
      );
    }
  }

  Widget _userInfo() {
    return Column(
      children: [
        Text('${widget.info.user}, ${widget.info.fullName}'),
        widget.info.bio == '' ? Container() : Text('${widget.info.bio}')
      ],
    );
  }

  Widget _followingerButton() {
    if (follow == null) {
      return ElevatedButton(
        onPressed: () {
          deletefollow();
        },
        child: Text('Unfollow'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.red),
            ),
          ),
        ),
      );
    } else if (follow!) {
      return ElevatedButton(
        onPressed: () {
          deletefollow();
        },
        child: Text('Unfollow'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.red),
            ),
          ),
        ),
      );
    } else if (widget.user == widget.info.user) {
      return ElevatedButton(
        onPressed: null,
        child: Text(''),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.white),
            ),
          ),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          createFollow();
        },
        child: Text('Follow'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.red),
            ),
          ),
        ),
      );
    }
  }

  Widget _cardLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _avatar(),
        _userInfo(),
        _followingerButton(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    follow = widget.info.following;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      shape: StadiumBorder(
        side: BorderSide(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: _cardLayout(),
    );
  }
}
