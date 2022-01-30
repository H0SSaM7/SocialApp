import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/controllers/register_controller/register_states.dart';
import 'package:social_app/data/repository/auth_repos/auth_repository.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(RegisterInitialState());
  final AuthRepository _authRepository;
  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);
  bool isObscure = true;
  registerUserIn(
      {required String email,
      required String password,
      required String phone,
      required String name}) async {
    emit(RegisterLoadingState());
    String state = await _authRepository.userRegister(
      email: email,
      password: password,
    );
    if (state == 'success') {
      String uId = _authRepository.getUserId();
      await _authRepository.createNewUserInDB(
          email: email, phone: phone, name: name, uId: uId);
      emit(RegisterSuccessState());
    } else {
      emit(RegisterErrorState(state));
    }
  }

  void changePasswordVisibility() {
    isObscure = !isObscure;
    emit(RegisterChangePasswordTextState());
  }
}
