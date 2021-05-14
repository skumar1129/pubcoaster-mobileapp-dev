class Drinks {
  final String drink;
  final String uuid;

  Drinks({required this.drink, required this.uuid});

  factory Drinks.fromJson(Map<String, dynamic> json) {
    return Drinks(drink: json['name'], uuid: json['uuid']);
  }
}
