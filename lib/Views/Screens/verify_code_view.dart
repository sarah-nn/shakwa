import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:shakwa/Controllers/auth/auth_cubit.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:shakwa/Core/Constants/route_constant.dart';
import 'package:shakwa/Core/cache_helper.dart';
import 'package:shakwa/Views/Widgets/custom_appBar.dart';

class VerifyCodeView extends StatelessWidget {
  VerifyCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: CacheHelper.getSecureData(key: "email"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData ||
            snapshot.data == null) {
          // يمكن هنا إعادة التوجيه في حالة عدم وجود بيانات (إنهاء مرحلة الـ build)
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final email = snapshot.data!;

        return Scaffold(
          appBar: customAppBar("تأكيد الحساب"),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              // ✅ استخدام BlocListener لإدارة الانتقال بين الصفحات
              child: BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  // يتم تشغيل هذا الكود بعد اكتمال مرحلة الـ build
                  if (state is AuthSuccess) {
                    // الانتقال إلى الصفحة الرئيسية عند النجاح
                    GoRouter.of(context).pushReplacement(AppRouter.homePage);
                  }
                  // يمكنك أيضاً التعامل مع AuthFail هنا لعرض SnackBar أو Dialog
                },
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    final cubit = AuthCubit.get(context);

                    // إزالة شرط AuthSuccess من هنا!

                    if (state is AuthLoading) {
                      return Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 2,
                        ),
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (state is AuthFail) {
                      // يمكنك تحسين عرض رسالة الخطأ هنا
                      return Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.2,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "الرمز غير صحيح ! حاول مجدداً",

                              style: const TextStyle(
                                color: Colors.red,
                                height: 5,
                              ),
                            ),
                            const SizedBox(height: 10),
                            // إظهار حقول OTP مجدداً بعد الخطأ
                            _buildOtpFields(context, cubit, email),
                          ],
                        ),
                      );
                    }

                    // الحالة الافتراضية (بعد التحميل أو عند الحاجة لإدخال الكود)
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        const Text(
                          "يرجى إدخال رمز التحقق الذي تم إرساله إلى بريدك الالكتروني",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor,
                            fontSize: 20,
                            height: 1.7,
                          ),
                        ),
                        const SizedBox(height: 40),
                        _buildOtpFields(context, cubit, email),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // دالة مساعدة لتقليل التكرار وبناء حقول OTP
  Widget _buildOtpFields(BuildContext context, AuthCubit cubit, String email) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: OtpTextField(
        numberOfFields: 6,
        borderColor: AppColor.primaryColor,
        focusedBorderColor: Colors.yellowAccent.shade700,
        showFieldAsBox: true,
        fieldWidth: 45,
        borderRadius: BorderRadius.circular(8),
        borderWidth: 4,
        keyboardType: TextInputType.number,
        onSubmit: (code) {
          print("OTP هو: $code  \nemail : $email}");
          cubit.verify(email, code);
        },
      ),
    );
  }
}
