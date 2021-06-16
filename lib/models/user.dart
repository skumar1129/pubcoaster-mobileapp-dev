class ProfUser {
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String fullName;
  final String? picLink;
  final String? bio;
  final int numBars;
  final int numDrinks;
  final int numBrands;
  final int numFollowers;
  final int numFollowing;

  ProfUser(
      {required this.username,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.fullName,
      required this.numBars,
      required this.numBrands,
      required this.numDrinks,
      required this.numFollowers,
      required this.numFollowing,
      this.bio,
      this.picLink});

  factory ProfUser.fromJson(Map<String, dynamic> json) {
    return ProfUser(
        username: json['username'],
        email: json['email'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        fullName: json['fullName'],
        picLink: json['picLink'],
        bio: json['bio'],
        numBars: json['numBars'],
        numBrands: json['numBrands'],
        numDrinks: json['numDrinks'],
        numFollowers: json['numFollowers'],
        numFollowing: json['numFollowing']);
  }
}
