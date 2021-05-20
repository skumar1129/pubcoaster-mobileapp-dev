class UserLiked {
  final String type;
  final String user;
  final String? search;

  UserLiked({
    required this.type,
    required this.user,
    this.search,
  });
}
