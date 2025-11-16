import 'package:go_router/go_router.dart';
import 'package:shakwa/Core/Constants/route_constant.dart';
import 'package:shakwa/Views/Screens/all_complaints_view.dart';
import 'package:shakwa/Views/Screens/notification_view.dart';
import 'package:shakwa/main.dart';

abstract class Routing {
  static final router = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const AllComplaintsView(),
      ),
      GoRoute(
        path: AppRouter.notiPage,
        builder: (context, state) => const NotificationView(),
      ),
    ],
  );
}
