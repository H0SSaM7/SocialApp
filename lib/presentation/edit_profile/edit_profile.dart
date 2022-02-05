import 'dart:io';

import 'package:flutter/material.dart ';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/controllers/edit_profile_controller/edit_profile_bloc.dart';
import 'package:social_app/data/repository/update_user/update_repo.dart';
import 'package:social_app/utils/components/components.dart';
import 'package:social_app/utils/components/my_profile_image.dart';
import 'package:social_app/utils/components/regular_form_field.dart';

// ignore: must_be_immutable
class EditProfile extends StatelessWidget {
  EditProfile(
      {Key? key,
      required this.userBio,
      required this.userName,
      required this.userPhone,
      required this.userImage})
      : super(key: key);
  final String userName;
  final String userBio;
  final String userPhone;
  final String userImage;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EditProfileBloc(updateUserRepository: UpdateUserRepository()),
      child: BlocConsumer<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state is PickedImageReplaceWithOld) {
            pickedImage = state.pickedImage;
          }
          if (state is NoImageSelectedState) {
            myToast(msg: 'No Image Selected!', state: toastStates.warning);
          }
          if (state is FinishUpdateProfileState) {
            myToast(msg: 'Successfully Updated!', state: toastStates.warning);
            Navigator.pop(context);
          }
          if (state is ErrorUpdateProfileState) {
            myToast(msg: state.error, state: toastStates.warning);
          }
        },
        builder: (context, state) {
          _nameController.text = userName;
          _bioController.text = userBio;
          _phoneController.text = userPhone;
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Edit Profile'),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                if (checkUpdateState()) {
                  context.read<EditProfileBloc>().add(
                        UpdateProfileEvent(
                          name: _nameController.text,
                          bio: _bioController.text,
                          phone: _phoneController.text,
                          image: pickedImage ?? userImage,
                        ),
                      );
                } else {
                  myToast(msg: 'Nothing to Update', state: toastStates.warning);
                }
              },
              child: state is UpdateProfileLoadingState
                  ? const FittedBox(child: CircularProgressIndicator.adaptive())
                  : const Text('Update'),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        MyProfileImage(
                          radius: 62,
                          enableEdit: true,
                          changeImageTap: () async {
                            context
                                .read<EditProfileBloc>()
                                .add(PickProfileImage());
                          },
                          image: pickedImage == null
                              ? NetworkImage(
                                  userImage,
                                )
                              : FileImage(
                                  File(pickedImage!.path),
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    myFormField(
                      type: TextInputType.name,
                      controller: _nameController,
                      icon: const Icon((Icons.person)),
                      title: 'Name',
                      validateText: 'Name must not be empty.',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    myFormField(
                      type: TextInputType.name,
                      controller: _bioController,
                      icon: const Icon((Icons.info)),
                      title: 'Bio',
                      validateText: 'Bio must not be empty.',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    myFormField(
                      type: TextInputType.phone,
                      controller: _phoneController,
                      icon: const Icon((Icons.phone_android)),
                      title: 'Phone',
                      validateText: 'Phone must not be empty.',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  bool checkUpdateState() {
    if (_phoneController.text != userPhone ||
        _bioController.text != userPhone ||
        _nameController.text != userName ||
        pickedImage != null) {
      return true;
    }
    return false;
  }
}
