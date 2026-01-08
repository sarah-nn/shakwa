import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shakwa/Controllers/language_cubit.dart';
import 'package:shakwa/Core/app_routes.dart';
import 'package:shakwa/Core/service_locator.dart';
import 'package:shakwa/fcm_config.dart';
import 'package:shakwa/firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final languageCubit = LanguageCubit();
  await languageCubit.loadSavedLanguage();
  await setUpAppService();
  // تهيئة Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // تهيئة API الإشعارات
  await FirebaseApi().initNotifications();
  runApp(BlocProvider.value(value: languageCubit, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, locale) {
        return MaterialApp.router(
          locale: locale,

          theme: ThemeData(fontFamily: "Cairo"),
          supportedLocales: const [Locale('ar', ''), Locale('en', '')],
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
  }
}
