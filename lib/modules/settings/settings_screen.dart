import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return Container(
          color: Theme.of(context).splashColor,
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
                          color: Theme.of(context).appBarTheme.backgroundColor,
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.elliptical(
                              150,
                              100,
                            ),
                          ),
                        ),
                      ),
                    ),
                    myProfileImage(
                        image: NetworkImage(cubit.userModel!.personalImage!),
                        changeImageTap: () {})
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                cubit.userModel!.name!,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Text(
                cubit.userModel!.bio!,
                style: Theme.of(context).textTheme.caption,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  buildPropertiesOption(context, '100', 'Posts'),
                  Container(
                    height: 50,
                    width: 1,
                    color: Colors.grey[400],
                  ),
                  buildPropertiesOption(context, '20 K', 'Followers'),
                  Container(
                    height: 50,
                    width: 1,
                    color: Colors.grey[400],
                  ),
                  buildPropertiesOption(context, '77', 'Following'),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text('Add photos'),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    OutlinedButton(
                        onPressed: () {},
                        child: const FaIcon(
                          FontAwesomeIcons.solidEdit,
                          size: 15,
                        ))
                  ],
                ),
              )
            ],
          ),
        );
      },
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
