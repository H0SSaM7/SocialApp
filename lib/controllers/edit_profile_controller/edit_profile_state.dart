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

class UpdateLoadingState extends EditProfileState {
  @override
  List<Object> get props => [];
}

class FinishUpdateState extends EditProfileState {
  @override
  List<Object> get props => [];
}

class ErrorUpdateState extends EditProfileState {
  final String error = 'Something Went Wrong!';

  @override
  List<Object> get props => [];
}
