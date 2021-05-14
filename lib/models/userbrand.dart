class UserBrand {
  final String brandName;
  final String user;
  final String uuid;

  UserBrand({required this.brandName, required this.user, required this.uuid});

  factory UserBrand.fromJson(Map<String, dynamic> json) {
    return UserBrand(
        brandName: json['brandName'], user: json['user'], uuid: json['uuid']);
  }
}
