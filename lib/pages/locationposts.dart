import 'package:flutter/material.dart';
import 'package:NewApp/services/postservice.dart';
import 'package:NewApp/widget/filterDrawer.dart';
import 'package:NewApp/widget/navbarlocation.dart';
import 'package:NewApp/widget/bottomnav.dart';

class LocationPosts extends StatefulWidget {
  LocationPosts(this.location);
  final String location;
  static const route = '/locationposts';

  @override
  _LocationPostsState createState() => _LocationPostsState();
}

class _LocationPostsState extends State<LocationPosts> {
  Future<dynamic> posts;
  final postService = new PostService();
  getLocationPosts(String location, [int offset]) async {
    var response;
    if (offset != null) {
      try {
        response = await postService.getLocationPosts(location, offset);
      } catch (e) {
        print(e);
      }
    } else {
      try {
        response = await postService.getLocationPosts(location);
      } catch (e) {
        print(e);
      }
    }
    print(response);
    return response;
  }

  @override
  void initState() {
    super.initState();
    posts = getLocationPosts(widget.location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: FilterDrawer(widget.location),
      body: Column(
        children: [Expanded(child: NavBarLoc())],
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
