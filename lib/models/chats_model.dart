class ChatsModel {
  String? senderId;
  String? receiverId;
  String? message;
  String? date;

  ChatsModel({
    this.senderId,
    this.receiverId,
    this.message,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'date': date,
    };
  }

  factory ChatsModel.fromMap(Map<String, dynamic> map) {
    return ChatsModel(
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      message: map['message'] as String,
      date: map['date'] as String,
    );
  }
}
