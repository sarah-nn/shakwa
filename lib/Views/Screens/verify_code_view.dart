import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:shakwa/Views/Widgets/custom_appBar.dart';

class VerifyCodeView extends StatelessWidget {
  const VerifyCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("تأكيد الحساب"),
      body: Padding(
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
            OtpTextField(
              numberOfFields: 5,
              borderColor: AppColor.primaryColor,
              focusedBorderColor: Colors.yellowAccent.shade700,
              showFieldAsBox: true,
              fieldWidth: 50,
              borderRadius: BorderRadius.circular(8),
              borderWidth: 4,
              onSubmit: (code) {
                print("OTP هو: $code");
              },
            ),
          ],
        ),
      ),
    );
  }
}
