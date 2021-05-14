import 'package:flutter/material.dart';
import 'package:NewApp/widget/navbarhome.dart';
import 'package:NewApp/widget/bottomnav.dart';

class CreateUserLiked extends StatefulWidget {
  CreateUserLiked(this.type, this.user);
  final String type;
  final String user;
  static const route = '/createuserliked';
  @override
  _CreateUserLikedState createState() => _CreateUserLikedState();
}

class _CreateUserLikedState extends State<CreateUserLiked> {
  Widget _createDrink() {
    return Form(
      child: SingleChildScrollView(),
    );
  }

  Widget _createBrand() {
    return Form(
      child: SingleChildScrollView(),
    );
  }

  Widget _createBar() {
    return Form(
      child: SingleChildScrollView(),
    );
  }

  Widget _createDisplay() {
    switch (widget.type) {
      case 'bar':
        return _createBar();
      case 'drink':
        return _createDrink();
      case 'brand':
        return _createBrand();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          NavBar(),
          _createDisplay(),
        ],
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
