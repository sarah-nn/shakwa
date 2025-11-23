import 'package:go_router/go_router.dart';
import 'package:shakwa/Core/Constants/route_constant.dart';
import 'package:shakwa/Views/Screens/add_complaint_view.dart';
import 'package:shakwa/Views/Screens/all_complaints_view.dart';
import 'package:shakwa/Views/Screens/login_view.dart';
import 'package:shakwa/Views/Screens/notification_view.dart';
import 'package:shakwa/Views/Screens/register_view.dart';
import 'package:shakwa/Views/Screens/splash_view.dart';
import 'package:shakwa/main.dart';

abstract class Routing {
  static final router = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const SplashView(),
      ),
       GoRoute(
        path: AppRouter.loginView,
        builder: (context, state) => const LoginView(),
      ),
       GoRoute(
        path: AppRouter.registerView,
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: AppRouter.notiPage,
        builder: (context, state) => const NotificationView(),
      ),
      GoRoute(
        path: AppRouter.addComplaintView,
        builder: (context, state) => const AddComplaintView(),
      ),
       GoRoute(
        path: AppRouter.homePage,
        builder: (context, state) => const AllComplaintsView(),
      ),
    ],
  );
}
