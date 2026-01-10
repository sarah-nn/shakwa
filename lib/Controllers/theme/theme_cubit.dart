import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa/Controllers/theme/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<AppThemeMode> {
  static const _themeKey = 'theme_mode';

  ThemeCubit() : super(AppThemeMode.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString(_themeKey);

    if (theme == AppThemeMode.dark.name) {
      emit(AppThemeMode.dark);
    } else {
      emit(AppThemeMode.light);
    }
  }

  Future<void> toggleTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    final newTheme = isDark ? AppThemeMode.dark : AppThemeMode.light;

    await prefs.setString(_themeKey, newTheme.name);
    emit(newTheme);
  }
}
