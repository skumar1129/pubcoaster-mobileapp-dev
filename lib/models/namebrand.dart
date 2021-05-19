class NameBrand {
  final String brandName;
  final String type;
  final String uuid;
  final bool liked;

  NameBrand({
    required this.brandName,
    required this.type,
    required this.uuid,
    required this.liked,
  });

  factory NameBrand.fromJson(Map<String, dynamic> json) {
    return NameBrand(
      brandName: json['brandName'],
      type: json['type'],
      uuid: json['uuid'],
      liked: json['userLiked'],
    );
  }
}
