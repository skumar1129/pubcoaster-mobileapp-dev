class NameBar {
  final String barName;
  final String type;
  final String address;
  final String neighborhood;
  final String uuid;
  final String location;
  final bool liked;

  NameBar({
    required this.barName,
    required this.type,
    required this.address,
    required this.neighborhood,
    required this.uuid,
    required this.location,
    required this.liked,
  });

  factory NameBar.fromJson(Map<String, dynamic> json) {
    return NameBar(
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
