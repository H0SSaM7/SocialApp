part of 'add_post_bloc.dart';

abstract class AddPostState extends Equatable {
  const AddPostState();

  @override
  List<Object> get props => [];
}

class AddPostInitial extends AddPostState {}

class ShowPostPickedImage extends AddPostState {
  final File image;

  const ShowPostPickedImage({required this.image});
  @override
  List<Object> get props => [image];
}

class AddPostNoImageSelected extends AddPostState {}

class AddPostLoadingUploadPost extends AddPostState {}

class AddPostSuccessfullyState extends AddPostState {}
