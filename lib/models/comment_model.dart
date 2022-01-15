class CommentModel {
  String? userId;
  String? userName;

  String? userImage;
  String? comment;

  CommentModel({
    this.userId,
    this.userName,
    this.userImage,
    this.comment,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
      'comment': comment,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      userImage: map['userImage'] as String,
      comment: map['comment'] as String,
    );
  }
}
