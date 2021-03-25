import 'package:flutter/material.dart';
import 'package:NewApp/widget/bottomnav.dart';
import 'package:NewApp/widget/navbarlocation.dart';
import 'package:NewApp/widget/filterDrawer.dart';
import 'package:NewApp/services/postservice.dart';
import 'package:NewApp/widget/feedpostcard.dart';

class LocUserPosts extends StatefulWidget {
  LocUserPosts(this.locuser);
  final String locuser;
  static const route = '/locuserposts';

  @override
  _LocUserPostsState createState() => _LocUserPostsState();
}

class _LocUserPostsState extends State<LocUserPosts> {
  String location = '';
  String user = '';
  Future<dynamic>? posts;
  final postService = new PostService();

  getLocUserPosts(String loc, String user, [int? offset]) async {
    var response;
    if (offset != null) {
      try {
        response = await postService.getLocUserPosts(location, user, offset);
      } catch (e) {
        print(e);
        final snackBar = SnackBar(
            content: Text(
                'Error: could retrieve posts. Check network connection.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 20)),
            backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      try {
        response = await postService.getLocUserPosts(location, user);
      } catch (e) {
        print(e);
        final snackBar = SnackBar(
            content: Text(
                'Error: could retrieve posts. Check network connection.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 20)),
            backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    return response;
  }

  @override
  void initState() {
    super.initState();
    location = widget.locuser.split('-')[0];
    user = widget.locuser.split('-')[1];
    posts = getLocUserPosts(location, user);
  }

  int offset = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: FilterDrawer(location),
      body: Column(
        children: [
          NavBarLoc(),
          FutureBuilder(
              future: posts,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var items = snapshot.data as List<dynamic>;
                  if (items.length == 0) {
                    return Expanded(
                        child: Text('No posts for $user in $location yet'));
                  } else {
                    return Expanded(
                        child: Column(
                      children: [
                        Text(
                          '$user in $location',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Oxygen-Bold'),
                        ),
                        Expanded(
                          child: Scrollbar(
                              child: RefreshIndicator(
                            child: ListView.builder(
                                physics: AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: items.length + 1,
                                itemBuilder: (context, index) {
                                  if (index == items.length) {
                                    offset++;
                                    var newPosts =
                                        getLocUserPosts(location, user, offset);
                                    newPosts.then((posts) {
                                      if (posts != null) {
                                        if (mounted) {
                                          setState(() {
                                            items.addAll(posts);
                                          });
                                        }
                                      }
                                    });
                                    return IntrinsicWidth(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return FeedPostCard(
                                      items[index].bar,
                                      items[index].location,
                                      items[index].createdBy,
                                      items[index].description,
                                      items[index].rating,
                                      items[index].createdAt,
                                      items[index].neighborhood,
                                      items[index].numComments,
                                      items[index].numLikes,
                                      items[index].anonymous,
                                      items[index].editedAt,
                                      items[index].picLink,
                                      items[index].uuid);
                                }),
                            onRefresh: () {
                              return getLocUserPosts(location, user);
                            },
                          )),
                        )
                      ],
                    ));
                  }
                } else if (snapshot.hasError) {
                  return Expanded(
                      child: Text(
                    'There was an error getting the posts',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ));
                }
                return Center(child: CircularProgressIndicator());
              })
        ],
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
