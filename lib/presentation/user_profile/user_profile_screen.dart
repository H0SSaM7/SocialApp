import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/controllers/user_controller/user_bloc.dart';
import 'package:social_app/presentation/settings/settings_screen.dart';
import 'package:social_app/utills/components/components.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is UserLoadedState) {
        return Container(
          color: Theme.of(context).hoverColor,
          child: SingleChildScrollView(
            child: Column(
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
                            color:
                                Theme.of(context).appBarTheme.backgroundColor,
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.elliptical(
                                150,
                                70,
                              ),
                            ),
                          ),
                        ),
                      ),
                      myProfileImage(
                        radius: 62,
                        enableEdit: false,
                        image: NetworkImage(state.user.profileImage!),
                        context: context,
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
                    buildPropertiesOption(context,
                        '${state.user.followers!.length}', 'Followers'),
                    Container(
                      height: 50,
                      width: 1,
                      color: Colors.grey[400],
                    ),
                    buildPropertiesOption(context,
                        '${state.user.following!.length}', 'Following'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 3.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // navigateTo(context,
                            //     const EidProfile()
                            // );
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
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (state is UserErrorState) {
        showDialog(
          context: (context),
          builder: (context) => AlertDialog(
            content: SizedBox(
              height: 100,
              width: 100,
              child: Center(
                child: Text(
                  state.error,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          ),
        );
      }
      return Container();
    });
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
