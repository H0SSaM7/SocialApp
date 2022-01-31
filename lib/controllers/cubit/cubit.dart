import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/controllers/cubit/states.dart';
import 'package:social_app/data/data_provider/remote/notificaiton/dio_helper.dart';
import 'package:social_app/models/chats_model.dart';
import 'package:social_app/models/posts_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/presentation/chats/chats_screen.dart';
import 'package:social_app/presentation/explore/explore_screen.dart';
import 'package:social_app/presentation/user_profile/user_profile_screen.dart';
import 'package:social_app/presentation/users/users_screen.dart';
import 'package:social_app/utills/consistent/consistent.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  followUser({required var userId}) {
    if (userById!.followers!.contains(currentUserId)) {
      FirebaseFirestore.instance.collection('users').doc(userId).update({
        'followers': FieldValue.arrayRemove([currentUserId])
      });
      FirebaseFirestore.instance.collection('users').doc(currentUserId).update({
        'following': FieldValue.arrayRemove([userId])
      });
    } else {
      FirebaseFirestore.instance.collection('users').doc(userId).update({
        'followers': FieldValue.arrayUnion([currentUserId])
      });
      FirebaseFirestore.instance.collection('users').doc(currentUserId).update({
        'following': FieldValue.arrayUnion([userId])
      });
    }
  }

  List<UserModel> users = [];

  getAllUsers() {
    emit(SocialLoadingGetAllUsersState());
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != currentUserId) {
            users.add(UserModel.fromJson(element.data()));
          }
          emit(SocialSuccessGetAllUsersState());
        }
      }).catchError((error) {
        emit(SocialErrorGetAllUsersState());

        debugPrint(error.toString());
      });
    }
  }

  UserModel? userById;

  getUserById({required String userId}) {
    userById = null;
    emit(SocialLoadingGetUserByIdState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .listen((event) {
      userById = UserModel.fromJson(event.data()!);
      emit(SocialSuccessGetUserByIdState());
    }).onError((err) {
      debugPrint(err.toString());
      emit(SocialErrorGetUserByIdState());
    });
  }

// home page work
  int currentIndex = 0;

  changeNavbar(int index) {
    if (index == 1) {
      getAllUsers();
    }
    currentIndex = index;
    emit(SocialChangeNavBarState());
  }

  List<Widget> screens = const [
    ExploreScreen(),
    ChatsScreen(),
    UsersScreen(),
    UserProfileScreen(),
  ];
  List<String> appBarTitles = const ['Explore', 'Chats', 'Users', 'Profile'];

  // setting screen
  late int radioValue;

  // image picker and upload methods

  final ImagePicker _picker = ImagePicker();

  // file image variables
  File? profileImage;
  File? postImage;

  // Url image variables
  String? postImageUrl;
  String? profileImageUrl;

  // this method only to render picked image
  setProfileImage() async {
    profileImage = await pickImage();
    emit(SocialPickImageState());
  }

  setPostImage() async {
    postImage = await pickImage();
    emit(SocialPickImageState());
  }

  deletePickedPostImage() {
    postImage = null;
    emit(SocialDeletePostImageState());
  }

// it return the picked image from device and i store it in any variable
  Future<File?> pickImage() async {
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return null;
    } else {
      return File(pickedImage.path);
    }
  }

  //its return url of the picked profile image after store it in firebase
  uploadProfileImage() {
    if (profileImage == null) {
      null;
    } else {
      emit(SocialLoadingUploadProfileImageState());
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
          .putFile(profileImage!)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          profileImageUrl = value;
          emit(SocialSuccessUploadProfileImageState());
        }).catchError((error) {
          debugPrint(error.toString());
        });
      });
    }
  }

  // update the whole profile properties
  updateProfile({
    required String email,
    required String phone,
    required String name,
    required String uId,
    required String bio,
    required String profileImage,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      emailVerified: FirebaseAuth.instance.currentUser!.emailVerified,
      bio: bio,
      profileImage: profileImage,
      token: '',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .update(model.toJson())
        .then((value) {})
        .catchError((error) {});
  }

  uploadPostImageAndCreatePost(
      {required String date, required String postDescription}) {
    if (postImage == null) {
      null;
    } else {
      emit(SocialLoadingUploadPostImageState());
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(postImage!.path).pathSegments.last}')
          .putFile(postImage!)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          postImageUrl = value;
          emit(SocialSuccessUploadPostImageState());
          createNewPost(
              postImage: postImageUrl,
              date: date,
              postDescription: postDescription);
        }).catchError((error) {
          debugPrint(error.toString());
        });
      });
    }
  }

  createNewPost({
    required String? postImage,
    required String date,
    required String postDescription,
  }) {
    emit(SocialLoadingCreateNewPostState());
    var userModel;
    PostsModel postsModel = PostsModel(
      name: userModel!.name,
      uId: userModel!.uId,
      profileImage: userModel!.profileImage,
      date: date,
      postDescription: postDescription,
      postImage: postImage,
      likes: [],
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(
          postsModel.toJson(),
        )
        .then((value) {
      emit(SocialSuccessCreateNewPostState());
    }).catchError((error) {
      emit(SocialErrorCreateNewPostState());
      debugPrint(error.toString());
    });
  }

// chats methods ---------------------------------------------------------------

  ChatsModel? chatsModel;

  sendMessages({
    required String receiverName,
    required String receiverToken,
    required String receiverId,
    required String message,
    required String date,
  }) {
    chatsModel = ChatsModel(
      receiverId: receiverId,
      message: message,
      date: date,
      senderId: currentUserId,
    );
    // setup message for me
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(chatsModel!.toMap())
        .then((value) {
      DioHelper.post(
          token: receiverToken, userName: receiverName, message: message);
      emit(SocialSuccessSendMessagesFromMeState());
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(SocialErrorSendMessagesFromMeState());
    });
    // setup message for other user
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(currentUserId)
        .collection('messages')
        .add(chatsModel!.toMap())
        .then((value) {
      emit(SocialSuccessSendMessagesToOtherState());
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(SocialErrorSendMessagesToOtherState());
    });
  }

  List<ChatsModel> messages = [];

  getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(ChatsModel.fromMap(element.data()));
      }
      emit(SocialSuccessfullyReceivedMessage());
    });
  }
}
