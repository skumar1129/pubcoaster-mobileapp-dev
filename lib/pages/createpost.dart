import 'package:flutter/material.dart';
import 'package:NewApp/widget/bottomnav.dart';
import 'package:NewApp/widget/navbarhome.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:NewApp/services/postservice.dart';
import 'package:NewApp/pages/locationposts.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String location = '';
  String bar = '';
  String neighborhood = '';
  int rating = -1;
  String content = '';
  bool anonymous = false;
  String picLink = '';
  final postService = new PostService();

  // File _image = '' as File;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        print('nice!');
        // _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  submitPost(String loc, String bar, String nbhood, int rating, String descrip,
      bool anon) async {
    // TODO: change will local storage username
    var reqBody = {
      'username': 'helga',
      'anonymous': anon,
      'bar': bar,
      'description': descrip,
      'rating': rating,
      'location': loc,
      'nbhood': nbhood
    };
    bool succeed = await postService.addPost(reqBody);
    if (succeed) {
      Navigator.pushReplacementNamed(context, LocationPosts.route,
          arguments: location);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          NavBar(),
          Center(
            child: Text(
              'Create a New Post',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(
            color: Colors.white,
            thickness: 0.5,
          ),
          Row(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/post/user');
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.red)),
              ),
              RaisedButton(
                onPressed: () {
                  submitPost(
                      location, bar, neighborhood, rating, content, anonymous);
                },
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.red)),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
          const Divider(
            color: Colors.white,
            thickness: 0.5,
          ),
          Form(
              child: Expanded(
                  child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                DropdownButtonFormField(
                  items: [
                    'Columbus',
                    'Chicago',
                    'New York',
                    'Denver',
                    'Washington DC',
                    'San Francisco',
                    'Orlando',
                    'Phoenix',
                    'Boston',
                    'Los Angeles'
                  ]
                      .map((String value) => DropdownMenuItem<String>(
                            child: Text(value),
                            value: value,
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    if (mounted) {
                      setState(() {
                        location = value!;
                      });
                    }
                  },
                  hint: Text('Location*'),
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 0.75,
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Bar*'),
                  onChanged: (value) => {
                    if (mounted)
                      {
                        setState(() => {bar = value})
                      }
                  },
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 0.5,
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Neighborhood'),
                  onChanged: (value) => {
                    if (mounted)
                      {
                        setState(() => {neighborhood = value})
                      }
                  },
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 0.5,
                ),
                DropdownButtonFormField(
                  items: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
                      .map((String value) => DropdownMenuItem<String>(
                            child: Text(value),
                            value: value,
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    if (mounted) {
                      setState(() {
                        rating = int.parse(value!);
                      });
                    }
                  },
                  hint: Text('Rating*'),
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 0.75,
                ),
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'What\'s good?*'),
                  onChanged: (value) => {
                    if (mounted)
                      {
                        setState(() => {content = value})
                      }
                  },
                ),
                CheckboxListTile(
                    value: anonymous,
                    title: Text('Make post anonymous?'),
                    onChanged: (bool? value) {
                      if (mounted) {
                        setState(() {
                          anonymous = value!;
                        });
                      }
                    },
                    secondary: Icon(Icons.security)),
                FloatingActionButton(
                  onPressed: getImage,
                  tooltip: 'Picture (Optional)',
                  child: Icon(Icons.add_a_photo),
                  backgroundColor: Colors.red,
                ),
              ],
            ),
          ))),
        ],
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
