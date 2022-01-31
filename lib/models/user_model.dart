import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? token;
  String? profileImage;
  String? bio;
  bool? emailVerified;
  List? followers;
  List? following;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.bio,
    this.profileImage,
    this.emailVerified,
    this.token,
    this.followers,
    this.following,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'token': token,
      'profileImage': profileImage,
      'bio': bio,
      'emailVerified': emailVerified,
      'followers': followers,
      'following': following,
    };
  }

  factory UserModel.fromSnap(DocumentSnapshot map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      uId: map['uId'] as String,
      token: map['token'] as String,
      profileImage: map['profileImage'] as String,
      bio: map['bio'] as String,
      emailVerified: map['emailVerified'] as bool,
      followers: map['followers'],
      following: map['following'],
    );
  }
  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      uId: map['uId'] as String,
      token: map['token'] as String,
      profileImage: map['profileImage'] as String,
      bio: map['bio'] as String,
      emailVerified: map['emailVerified'] as bool,
      followers: map['followers'],
      following: map['following'],
    );
  }
}
