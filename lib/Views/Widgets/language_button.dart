import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa/Controllers/language_cubit.dart';

class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LanguageCubit>();
    final currentLang = cubit.state.languageCode;

    return ElevatedButton.icon(
      onPressed: cubit.toggleLanguage,
      icon: Icon(Icons.language),
      label: Text(currentLang == 'en' ? 'English' : 'العربية'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
