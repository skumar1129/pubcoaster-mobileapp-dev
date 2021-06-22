class Follower {
  final String user;
  final String bio;
  final String fullName;
  final String picLink;
  final bool? following;

  Follower({
    required this.user,
    required this.bio,
    required this.fullName,
    required this.picLink,
    this.following,
  });

  factory Follower.fromJson(Map<String, dynamic> json) {
    return Follower(
      user: json['user'],
      bio: json['bio'],
      fullName: json['fullName'],
      picLink: json['picLink'],
      following: json['following'],
    );
  }
}
