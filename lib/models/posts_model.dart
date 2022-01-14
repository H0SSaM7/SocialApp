class PostsModel {
  String? name;
  String? uId;
  String? date;
  String? postDescription;
  String? postImage;
  String? profileImage;
  List? likes;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uId': uId,
      'date': date,
      'postDescription': postDescription,
      'postImage': postImage,
      'profileImage': profileImage,
      'likes': likes
    };
  }

  factory PostsModel.fromMap(Map<String, dynamic> map) {
    return PostsModel(
      name: map['name'] as String,
      uId: map['uId'] as String,
      date: map['date'] as String,
      postDescription: map['postDescription'] as String,
      postImage: map['postImage'] as String,
      profileImage: map['profileImage'] as String,
      likes: map['likes'],
    );
  }

  PostsModel(
      {this.name,
      this.uId,
      this.date,
      this.postDescription,
      this.postImage,
      this.profileImage,
      this.likes});
}
