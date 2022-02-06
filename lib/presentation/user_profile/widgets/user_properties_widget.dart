import 'package:flutter/material.dart%20';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/controllers/user_controller/user_bloc.dart';
import 'package:social_app/presentation/edit_profile/edit_profile.dart';

import '../../../utils/components/components.dart';
import '../../../utils/components/my_profile_image.dart';
import '../../settings/settings_screen.dart';

class UserPropertiesWidget extends StatelessWidget {
  const UserPropertiesWidget({Key? key, required this.state}) : super(key: key);
  final UserLoadedState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Container(
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.elliptical(
                        150,
                        70,
                      ),
                    ),
                  ),
                ),
              ),
              MyProfileImage(
                radius: 62,
                enableEdit: false,
                image: NetworkImage(state.user.profileImage!),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          state.user.name!,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: 250,
          alignment: Alignment.center,
          child: Text(
            state.user.bio!,
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            buildPropertiesOption(context, '2', 'Posts'),
            Container(
              height: 50,
              width: 1,
              color: Colors.grey[400],
            ),
            buildPropertiesOption(
                context, '${state.user.followers!.length}', 'Followers'),
            Container(
              height: 50,
              width: 1,
              color: Colors.grey[400],
            ),
            buildPropertiesOption(
                context, '${state.user.following!.length}', 'Following'),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    navigateTo(
                      context,
                      EditProfile(
                          userBio: state.user.bio!,
                          userName: state.user.name!,
                          userPhone: state.user.phone!,
                          userImage: state.user.profileImage!),
                    );
                  },
                  child: const Text('Edit Profile'),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              OutlinedButton(
                onPressed: () {
                  navigateTo(
                    context,
                    const SettingsScreen(),
                  );
                },
                child: const FaIcon(
                  FontAwesomeIcons.cog,
                  size: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Expanded buildPropertiesOption(
      BuildContext context, String number, String title) {
    return Expanded(
        child: Column(
      children: [
        Text(
          number,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    ));
  }
}
