import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:shakwa/Controllers/auth/auth_cubit.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:shakwa/Core/cache_helper.dart';
import 'package:shakwa/Views/Widgets/custom_appBar.dart';

class VerifyCodeView extends StatelessWidget {
  VerifyCodeView({super.key, required this.email});

  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("تأكيد الحساب"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Text(
                "يرجى إدخال رمز التحقق الذي تم إرساله إلى بريدك الالكتروني",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryColor,
                  fontSize: 20,
                  height: 1.7,
                ),
              ),
              SizedBox(height: 40),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final cubit = AuthCubit.get(context);
                  if (state is AuthLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is AuthFail) {
                    return Text(state.errMssg);
                  }
                  return OtpTextField(
                    numberOfFields: 6,
                    borderColor: AppColor.primaryColor,
                    focusedBorderColor: Colors.yellowAccent.shade700,
                    showFieldAsBox: true,
                    fieldWidth: 45,
                    borderRadius: BorderRadius.circular(8),
                    borderWidth: 4,
                    // 💡 الحل هنا: إضافة نوع لوحة المفاتيح
                    keyboardType: TextInputType.number,
                    onSubmit: (code) {
                      print("OTP هو: $code  \nemail : }");
                      //  cubit.verify(code, email);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
