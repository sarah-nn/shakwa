import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa/Controllers/auth/auth_cubit.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:shakwa/Core/Network/Api/dio_consumer.dart';
import 'package:shakwa/Data/Repos/auth_repo.dart';
import 'package:shakwa/Views/Widgets/normal_appBar.dart';
import 'package:shakwa/Views/Widgets/register_form.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: NormalAppBar(text: "إنشاء حساب"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              "أنشئ حساباً جديداً لتقديم شكواك و متابعة تقدمها",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColor,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 50),
            BlocProvider(
              create:
                  (context) =>
                      AuthCubit(authRepo: AuthRepo(DioConsumer(Dio()))),
              child: RegisterForm(),
            ),
          ],
        ),
      ),
    );
  }
}
