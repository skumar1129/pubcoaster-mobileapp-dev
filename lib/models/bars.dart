class Bars {
  final String bar;
  final String type;
  final String address;
  final String neighborhood;
  final String uuid;
  final String location;

  Bars(
      {required this.bar,
      required this.type,
      required this.address,
      required this.neighborhood,
      required this.uuid,
      required this.location});

  factory Bars.fromJson(Map<String, dynamic> json) {
    return Bars(
        bar: json['bar'],
        type: json['type'],
        address: json['address'],
        neighborhood: json['neighborhood'],
        uuid: json['uuid'],
        location: json['location']);
  }
}
