import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shakwa/Controllers/language_cubit.dart';
import 'package:shakwa/Controllers/theme/theme_cubit.dart';
import 'package:shakwa/Controllers/theme/theme_state.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shakwa/Core/Constants/route_constant.dart';
import 'package:shakwa/Core/cache_helper.dart';
import 'package:shakwa/Core/service_locator.dart';
import 'package:shakwa/Views/Widgets/auth/name_email.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    // الوصول للكيوبت لمراقبة الحالة وتغييرها
    final languageCubit = context.watch<LanguageCubit>();
    final currentLang = languageCubit.state.languageCode;

    return Drawer(
      child: Column(
        children: [
          // رأس القائمة (Header)
          // استهلاك بيانات المستخدم من الكيوبت
          NameAndEmail(),
          // زر تغيير اللغة
          ListTile(
            leading: const Icon(Icons.language, color: AppColor.primaryColor),
            title: Text(t.changeLanguage ?? "تغيير اللغة"),
            // إظهار اللغة الحالية في جهة الـ Trailing
            trailing: Text(
              currentLang == 'en' ? 'English' : 'العربية',
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            onTap: () {
              // استدعاء دالة التبديل من الكيوبت
              languageCubit.toggleLanguage();

              // اختياري: إغلاق الـ Drawer بعد تغيير اللغة
              Navigator.pop(context);
            },
          ),

          // زر تغيير الثيم (شكلياً)
         BlocBuilder<ThemeCubit, AppThemeMode>(
  builder: (context, themeMode) {
    final isDark = themeMode == AppThemeMode.dark;
    final themeText = isDark
        ? ( currentLang == 'ar' ? 'الوضع الليلي' : 'Dark Mode')
        : ( currentLang == 'ar' ? 'الوضع النهاري' : 'Light Mode');
    return ListTile(
      leading: Icon(
        isDark ? Icons.dark_mode : Icons.light_mode,
        color: AppColor.primaryColor,
      ),
      title: Text(
        themeText,
      ),
      trailing: Switch(
        value: isDark,
        onChanged: (value) {
          context.read<ThemeCubit>().toggleTheme(value);
        },
      ),
    );
  },
),


          const Spacer(),
          const Divider(),

          // زر تسجيل الخروج
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: Text(
              t.logout,
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              getit<CacheHelper>().saveData(key: "LoggedIn", value: false);
              CacheHelper.deleteSecureData(key: "accessToken");
              GoRouter.of(context).pushReplacement(AppRouter.loginView);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
