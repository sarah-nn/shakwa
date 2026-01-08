import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<Locale> {
  static const String _langKey = 'app_language';

  LanguageCubit() : super(const Locale('en'));

  Future<void> loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_langKey) ?? 'en';
    emit(Locale(code));
  }

  Future<void> toggleLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final newLang = state.languageCode == 'en' ? 'ar' : 'en';
    await prefs.setString(_langKey, newLang);
    emit(Locale(newLang));
  }
}
