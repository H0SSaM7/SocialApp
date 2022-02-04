part of 'edit_profile_bloc.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();
}

class EditProfileInitial extends EditProfileState {
  @override
  List<Object> get props => [];
}

class PickedImageReplaceWithOld extends EditProfileState {
  final File? pickedImage;

  const PickedImageReplaceWithOld(this.pickedImage);

  @override
  List<Object?> get props => [];
}

class NoImageSelectedState extends EditProfileState {
  @override
  List<Object> get props => [];
}

class UpdateProfileLoadingState extends EditProfileState {
  @override
  List<Object> get props => [];
}

class FinishUpdateProfileState extends EditProfileState {
  @override
  List<Object> get props => [];
}

class ErrorUpdateProfileState extends EditProfileState {
  final String error = 'Something Went Wrong!';

  @override
  List<Object> get props => [];
}
