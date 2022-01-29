import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_app/controllers/cubit/cubit.dart';
import 'package:social_app/controllers/posts_controller/posts_bloc.dart';
import 'package:social_app/controllers/theme_controller/theme_cubit.dart';
import 'package:social_app/controllers/theme_controller/theme_state.dart';
import 'package:social_app/data/repository/posts_repo/posts_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    this.page,
  }) : super(key: key);
  final Widget? page;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SocialCubit()..getUserDate()),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(
            create: (context) =>
                PostsBloc(PostsRepository())..add(const PostsEvent())),
      ],
      child: BlocBuilder<ThemeCubit, ThemeStates>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: FlexColorScheme.light(
              textTheme: const TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  caption: TextStyle(fontSize: 12.5)),
              fontFamily: GoogleFonts.ptSans().fontFamily,
              scheme: FlexScheme.bigStone,
            ).toTheme,
            darkTheme: FlexColorScheme.dark(
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              fontFamily: GoogleFonts.ptSans().fontFamily,
              scheme: FlexScheme.bigStone,
            ).toTheme,
            themeMode: context.watch<ThemeCubit>().isDarkTheme
                ? ThemeMode.dark
                : ThemeMode.light,
            home: page,
          );
        },
      ),
    );
  }
}
