class NameDrink {
  final String drink;
  final String uuid;

  NameDrink({required this.drink, required this.uuid});

  factory NameDrink.fromJson(Map<String, dynamic> json) {
    return NameDrink(drink: json['name'], uuid: json['uuid']);
  }
}
