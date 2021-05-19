class NameDrink {
  final String drink;
  final String uuid;
  final bool liked;

  NameDrink({
    required this.drink,
    required this.uuid,
    required this.liked,
  });

  factory NameDrink.fromJson(Map<String, dynamic> json) {
    return NameDrink(
      drink: json['drinkName'],
      uuid: json['uuid'],
      liked: json['userLiked'],
    );
  }
}
