part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();
}

class PickProfileImage extends EditProfileEvent {
  @override
  List<Object?> get props => [];
}

class UpdateProfileEvent extends EditProfileEvent {
  final dynamic image;
  final String name;
  final String bio;
  final String phone;

  const UpdateProfileEvent({
    required this.image,
    required this.name,
    required this.bio,
    required this.phone,
  });
  @override
  List<Object?> get props => [];
}
