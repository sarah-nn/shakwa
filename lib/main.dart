import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shakwa/Controllers/language_cubit.dart';
import 'package:shakwa/Controllers/theme/theme_cubit.dart';
import 'package:shakwa/Controllers/theme/theme_state.dart';
import 'package:shakwa/Core/app_routes.dart';
import 'package:shakwa/Core/service_locator.dart';
import 'package:shakwa/fcm_config.dart';
import 'package:shakwa/firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shakwa/theme/app_theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final languageCubit = LanguageCubit();
  await languageCubit.loadSavedLanguage();
  await setUpAppService();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseApi().initNotifications();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: languageCubit),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, locale) {
        return BlocBuilder<ThemeCubit, AppThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp.router(
              locale: locale,

              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode == AppThemeMode.dark
                  ? ThemeMode.dark
                  : ThemeMode.light,

              supportedLocales: const [
                Locale('ar', ''),
                Locale('en', ''),
              ],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
              routerConfig: Routing.router,
            );
          },
        );
      },
    );
  }
}

