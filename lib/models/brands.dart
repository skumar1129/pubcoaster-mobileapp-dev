class Brands {
  final String brand;
  final String type;
  final String uuid;
  Brands({required this.brand, required this.type, required this.uuid});

  factory Brands.fromJson(Map<String, dynamic> json) {
    return Brands(brand: json['brand'], type: json['type'], uuid: json['uuid']);
  }
}
