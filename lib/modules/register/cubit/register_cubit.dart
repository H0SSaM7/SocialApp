import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/register/cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);

  // void userRegister(
  //     {required String email,
  //     required String password,
  //     required String phone,
  //     required String name}) {
  //   emit(RegisterLoadingState());
  //   DioHelper.post(
  //     url: registerURL,
  //     data: {
  //       'email': email,
  //       'password': password,
  //       'name': name,
  //       'phone': phone,
  //     },
  //   ).then((value) {
  //     UserModel data = UserModel.fromJson(value.data);
  //     emit(RegisterSuccessState(userClass: data));
  //
  //     debugPrint(value.data.toString());
  //   }).catchError((error) {
  //     debugPrint(error.toString());
  //     emit(RegisterErrorState());
  //   });
  // }

  bool isObscure = true;
  void changePasswordVisibility() {
    isObscure = !isObscure;
    emit(RegisterChangePasswordTextState());
  }
}
