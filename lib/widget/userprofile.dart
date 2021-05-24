import 'package:flutter/material.dart';
import 'package:NewApp/models/userlikedargs.dart';
import 'package:NewApp/pages/userlikedtype.dart';

class UserProfile extends StatefulWidget {
  UserProfile(this.userInfo, this.numPosts);
  final userInfo;
  final numPosts;
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Widget _postDialog() {
    return AlertDialog(
      title: Text(
        'Just look down the screen bro',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 23,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _avatar() {
    if (widget.userInfo.picLink != null) {
      return CircleAvatar(
        backgroundImage: NetworkImage(widget.userInfo.picLink),
        radius: MediaQuery.of(context).size.width * .2,
      );
    } else {
      return CircleAvatar(
        radius: MediaQuery.of(context).size.width * .2,
        child: Icon(Icons.no_photography),
        backgroundColor: Colors.red,
      );
    }
  }

  Widget _barsLiked() {
    if (widget.userInfo.numBars == 1) {
      return Column(
        children: [
          IconButton(
              icon: Icon(
                Icons.business,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, UserLikedType.route,
                    arguments:
                        UserLiked(type: 'bar', user: widget.userInfo.username));
              }),
          Text('${widget.userInfo.numBars} bar liked')
        ],
      );
    } else {
      return Column(
        children: [
          IconButton(
              icon: Icon(
                Icons.business,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, UserLikedType.route,
                    arguments:
                        UserLiked(type: 'bar', user: widget.userInfo.username));
              }),
          Text('${widget.userInfo.numBars} bars liked')
        ],
      );
    }
  }

  Widget _brandsLiked() {
    if (widget.userInfo.numBrands == 1) {
      return Column(
        children: [
          IconButton(
              icon: Icon(
                Icons.branding_watermark,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, UserLikedType.route,
                    arguments: UserLiked(
                        type: 'brand', user: widget.userInfo.username));
              }),
          Text('${widget.userInfo.numBrands} brand liked'),
        ],
      );
    } else {
      return Column(
        children: [
          IconButton(
              icon: Icon(
                Icons.branding_watermark,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, UserLikedType.route,
                    arguments: UserLiked(
                        type: 'brand', user: widget.userInfo.username));
              }),
          Text('${widget.userInfo.numBrands} brands liked'),
        ],
      );
    }
  }

  Widget _drinksLiked() {
    if (widget.userInfo.numDrinks == 1) {
      return Column(
        children: [
          IconButton(
              icon: Icon(
                Icons.local_drink,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, UserLikedType.route,
                    arguments: UserLiked(
                        type: 'drink', user: widget.userInfo.username));
              }),
          Text('${widget.userInfo.numDrinks} drink liked')
        ],
      );
    } else {
      return Column(
        children: [
          IconButton(
              icon: Icon(
                Icons.local_drink,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, UserLikedType.route,
                    arguments: UserLiked(
                        type: 'drink', user: widget.userInfo.username));
              }),
          Text('${widget.userInfo.numDrinks} drinks liked')
        ],
      );
    }
  }

  Widget _infoOnUser() {
    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_postsCreated(), VerticalDivider(), _barsLiked()],
          ),
        ),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_brandsLiked(), VerticalDivider(), _drinksLiked()],
        ))
      ],
    );
  }

  Widget _userFullName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${widget.userInfo.fullName}',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Merriweather-Bold',
              fontSize: 20),
        ),
      ],
    );
  }

  Widget _userBio() {
    if (widget.userInfo.bio != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${widget.userInfo.bio}',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Merriweather-Bold',
                fontSize: 20),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No bio yet',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Merriweather-Bold',
                fontSize: 20),
          ),
        ],
      );
    }
  }

  Widget _postsCreated() {
    if (widget.numPosts == 1) {
      return Column(
        children: [
          IconButton(
              icon: Icon(
                Icons.my_library_books,
                color: Colors.red,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext content) {
                      return _postDialog();
                    });
              }),
          Text('${widget.numPosts} post created'),
        ],
      );
    } else {
      return Column(
        children: [
          IconButton(
              icon: Icon(
                Icons.my_library_books,
                color: Colors.red,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext content) {
                      return _postDialog();
                    });
              }),
          Text('${widget.numPosts} posts created'),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _avatar(),
            _infoOnUser(),
          ],
        ),
        Divider(
          color: Colors.black,
          thickness: 2,
        ),
        _userFullName(),
        Divider(
          color: Colors.black,
          thickness: 2,
        ),
        _userBio(),
        Divider(
          color: Colors.black,
          thickness: 2,
        )
      ],
    );
  }
}
