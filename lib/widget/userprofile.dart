import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  UserProfile(this.userInfo, this.numPosts);
  final userInfo;
  final numPosts;
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Widget _avatar() {
    if (widget.userInfo.picLink != null) {
      return CircleAvatar(
        backgroundImage: NetworkImage(widget.userInfo.picLink),
      );
    } else {
      return CircleAvatar(
          backgroundColor: Colors.grey,
          radius: MediaQuery.of(context).size.width * .15);
    }
  }

  Widget _infoOnUser() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          child: Text('Delete Account'),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)))),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Icon(
                    Icons.my_library_books,
                    color: Colors.red,
                  ),
                  Text('${widget.numPosts} posts created'),
                ],
              ),
              VerticalDivider(),
              Column(
                children: [
                  Icon(
                    Icons.business,
                    color: Colors.red,
                  ),
                  Text('${widget.userInfo.numBars} bars liked')
                ],
              ),
            ],
          ),
        ),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Icon(
                  Icons.branding_watermark,
                  color: Colors.red,
                ),
                Text('${widget.userInfo.numBrands} brands liked'),
              ],
            ),
            VerticalDivider(),
            Column(
              children: [
                Icon(
                  Icons.local_drink,
                  color: Colors.red,
                ),
                Text('${widget.userInfo.numDrinks} drinks liked')
              ],
            )
          ],
        ))
      ],
    );
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${widget.userInfo.fullName}'),
            IconButton(
                icon: Icon(Icons.edit), onPressed: () {}, color: Colors.red),
          ],
        ),
        Divider(
          color: Colors.black,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${widget.userInfo.bio}'),
            IconButton(
                icon: Icon(Icons.edit), onPressed: () {}, color: Colors.red),
          ],
        ),
        Divider(
          color: Colors.black,
        )
      ],
    );
  }
}
