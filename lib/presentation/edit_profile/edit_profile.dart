import 'dart:io';

import 'package:flutter/material.dart ';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/controllers/cubit/cubit.dart';
import 'package:social_app/controllers/cubit/states.dart';
import 'package:social_app/utills/components/components.dart';
import 'package:social_app/utills/components/regular_form_field.dart';

class EidProfile extends StatelessWidget {
  const EidProfile(
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

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController bioController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    return BlocBuilder<SocialCubit, SocialStates>(
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        nameController.text = userName;
        bioController.text = userBio;
        phoneController.text = userPhone;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('Edit Profile'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              // if (state is! SocialLoadingUploadProfileImageState) {
              //   await cubit.updateProfile(
              //     email: cubit.userModel!.email!,
              //     phone: phoneController.text,
              //     name: nameController.text,
              //     uId: cubit.userModel!.uId!,
              //     bio: bioController.text,
              //     profileImage:
              //         cubit.profileImageUrl ?? cubit.userModel!.profileImage!,
              //   );
              //   Navigator.pop(context);
              // }
            },
            child: const Text('Update'),
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
                      myProfileImage(
                        radius: 62,
                        enableEdit: true,
                        changeImageTap: () async {
                          await cubit.setProfileImage();
                          cubit.uploadProfileImage();
                        },
                        image: cubit.profileImage == null
                            ? NetworkImage(
                                userImage,
                              )
                            : FileImage(
                                File(cubit.profileImage!.path),
                              ),
                        context: context,
                      ),
                      if (state is SocialLoadingUploadProfileImageState)
                        const CircularProgressIndicator.adaptive()
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  myFormField(
                    type: TextInputType.name,
                    controller: nameController,
                    icon: const Icon((Icons.person)),
                    title: 'Name',
                    validateText: 'Name must not be empty.',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  myFormField(
                    type: TextInputType.name,
                    controller: bioController,
                    icon: const Icon((Icons.info)),
                    title: 'Bio',
                    validateText: 'Bio must not be empty.',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  myFormField(
                    type: TextInputType.phone,
                    controller: phoneController,
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
    );
  }
}
