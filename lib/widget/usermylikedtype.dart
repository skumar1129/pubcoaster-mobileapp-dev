import 'package:flutter/material.dart';
import 'package:NewApp/services/userservice.dart';

class UserMyLikedType extends StatelessWidget {
  UserMyLikedType(this.type, this.info);
  final String type;
  final dynamic info;
  final userService = new UserService();

  Widget _drinkInfo() {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.remove_sharp,
          ),
          onPressed: () {},
        ),
        Icon(
          Icons.local_drink,
        )
      ],
    );
  }

  Widget _barInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: Icon(
            Icons.remove_sharp,
          ),
          onPressed: () {},
        ),
        Icon(
          Icons.business,
        )
      ],
    );
  }

  Widget _brandInfo() {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.remove_sharp,
          ),
          onPressed: () {},
        ),
        Icon(
          Icons.branding_watermark,
        )
      ],
    );
  }

  Widget _typeInfo() {
    switch (type) {
      case 'bar':
        return _barInfo();
      case 'drink':
        return _drinkInfo();
      case 'brand':
        return _brandInfo();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: _typeInfo(),
    );
  }
}
