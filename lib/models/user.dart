class User {
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String fullName;
  final String? picLink;

  User(
      {required this.username,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.fullName,
      this.picLink});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['username'],
        email: json['email'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        fullName: json['fullName']);
  }
}
