class MyPost {
  final String uuid;
  final String picLink;
  final String bar;
  final String description;
  final String location;
  final String createdAt;
  final int rating;
  final String editedAt;
  final int numComments;
  final int numLikes;
  final String neighborhood;
  final bool anonymous;
  final String createdBy;

  MyPost(
      {this.uuid,
      this.picLink,
      this.bar,
      this.description,
      this.location,
      this.createdAt,
      this.rating,
      this.editedAt,
      this.neighborhood,
      this.numComments,
      this.numLikes,
      this.anonymous,
      this.createdBy});

  factory MyPost.fromJson(Map<String, dynamic> json) {
    if (json['neighborhood'] != null) {
      return MyPost(
          uuid: json['uuid'],
          picLink: json['picLink'],
          bar: json['bar'],
          description: json['description'],
          location: json['location'],
          editedAt: json['editedAt'],
          anonymous: json['anonymous'],
          rating: json['rating'],
          numComments: json['numComments'],
          numLikes: json['numLikes'],
          createdAt: json['createdAt'],
          neighborhood: json['neighborhood'],
          createdBy: json['createdBy']);
    } else {
      return MyPost(
          uuid: json['uuid'],
          picLink: json['picLink'],
          bar: json['bar'],
          description: json['description'],
          location: json['location'],
          editedAt: json['editedAt'],
          anonymous: json['anonymous'],
          rating: json['rating'],
          numComments: json['numComments'],
          numLikes: json['numLikes'],
          createdAt: json['createdAt'],
          createdBy: json['createdBy']);
    }
  }
}
