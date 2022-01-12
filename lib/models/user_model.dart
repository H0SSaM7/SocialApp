class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? token;
  String? profileImage;
  String? bio;
  bool? emailVerified;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.bio,
    this.profileImage,
    this.emailVerified,
    this.token,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    token = json['token'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    profileImage = json['personalImage'];
    bio = json['bio'];
    emailVerified = json['emailVerified'];
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'personalImage': profileImage,
      'bio': bio,
      'emailVerified': emailVerified,
      'token': token,
    };
  }
}
