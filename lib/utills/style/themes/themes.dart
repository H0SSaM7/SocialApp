import 'package:flutter/material.dart';
import 'package:social_app/utills/style/colors.dart';

class ThemesHelper {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: Colors.brown,
      hintColor: Colors.black,
      // iconTheme: const IconThemeData(color: Colors.black),
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        ),
        headline1: TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        subtitle1: TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0.0,
          actionsIconTheme: IconThemeData(
            color: Colors.black,
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 22.0,
            fontWeight: FontWeight.w700,
          )),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: mainColor,
        unselectedItemColor: Colors.grey[400],
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(mainColor),
        trackColor: MaterialStateProperty.all(Colors.grey),
      ));

  static ThemeData darkTheme = ThemeData(
      primarySwatch: Colors.brown,
      hintColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          color: Color(0xffd7dddc),
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        ),
        headline1: TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        subtitle1: TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
      ),
      scaffoldBackgroundColor: const Color(0xff22345d),
      appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff121e3b),
          elevation: 0.0,
          centerTitle: true,
          actionsIconTheme: IconThemeData(
            color: Colors.white,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          )),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xff121e3b),
        selectedItemColor: mainColor,
        unselectedItemColor: Color(0xffbdbdbd),
      ),
      dividerColor: Colors.white);
}
