import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_app/data/repository/update_user/update_repo.dart';
import 'package:social_app/utills/services/firebase_storage_services.dart';
import 'package:social_app/utills/services/pick_image_services.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final UpdateUserRepository _updateUserRepository;
  EditProfileBloc({required UpdateUserRepository updateUserRepository})
      : _updateUserRepository = updateUserRepository,
        super(EditProfileInitial()) {
    on<PickImageEvent>(_pickImage);

    on<UpdateProfileEvent>(_updateProfile);
  }

  FutureOr<void> _pickImage(
      PickImageEvent event, Emitter<EditProfileState> emit) async {
    File? _image = await PickImageServices().pickImage();
    if (_image != null) {
      emit(PickedImageReplaceWithOld(_image));
    } else {
      emit(NoImageSelectedState());
    }
  }

  FutureOr<void> _updateProfile(
      UpdateProfileEvent event, Emitter<EditProfileState> emit) async {
    emit(UpdateLoadingState());
    try {
      if (event.image == null) {
        await _updateUserRepository.updateProfile(
            phone: event.phone,
            name: event.name,
            bio: event.bio,
            profileImage: event.image);
        emit(FinishUpdateState());
      } else {
        String imageUrl = await FirebaseStorageServices()
            .uploadImageAndGetUrl(path: 'users', image: event.image);
        await _updateUserRepository.updateProfile(
            phone: event.phone,
            name: event.name,
            bio: event.bio,
            profileImage: imageUrl);
        emit(FinishUpdateState());
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(ErrorUpdateState());
    }
  }
}
