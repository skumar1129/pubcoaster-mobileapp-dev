class SinglePost {
  final String uuid;
  final String picLink;
  final String bar;
  final String description;
  final String location;
  final String createdAt;
  final String editedAt;
  final int rating;
  final String createdBy;
  final bool anonymous;
  final String neighborhood;
  final List<Map<String, String>> comments;
  final List<Map<String, String>> likes;

  SinglePost(
      {this.uuid,
      this.picLink,
      this.anonymous,
      this.bar,
      this.comments,
      this.createdAt,
      this.createdBy,
      this.likes,
      this.location,
      this.description,
      this.editedAt,
      this.neighborhood,
      this.rating});

  factory SinglePost.fromJson(Map<String, dynamic> json) {
    if (json['anonymous'] == false && json['neighborhood'] != null) {
      return SinglePost(
          uuid: json['uuid'],
          picLink: json['picLink'],
          bar: json['bar'],
          description: json['description'],
          location: json['location'],
          editedAt: json['editedAt'],
          anonymous: json['anonymous'],
          rating: json['rating'],
          comments: json['comments'],
          likes: json['likes'],
          createdAt: json['createdAt'],
          neighborhood: json['neighborhood'],
          createdBy: json['createdBy']);
    } else if (json['anonymous'] == false && json['neighborhood'] == null) {
      return SinglePost(
          uuid: json['uuid'],
          picLink: json['picLink'],
          bar: json['bar'],
          description: json['description'],
          location: json['location'],
          editedAt: json['editedAt'],
          anonymous: json['anonymous'],
          rating: json['rating'],
          comments: json['comments'],
          likes: json['likes'],
          createdAt: json['createdAt'],
          createdBy: json['createdBy']);
    } else if (json['anonymous'] == true && json['neighborhood'] != null) {
      return SinglePost(
          uuid: json['uuid'],
          picLink: json['picLink'],
          bar: json['bar'],
          description: json['description'],
          location: json['location'],
          editedAt: json['editedAt'],
          anonymous: json['anonymous'],
          rating: json['rating'],
          comments: json['comments'],
          likes: json['likes'],
          createdAt: json['createdAt'],
          neighborhood: json['neighborhood']);
    } else {
      return SinglePost(
          uuid: json['uuid'],
          picLink: json['picLink'],
          bar: json['bar'],
          description: json['description'],
          location: json['location'],
          editedAt: json['editedAt'],
          anonymous: json['anonymous'],
          rating: json['rating'],
          comments: json['comments'],
          likes: json['likes'],
          createdAt: json['createdAt']);
    }
  }
}
