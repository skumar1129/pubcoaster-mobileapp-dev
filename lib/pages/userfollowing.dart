import 'package:flutter/material.dart';
import 'package:NewApp/widget/navbarfollow.dart';
import 'package:NewApp/services/followerservice.dart';
import 'package:NewApp/widget/followcard.dart';

class UserFollowing extends StatefulWidget {
  UserFollowing(this.user, this.myUser);
  final String user;
  final String myUser;
  static const route = '/userfollowing';
  @override
  _UserFollowingState createState() => _UserFollowingState();
}

class _UserFollowingState extends State<UserFollowing> {
  final followerService = new FollowerService();
  Future<dynamic>? followInfo;
  int offset = 1;
  int itemsLength = 7;

  getFollowInfo([int? page]) async {
    if (page != null) {
      var response;
      try {
        response =
            await followerService.getUserFollowing(widget.user, widget.myUser);
        return response;
      } catch (e) {
        print(e);
        final snackBar = SnackBar(
            content: Text('Error getting following info',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 20)),
            backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      var response;
      try {
        response = await followerService.getUserFollowing(
            widget.user, widget.myUser, page);
        return response;
      } catch (e) {
        print(e);
        final snackBar = SnackBar(
            content: Text('Error getting following info',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 20)),
            backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  Widget _noFollowing() {
    return Expanded(
      child: Column(
        children: [
          Text(
            '${widget.user} is not following anyone yet',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                decoration: TextDecoration.underline),
          ),
          Expanded(
              child: Image(
                  image: AssetImage('assets/img/city_page.jpg'),
                  height: MediaQuery.of(context).size.height * .4)),
        ],
      ),
    );
  }

  Widget _following(items) {
    return Expanded(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            '${widget.user} is following',
            style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                fontFamily: 'Oxygen-Bold'),
          ),
        ),
        Scrollbar(
          child: RefreshIndicator(
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: items.length + 1,
              itemBuilder: (context, index) {
                if (index == items.length && items.length < itemsLength) {
                  return Container();
                } else if (index == items.length &&
                    items.length >= itemsLength) {
                  offset++;
                  itemsLength += 7;
                  var newInfo = getFollowInfo(offset);
                  newInfo.then((info) {
                    if (info != null) {
                      if (mounted) {
                        setState(() {
                          items.addAll(info);
                        });
                      }
                    }
                  });
                  return IntrinsicWidth(
                    child: CircularProgressIndicator(),
                  );
                }
                return FollowCard(items[index], widget.myUser);
              },
            ),
            onRefresh: () {
              return getFollowInfo();
            },
          ),
        ),
      ],
    ));
  }

  Widget _error() {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .1),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
                'There was an error getting the people ${widget.user} is following',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    decoration: TextDecoration.underline)),
          ),
          Expanded(
              child: Image(
                  image: AssetImage('assets/img/city_page.jpg'),
                  height: MediaQuery.of(context).size.height * .4)),
          SizedBox(height: MediaQuery.of(context).size.height * .14)
        ],
      ),
    );
  }

  Widget _pageLayout() {
    return FutureBuilder(
      future: followInfo,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var items = snapshot.data as List<dynamic>;
          if (items.length == 0) {
            return _noFollowing();
          } else {
            return _following(items);
          }
        } else if (snapshot.hasError) {
          return _error();
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  void initState() {
    super.initState();
    followInfo = getFollowInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NavBarFollow('/userposts', widget.user, widget.myUser),
          _pageLayout(),
        ],
      ),
    );
  }
}
