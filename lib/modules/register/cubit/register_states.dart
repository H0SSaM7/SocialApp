abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}

class RegisterUserCreateLoadingState extends RegisterStates {}

class RegisterUserCreateSuccessState extends RegisterStates {
  final String uId;

  RegisterUserCreateSuccessState(this.uId);
}

class RegisterUserCreateErrorState extends RegisterStates {}

class RegisterChangePasswordTextState extends RegisterStates {}
