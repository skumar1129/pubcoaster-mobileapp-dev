class UserDrink {
  final String drinkName;
  final String uuid;
  final String user;

  UserDrink({required this.drinkName, required this.user, required this.uuid});

  factory UserDrink.fromJson(Map<String, dynamic> json) {
    return UserDrink(
        drinkName: json['drinkName'], user: json['user'], uuid: json['uuid']);
  }
}
