part of 'add_post_bloc.dart';

abstract class AddPostEvent extends Equatable {
  const AddPostEvent();

  @override
  List<Object> get props => [];
}

class AddImageToPostEvent extends AddPostEvent {
  @override
  List<Object> get props => [];
}

class UploadPostEvent extends AddPostEvent {
  final String name;
  final String postdescription;
  final String profileImage;
  const UploadPostEvent(this.name, this.postdescription, this.profileImage);
  @override
  List<Object> get props => [name, postdescription];
}

class DeletepickedPostImageEvent extends AddPostEvent {}
