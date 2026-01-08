import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shakwa/Controllers/auth/auth_cubit.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:shakwa/Core/Constants/route_constant.dart';
import 'package:shakwa/Core/cache_helper.dart';
import 'package:shakwa/Core/function.dart';
import 'package:shakwa/Core/service_locator.dart';
import 'package:shakwa/Views/Widgets/custom_button.dart';
import 'package:shakwa/Views/Widgets/auth/custom_text_button.dart';
import 'package:shakwa/Views/Widgets/custom_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Form(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            GoRouter.of(context).push(AppRouter.homePage);
            getit<CacheHelper>().saveData(key: "LoggedIn", value: true);
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
                      child: const Text('ok'),
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
                baseText: " ${t.email}:",
                isPassword: false,
                hint: t.enterEmail,
                icon: Icons.email,
                controller: cubit.email,
                keyboardType: TextInputType.text,
                validator: (val) {
                  return validInput(val!, 8, 8, "password");
                },
              ),
              CustomTextField(
                baseText: " ${t.password}:",
                isPassword: true,
                // passToggle: true,
                hint: t.enterPassword,
                controller: cubit.password,
                keyboardType: TextInputType.text,
                icon: Icons.lock_outline,
                validator: (val) {
                  return validInput(val!, 8, 100, "password");
                },
              ),
              SizedBox(height: 15),
              state is AuthLoading
                  ? Center(
                    child: CircularProgressIndicator(
                      color: AppColor.primaryColor,
                    ),
                  )
                  : CustomButton(
                    text: t.login,
                    onTap: () {
                      cubit.signIn();
                    },
                  ),
              CustomTextButtomAuth(
                one: t.anotherAccount,
                tow: t.createAccount,
                onTap: () {
                  GoRouter.of(context).pushReplacement(AppRouter.registerView);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
