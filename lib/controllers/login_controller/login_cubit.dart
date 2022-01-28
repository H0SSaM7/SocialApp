import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/controllers/login_controller/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      var token = await FirebaseMessaging.instance.getToken();
      FirebaseFirestore.instance
          .collection('users')
          .doc(value.user!.uid)
          .update(
        {
          'token': token,
        },
      );
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(LoginErrorState(onError.toString()));
    });
  }

  bool isObscure = true;
  void changePasswordVisibility() {
    isObscure = !isObscure;
    emit(LoginChangePasswordTextState());
  }
}
