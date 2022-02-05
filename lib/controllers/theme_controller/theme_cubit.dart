import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/controllers/theme_controller/theme_state.dart';

import 'package:social_app/utils/network/local/shared_prefrences/cached_helper.dart';

class ThemeCubit extends Cubit<ThemeStates> {
  ThemeCubit() : super(ThemeInitial());

  bool isDarkTheme = CachedHelper.getPref(key: 'isDark') ?? false;

  changeTheme() {
    isDarkTheme = !isDarkTheme;
    CachedHelper.savePref(key: 'isDark', value: isDarkTheme).then((value) {});
    emit(ChangeThemeState());
  }
}
