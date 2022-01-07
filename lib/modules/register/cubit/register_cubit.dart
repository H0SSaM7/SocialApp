import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/register/cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);
  bool isObscure = true;
  void changePasswordVisibility() {
    isObscure = !isObscure;
    emit(RegisterChangePasswordTextState());
  }

  void userRegister(
      {required String email,
      required String password,
      required String phone,
      required String name}) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(RegisterSuccessState());
      userCreate(email: email, phone: phone, name: name, uId: value.user!.uid);
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(RegisterErrorState(onError.toString()));
    });
  }

  userCreate({
    required String email,
    required String phone,
    required String name,
    required String uId,
  }) {
    emit(RegisterUserCreateLoadingState());

    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      emailVerified: FirebaseAuth.instance.currentUser!.emailVerified,
      bio: 'Write your bio ...',
      profileImage: '',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toJson())
        .then((value) {
      emit(RegisterUserCreateSuccessState(uId));
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(RegisterUserCreateErrorState());
    });
  }
}
