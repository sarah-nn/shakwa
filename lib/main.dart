import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shakwa/Core/app_routes.dart';
import 'package:shakwa/Core/service_locator.dart';
import 'package:shakwa/fcm_config.dart';
import 'package:shakwa/firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpAppService();
  // تهيئة Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // تهيئة API الإشعارات
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: const Locale('ar'),
      theme: ThemeData(fontFamily: "Cairo"),
      supportedLocales: const [Locale('ar', '')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      routerConfig: Routing.router,
    );
  }
}
