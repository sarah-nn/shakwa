import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shakwa/Controllers/add_complaints/add_complaints_cubit.dart';
import 'package:shakwa/Controllers/auth/auth_cubit.dart';
import 'package:shakwa/Controllers/complaint_type/complaint_type_cubit.dart';
import 'package:shakwa/Controllers/govenment/govenment_cubit.dart';
import 'package:shakwa/Core/Constants/route_constant.dart';
import 'package:shakwa/Core/Network/Api/dio_consumer.dart';
import 'package:shakwa/Core/cache_helper.dart';
import 'package:shakwa/Data/Repos/add_complaints_repo.dart';
import 'package:shakwa/Data/Repos/auth_repo.dart';
import 'package:shakwa/Data/Repos/send_complaint_repo.dart';
import 'package:shakwa/Views/Screens/add_complaint_view.dart';
import 'package:shakwa/Views/Screens/all_complaints_view.dart';
import 'package:shakwa/Views/Screens/login_view.dart';
import 'package:shakwa/Views/Screens/notification_view.dart';
import 'package:shakwa/Views/Screens/register_view.dart';
import 'package:shakwa/Views/Screens/splash_view.dart';
import 'package:shakwa/Views/Screens/verify_code_view.dart';
import 'package:shakwa/main.dart';

abstract class Routing {
  static final router = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(path: "/", builder: (context, state) => const SplashView()),
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
        builder:
            (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create:
                      (context) => GovenmentCubit(
                        repo: AddComplaintsRepo(DioConsumer(Dio())),
                      ),
                ),
                BlocProvider(
                  create:
                      (context) => AddComplaintsCubit(
                        repo: SendComplaintRepo(DioConsumer(Dio())),
                      ),
                ),
                BlocProvider(
                  create:
                      (context) => ComplaintTypeCubit(
                        repo: AddComplaintsRepo(DioConsumer(Dio())),
                      ),
                ),
              ],
              child: AddComplaintView(),
            ),
      ),
      GoRoute(
        path: AppRouter.homePage,
        builder: (context, state) => const AllComplaintsView(),
      ),
      GoRoute(
        path: AppRouter.verifyCodeView,
        builder: (context, state) {
          return BlocProvider(
            create:
                (context) => AuthCubit(authRepo: AuthRepo(DioConsumer(Dio()))),
            child: VerifyCodeView(email: "sth"),
          );
        },
      ),
    ],
  );
}
