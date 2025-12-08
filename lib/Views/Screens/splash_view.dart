import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:shakwa/Core/Constants/route_constant.dart';
import 'package:shakwa/Core/cache_helper.dart';
import 'package:shakwa/Core/service_locator.dart';
import 'package:shakwa/Views/Widgets/custom_button.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = getit<CacheHelper>().getData(key: "LoggedIn") ?? false;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColor.primaryColor.withOpacity(0.12),
              AppColor.fillTextField,
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.support_agent,
                size: 110,
                color: AppColor.primaryColor,
              ),
              const SizedBox(height: 25),
              Text(
                "بوابة موحدة لتقديم الشكاوي الحكومية وتتبعها",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryColor,
                  fontSize: 23,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 40),
              CustomButton(
                text: "ابدأ الآن",

                onTap: () {
                  isLoggedIn
                      ? GoRouter.of(context).pushReplacement(AppRouter.homePage)
                      : GoRouter.of(
                        context,
                      ).pushReplacement(AppRouter.loginView);
                },
              ),
              const SizedBox(height: 15),

              Text(
                "نحن هنا لخدمتك",
                style: TextStyle(
                  color: AppColor.primaryColor.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
