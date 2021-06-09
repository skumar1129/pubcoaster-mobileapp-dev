class Follower {
  final String user;

  Follower({required this.user});

  factory Follower.fromJson(Map<String, dynamic> json) {
    return Follower(
      user: json['user'],
    );
  }
}
