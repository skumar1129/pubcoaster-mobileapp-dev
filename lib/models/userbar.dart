class UserBar {
  final String barName;
  final String location;
  final String neighborhood;
  final String user;
  final String uuid;

  UserBar(
      {required this.barName,
      required this.location,
      required this.neighborhood,
      required this.user,
      required this.uuid});

  factory UserBar.fromJson(Map<String, dynamic> json) {
    return UserBar(
        barName: json['barName'],
        location: json['location'],
        neighborhood: json['neighborhood'],
        user: json['user'],
        uuid: json['uuid']);
  }
}
