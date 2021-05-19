class Drinks {
  final String drinkName;
  final String uuid;
  bool liked;

  Drinks({
    required this.drinkName,
    required this.uuid,
    required this.liked,
  });

  factory Drinks.fromJson(Map<String, dynamic> json) {
    return Drinks(
      drinkName: json['drinkName'],
      uuid: json['uuid'],
      liked: json['userLiked'],
    );
  }
}
