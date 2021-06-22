import 'package:flutter/material.dart';
import 'package:NewApp/services/postservice.dart';
import 'package:NewApp/widget/filterDrawer.dart';
import 'package:NewApp/widget/navbarlocation.dart';
import 'package:NewApp/widget/bottomnav.dart';
import 'package:NewApp/widget/feedpostcard.dart';

class LocationPosts extends StatefulWidget {
  LocationPosts(this.location);
  final String location;
  static const route = '/locationposts';

  @override
  _LocationPostsState createState() => _LocationPostsState();
}

class _LocationPostsState extends State<LocationPosts> {
  Future<dynamic>? posts;
  final postService = new PostService();
  getLocationPosts(String location, [int? offset]) async {
    var response;
    if (offset != null) {
      try {
        response = await postService.getLocationPosts(location, offset);
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
        response = await postService.getLocationPosts(location);
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
    posts = getLocationPosts(widget.location);
  }

  int offset = 1;
  int itemsLength = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: FilterDrawer(widget.location),
      body: Column(
        children: [
          NavBarLoc(),
          FutureBuilder(
              future: posts,
              builder: (context, snapshot) {
                print(snapshot.data);
                print(snapshot.error);
                if (snapshot.hasData) {
                  var items = snapshot.data as List<dynamic>;
                  if (items.length == 0) {
                    return Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .1),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text('No posts for ${widget.location} yet',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    decoration: TextDecoration.underline)),
                          ),
                          Expanded(
                              child: Image(
                                  image: AssetImage('assets/img/city_page.jpg'),
                                  height:
                                      MediaQuery.of(context).size.height * .4)),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .14)
                        ],
                      ),
                    );
                  } else {
                    return Expanded(
                        child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            '${widget.location}',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                fontFamily: 'Oxygen-Bold'),
                          ),
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
                                    var newPosts = getLocationPosts(
                                        widget.location, offset);
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
                              return getLocationPosts(widget.location);
                            },
                          )),
                        )
                      ],
                    ));
                  }
                } else if (snapshot.hasError) {
                  return Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .1),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text('There was an error getting the posts',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  decoration: TextDecoration.underline)),
                        ),
                        Expanded(
                            child: Image(
                                image: AssetImage('assets/img/city_page.jpg'),
                                height:
                                    MediaQuery.of(context).size.height * .4)),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .14)
                      ],
                    ),
                  );
                } else if (snapshot.data == null && snapshot.error == null) {
                  return Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .1),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                              'The database does not seem to be turned on, try again when it is',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  decoration: TextDecoration.underline)),
                        ),
                        Expanded(
                            child: Image(
                                image: AssetImage('assets/img/city_page.jpg'),
                                height:
                                    MediaQuery.of(context).size.height * .4)),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .14)
                      ],
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              })
        ],
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
