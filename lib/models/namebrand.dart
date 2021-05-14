class NameBrand {
  final String brand;
  final String type;
  final String uuid;

  NameBrand({required this.brand, required this.type, required this.uuid});

  factory NameBrand.fromJson(Map<String, dynamic> json) {
    return NameBrand(
        brand: json['brand'], type: json['type'], uuid: json['uuid']);
  }
}
