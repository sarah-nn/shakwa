import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shakwa/Controllers/compainte/complaint_cubit.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:shakwa/Core/Constants/route_constant.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 40),
        child: FloatingActionButton(
          onPressed: () async {
            final result = await GoRouter.of(
              context,
            ).push(AppRouter.addComplaintView);
            // التأكد من أن السياق (context) ما زال متاحاً وأن النتيجة نجاح
            if (result == true && context.mounted) {
              // نمرر isRefresh لإعادة تحميل الصفحة الأولى ومسح القديم
              context.read<ComplaintCubit>().getComplaint(isRefresh: true);
            }
          },
          backgroundColor: AppColor.primaryColor,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
    );
  }
}
