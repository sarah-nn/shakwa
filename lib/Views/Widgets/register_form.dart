import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shakwa/Core/Constants/route_constant.dart';
import 'package:shakwa/Core/function.dart';
import 'package:shakwa/Views/Widgets/custom_button.dart';
import 'package:shakwa/Views/Widgets/custom_text_button.dart';
import 'package:shakwa/Views/Widgets/custom_text_field.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          CustomTextField(
            baseText: "الاسم الكامل:",
            isPassword: false,
            hint: "ادخل اسمك الكامل",
            icon: Icons.person,
            // controller: cubit.codeController,
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
            // controller: cubit.codeController,
            keyboardType: TextInputType.text,
            validator: (val) {
              return validInput(val!, 8, 8, "password");
            },
          ),
          CustomTextField(
            baseText: "كلمة المرور:",
            isPassword: true,
            passToggle: true,
            hint: "ادخل كلمة المرور",
            // controller: cubit.passWordController,
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
            // controller: cubit.passWordController,
            keyboardType: TextInputType.text,
            icon: Icons.lock_outline,
            validator: (val) {
              return validInput(val!, 8, 100, "password");
            },
          ),
          SizedBox(height: 15),
          CustomButton(
            text: "إنشاء حساب",
            onTap: () {
              GoRouter.of(context).push(AppRouter.homePage);
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
      ),
    );
  }
}
