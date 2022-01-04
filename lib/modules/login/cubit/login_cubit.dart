import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_app/modules/login/cubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  // void userLogin({required String email, required String password}) {
  //   emit(LoginLoadingState());
  //   DioHelper.post(
  //     url: loginURL,
  //     data: {
  //       'email': email,
  //       'password': password,
  //     },
  //   ).then((value) {
  //     UserModel data = UserModel.fromJson(value.data);
  //     emit(LoginSuccessState(userLoginClass: data));
  //
  //     debugPrint(value.data.toString());
  //   }).catchError((error) {
  //     debugPrint(error.toString());
  //     emit(LoginErrorState());
  //   });
  // }

  bool isObscure = true;
  void changePasswordVisibility() {
    isObscure = !isObscure;
    emit(LoginChangePasswordTextState());
  }
}
