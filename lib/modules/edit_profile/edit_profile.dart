import 'dart:io';

import 'package:flutter/material.dart ';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class EidProfile extends StatelessWidget {
  const EidProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController bioController = TextEditingController();
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        nameController.text = cubit.userModel!.name!;
        bioController.text = cubit.userModel!.bio!;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Text('Update'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            child: Column(
              children: [
                myProfileImage(
                    changeImageTap: () {
                      cubit.pickImage();
                    },
                    image: cubit.image == null
                        ? NetworkImage(
                            cubit.userModel!.personalImage!,
                          )
                        : FileImage(
                            File(cubit.image!.path),
                          ),
                    context: context),
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
                  title: 'bio',
                  validateText: 'bio must not be empty.',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
