// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:shakwa/Core/Constants/app_color.dart';
// import 'package:shakwa/Core/Constants/route_constant.dart';
// import 'package:shakwa/Views/Widgets/custom_button.dart';

// class SplashView extends StatelessWidget {
//   const SplashView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.fillTextField,
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "بوابة موحدة لتقديم الشكاوي الحكومية و تتبعها ",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: AppColor.primaryColor,
//                 fontSize: 20,
//               ),
//             ),
//             CustomButton(
//               text: 'ابدأ الان',
//               onTap: () {
//                 GoRouter.of(context).pushReplacement(AppRouter.loginView);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:shakwa/Core/Constants/route_constant.dart';
import 'package:shakwa/Views/Widgets/custom_button.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColor.primaryColor.withOpacity(0.12),
              AppColor.fillTextField.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// --- Icon or Logo ---
              AnimatedContainer(
                duration: Duration(milliseconds: 800),
                curve: Curves.easeOut,
                child: Icon(
                  Icons.support_agent,
                  size: 110,
                  color: AppColor.primaryColor,
                ),
              ),

              const SizedBox(height: 25),

              /// --- App Title ---
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

              /// --- Start Button ---
              CustomButton(
                text: "ابدأ الآن",

                onTap: () {
                  GoRouter.of(context).pushReplacement(AppRouter.loginView);
                },
              ),

              const SizedBox(height: 15),

              /// Optional subtle text
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
