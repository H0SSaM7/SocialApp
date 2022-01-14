import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/chats_model.dart';
import 'package:social_app/models/posts_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/explore/explore_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/consistent/consistent.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_app/shared/network/remote/dio_helper.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;

  // getting user data when the app open.
  getUserDate() {
    emit(SocialLoadingGetUserState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .get()
        .then((value) {
      // print(value.data().toString());
      userModel = UserModel.fromJson(value.data()!);

      emit(SocialSuccessGetUserState());
    }).catchError((onError) {
      debugPrint(onError);
      emit(SocialErrorGetUserState());
    });
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
    SettingsScreen(),
  ];
  List<String> appBarTitles = const ['Explore', 'Chats', 'Users', 'Profile'];

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
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .update(model.toJson())
        .then((value) {
      getUserDate();
    }).catchError((error) {});
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

  List<PostsModel> posts = [];
  List<String> postsId = [];
  List<int> likesCount = [];

  // List<List<Map<String, dynamic>>> likesList = [];
  // List<List<Map<String, dynamic>>> commentsList = [];

  getStreamPosts() {
    emit(SocialLoadingGetPostsState());
    FirebaseFirestore.instance
        .collection('posts')
        .snapshots()
        .listen((event) async {
      posts = [];
      postsId = [];
      for (var element in event.docs) {
        postsId.add(element.id);
        posts.add(PostsModel.fromMap(element.data()));

        emit(SocialSuccessGetPostsState());
      }
    }).onError((handleError) {
      debugPrint(handleError.toString());
      emit(SocialSuccessGetPostsState());
    });
  }

  // getPosts() async {
  //   emit(SocialLoadingGetPostsState());
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> data =
  //         await FirebaseFirestore.instance.collection('posts').get();
  //     for (var element in data.docs) {
  //       posts.add(PostsModel.fromMap(element.data()));
  //       postsId.add(element.id);
  //       // after get the post collection go to references of this collection
  //       // and open likes collection
  //       // and make a list of each post in this list contain userId and its bollen value
  //       QuerySnapshot<Map<String, dynamic>> likesData =
  //           await element.reference.collection('likes').get();
  //       List<Map<String, dynamic>> anyLike = [];
  //       for (var e in likesData.docs) {
  //         anyLike.add({e.id: e.data()['like']});
  //       }
  //
  //       likesList.add(anyLike);
  //       // after get the post collection go to refrence of this collection
  //       // and open comment collection
  //       // and make a list of each post this list contain userid and its bollen value
  //       QuerySnapshot<Map<String, dynamic>> commentsData =
  //           await element.reference.collection('comments').get();
  //       List<Map<String, dynamic>> anyComment = [];
  //       for (var e in commentsData.docs) {
  //         anyComment.add({e.id: e.data()['like']});
  //       }
  //       commentsList.add(anyComment);
  //     }
  //     emit(SocialSuccessGetPostsState());
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     emit(SocialSuccessGetPostsState());
  //   }
  // }

  // getLikes() async {
  //   try {
  //     QuerySnapshot data =
  //         await FirebaseFirestore.instance.collection('posts').get();
  //     for (var element in data.docs) {
  //       QuerySnapshot<Map<String, dynamic>> likesData =
  //           await element.reference.collection('likes').get();
  //       List<Map<String, dynamic>> any = [];
  //       for (var e in likesData.docs) {
  //         any.add({e.id: e.data()["like"]});
  //       }
  //       likesList.add(any);
  //       emit(SocialRefreshLikesState());
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  addOrRemoveLike({required String postId, required List likes}) {
    if (likes.contains(currentUserId)) {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .update({
            'likes': FieldValue.arrayRemove([currentUserId]),
          })
          .then((value) => emit(SocialSuccessPostLikeState()))
          .catchError((err) {
            debugPrint(err.toString());
            emit(SocialErrorPostLikeState());
          });
    } else {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .update({
            'likes': FieldValue.arrayUnion([currentUserId]),
          })
          .then((value) => emit(SocialSuccessPostLikeState()))
          .catchError((err) {
            debugPrint(err.toString());
            emit(SocialErrorPostLikeState());
          });
    }
  }

  postComment({required String postId, required String comment}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(currentUserId)
        .set({
      'comment': comment,
    }).then((value) {
      emit(SocialSuccessPostCommentState());
    }).catchError((error) {
      emit(SocialErrorPostCommentState());
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
