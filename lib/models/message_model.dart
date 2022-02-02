class MessageModel {
  String? senderId;
  String? receiverId;
  String? message;
  String? date;

  MessageModel({
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

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      message: map['message'] as String,
      date: map['date'] as String,
    );
  }
}
