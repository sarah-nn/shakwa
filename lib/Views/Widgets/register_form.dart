import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shakwa/Controllers/auth/auth_cubit.dart';
import 'package:shakwa/Core/Constants/route_constant.dart';
import 'package:shakwa/Core/function.dart';
import 'package:shakwa/Views/Widgets/custom_button.dart';
import 'package:shakwa/Views/Widgets/custom_text_button.dart';
import 'package:shakwa/Views/Widgets/custom_text_field.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    String email = '';
    return Form(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            GoRouter.of(context).push(AppRouter.homePage);
          }
          if (state is AuthFail) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text(state.errMssg),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        print('العملية مؤكدة!');
                        Navigator.of(context).pop();
                      },
                      child: const Text('تأكيد'),
                    ),
                  ],
                );
              },
            );
          }
        },
        builder: (context, state) {
          final cubit = AuthCubit.get(context);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              CustomTextField(
                baseText: "الاسم الكامل:",
                isPassword: false,
                hint: "ادخل اسمك الكامل",
                icon: Icons.person,
                controller: cubit.fullname,
                keyboardType: TextInputType.text,
                validator: (val) {
                  return validInput(val!, 8, 8, "password");
                },
              ),
              CustomTextField(
                baseText: " البريد الالكتروني:",
                isPassword: false,
                hint: "ادخل بريدك الالكتروني",
                icon: Icons.email,
                controller: cubit.email,
                keyboardType: TextInputType.text,
                validator: (val) {
                  return validInput(val!, 8, 8, "password");
                },
              ),
              CustomTextField(
                baseText: "كلمة المرور:",
                isPassword: true,
                hint: "ادخل كلمة المرور",
                controller: cubit.password,
                keyboardType: TextInputType.text,
                icon: Icons.lock_outline,
                validator: (val) {
                  return validInput(val!, 8, 100, "password");
                },
              ),
              CustomTextField(
                baseText: "تأكيد كلمة المرور:",
                isPassword: true,
                passToggle: true,
                hint: "أكد كلمة المرور",
                controller: cubit.rePassword,
                keyboardType: TextInputType.text,
                icon: Icons.lock_outline,
                validator: (val) {
                  return validInput(val!, 8, 100, "password");
                },
              ),
              SizedBox(height: 15),
              state is AuthLoading
                  ? CircularProgressIndicator()
                  : CustomButton(
                    text: "إنشاء حساب",
                    onTap: () {
                      cubit.signUp();
                    },
                  ),
              CustomTextButtomAuth(
                one: "هل لديك حساب ؟",
                tow: " تسجيل الدخول",
                onTap: () {
                  GoRouter.of(context).pushReplacement(AppRouter.loginView);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
