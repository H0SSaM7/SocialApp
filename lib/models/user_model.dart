class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? emailVerified;

  UserModel({this.name, this.email, this.phone, this.uId});
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    emailVerified = json['emailVerified'];
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'emailVerified': emailVerified,
    };
  }
}
