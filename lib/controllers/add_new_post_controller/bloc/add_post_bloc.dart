import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_app/data/repository/posts_repo/posts_repository.dart';
import 'package:social_app/utils/services/firebase_storage_services.dart';
import 'package:social_app/utils/services/pick_image_services.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  final PostsRepository _postsRepository;
  AddPostBloc({required PostsRepository postsRepository})
      : _postsRepository = postsRepository,
        super(AddPostInitial()) {
    on<AddImageToPostEvent>(_addimage);
    on<UploadPostEvent>(_uploadPost);
    on<DeletepickedPostImageEvent>(_deletePickedImage);
  }

  Future<FutureOr<void>> _addimage(
      AddImageToPostEvent event, Emitter<AddPostState> emit) async {
    File? _image = await PickImageServices().pickImage();
    if (_image != null) {
      emit(ShowPostPickedImage(_image));
    } else {
      emit(AddPostNoImageSelected());
    }
  }

  FutureOr<void> _uploadPost(
      UploadPostEvent event, Emitter<AddPostState> emit) async {
    final state = this.state;
    if (state is ShowPostPickedImage) {
      String _imageUrl = await FirebaseStorageServices()
          .uploadImageAndGetUrl(path: 'Posts', image: state.image);
      await _postsRepository.createNewPost(
        postImage: _imageUrl,
        profileImage: event.profileImage,
        postDescription: event.postdescription,
        name: event.name,
      );
    } else {
      await _postsRepository.createNewPost(
        postImage: null,
        profileImage: event.profileImage,
        postDescription: event.postdescription,
        name: event.name,
      );
    }
  }

  FutureOr<void> _deletePickedImage(
      DeletepickedPostImageEvent event, Emitter<AddPostState> emit) {}
}
