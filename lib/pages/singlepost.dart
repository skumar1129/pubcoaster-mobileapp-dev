import 'package:flutter/material.dart';
import 'package:NewApp/services/postservice.dart';
import 'package:NewApp/widget/navbarhome.dart';
import 'package:NewApp/widget/singlepostcard.dart';
import 'package:NewApp/widget/bottomnav.dart';

class SinglePost extends StatefulWidget {
  SinglePost(this.uuid, this.currentUser);
  final String uuid;
  final String currentUser;
  static const route = '/singlepost';

  @override
  _SinglePostState createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  Future<dynamic> post;
  final postService = new PostService();
  getSinglePost(String uuid) async {
    var response;
    try {
      response = await postService.getPost(uuid);
    } catch (e) {
      print(e);
    }
    return response;
  }

  @override
  void initState() {
    super.initState();
    post = getSinglePost(widget.uuid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NavBar(),
          FutureBuilder(
              future: post,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var item = snapshot.data;
                  return SinglePostCard(
                      item.bar,
                      item.location,
                      item.createdBy,
                      item.rating,
                      item.createdAt,
                      item.neighborhood,
                      item.editedAt,
                      item.picLink,
                      item.uuid,
                      item.description,
                      item.anonymous,
                      item.comments,
                      item.likes,
                      widget.currentUser
                  );
                } else if (snapshot.hasError) {
                  return Expanded(
                      child: Text(
                    'There was an error getting the post',
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
