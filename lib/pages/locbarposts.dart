import 'package:flutter/material.dart';
import 'package:NewApp/widget/bottomnav.dart';
import 'package:NewApp/widget/navbarlocation.dart';
import 'package:NewApp/widget/filterDrawer.dart';
import 'package:NewApp/services/postservice.dart';
import 'package:NewApp/widget/feedpostcard.dart';
import 'package:strings/strings.dart';

class LocBarPosts extends StatefulWidget {
  LocBarPosts(this.locbar);
  final String locbar;
  static const route = '/locbarposts';

  @override
  _LocBarPostsState createState() => _LocBarPostsState();
}

class _LocBarPostsState extends State<LocBarPosts> {
  String location = '';
  String bar = '';
  Future<dynamic> posts = [] as Future;
  final postService = new PostService();

  getLocBarPosts(String loc, String bar, [int offset]) async {
    var response;
    if (offset != null) {
      try {
        response = await postService.getLocBarPosts(location, bar, offset);
      } catch (e) {
        print(e);
      }
    } else {
      try {
        response = await postService.getLocBarPosts(location, bar);
      } catch (e) {
        print(e);
      }
    }
    return response;
  }

  @override
  void initState() {
    super.initState();
    location = widget.locbar.split('-')[0];
    bar = widget.locbar.split('-')[1];
    posts = getLocBarPosts(location, bar);
  }

  int offset = 1;
  int itemsLength = 3;
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
                  var items = snapshot.data;
                  if (items.length == 0) {
                    return Expanded(
                        child: Text(
                            'No posts for ${capitalize(bar)} in $location yet'));
                  } else {
                    return Expanded(
                        child: Column(
                      children: [
                        Text(
                          '${capitalize(bar)} in $location',
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
                                  if (index == items.length &&
                                      items.length < itemsLength) {
                                    return Container();
                                  } else if (index == items.length &&
                                      items.length >= itemsLength) {
                                    offset++;
                                    itemsLength += 3;
                                    var newPosts =
                                        getLocBarPosts(location, bar, offset);
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
                              return getLocBarPosts(location, bar);
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
