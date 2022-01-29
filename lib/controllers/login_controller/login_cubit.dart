import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/controllers/login_controller/login_states.dart';
import 'package:social_app/data/repository/auth_repos/auth_repository.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit({
    required AuthRepository loginRepository,
  })  : _loginRepository = loginRepository,
        super(LoginInitialState());

  final AuthRepository _loginRepository;
  static LoginCubit get(BuildContext context) => BlocProvider.of(context);
  loginUserIn({required String email, required String password}) async {
    emit(LoginLoadingState());
    String state =
        await _loginRepository.userLogin(email: email, password: password);
    if (state == 'success') {
      String uid = _loginRepository.getUserId();
      emit(LoginSuccessState(uid));
    } else {
      emit(LoginErrorState(state));
    }
  }

  bool isObscure = true;
  void changePasswordVisibility() {
    isObscure = !isObscure;
    emit(LoginChangePasswordTextState());
  }
}
