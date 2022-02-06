import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? name;
  final String? email;
  final String? phone;
  final String? uId;
  final String? token;
  final String? profileImage;
  final String? bio;
  final bool? emailVerified;
  final List? followers;
  final List? following;
  final List? posts;

  const UserModel({
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
    this.posts,
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
      'posts': posts,
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
      posts: map['posts'],
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
      posts: map['posts'],
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        phone,
        uId,
        token,
        profileImage,
        bio,
        emailVerified,
        followers,
        following,
        posts,
      ];
}
