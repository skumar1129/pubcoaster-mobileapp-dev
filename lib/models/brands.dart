class Brands {
  final String brandName;
  final String type;
  final String uuid;
  bool liked;
  Brands({
    required this.brandName,
    required this.type,
    required this.uuid,
    required this.liked,
  });

  factory Brands.fromJson(Map<String, dynamic> json) {
    return Brands(
      brandName: json['brandName'],
      type: json['type'],
      uuid: json['uuid'],
      liked: json['userLiked'],
    );
  }
}
