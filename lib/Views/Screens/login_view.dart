import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa/Controllers/auth/auth_cubit.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:shakwa/Core/Network/Api/dio_consumer.dart';
import 'package:shakwa/Data/Repos/auth_repo.dart';
import 'package:shakwa/Views/Widgets/auth/login_form.dart';
import 'package:shakwa/Views/Widgets/custom_appBar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(t.login),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              t.shakwa,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColor,
                fontSize: 40,
              ),
            ),
            SizedBox(height: 50),
            BlocProvider(
              create:
                  (context) =>
                      AuthCubit(authRepo: AuthRepo(DioConsumer(Dio()))),
              child: LoginForm(),
            ),
          ],
        ),
      ),
    );
  }
}
