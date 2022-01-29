import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/controllers/login_controller/login_states.dart';
import 'package:social_app/data/repository/auth_repos/login_repo/login_repository.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this.loginRepository) : super(LoginInitialState());
  LoginRepository? loginRepository;

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);
  loginUserIn({required String email, required String password}) async {
    String? userId =
        await loginRepository!.userLogin(email: email, password: password);
    if (userId != null) {
      await loginRepository!.updateUserToken(userId);
      emit(LoginSuccessState(userId));
    }
  }

  bool isObscure = true;
  void changePasswordVisibility() {
    isObscure = !isObscure;
    emit(LoginChangePasswordTextState());
  }
}
