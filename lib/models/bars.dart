class Bars {
  final String barName;
  final String? type;
  final String? address;
  final String neighborhood;
  final String uuid;
  final String location;
  bool liked;

  Bars({
    required this.barName,
    this.type,
    this.address,
    required this.neighborhood,
    required this.uuid,
    required this.location,
    required this.liked,
  });

  factory Bars.fromJson(Map<String, dynamic> json) {
    return Bars(
      barName: json['barName'],
      type: json['type'],
      address: json['address'],
      neighborhood: json['neighborhood'],
      uuid: json['uuid'],
      location: json['location'],
      liked: json['userLiked'],
    );
  }
}
