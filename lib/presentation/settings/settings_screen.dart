import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/controllers/theme_controller/theme_cubit.dart';
import 'package:social_app/controllers/theme_controller/theme_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Dark Theme'),
                  subtitle: const Text('Improve night Viewing'),
                  trailing: Switch(
                    onChanged: (value) {
                      context.read<ThemeCubit>().changeTheme();
                    },
                    value: context.read<ThemeCubit>().isDarkTheme,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
