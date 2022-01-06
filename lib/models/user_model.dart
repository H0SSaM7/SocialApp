class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? personalImage;
  String? coverImage;
  String? bio;
  bool? emailVerified;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.bio,
    this.coverImage,
    this.personalImage,
    this.emailVerified,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    personalImage = json['personalImage'];
    coverImage = json['coverImage'];
    bio = json['bio'];
    emailVerified = json['emailVerified'];
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'personalImage': personalImage,
      'coverImage': coverImage,
      'bio': bio,
      'emailVerified': emailVerified,
    };
  }
}
