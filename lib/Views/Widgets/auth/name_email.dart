import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa/Controllers/user/user_cubit.dart';
import 'package:shakwa/Core/Constants/app_color.dart';

class NameAndEmail extends StatelessWidget {
  const NameAndEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserSuccess) {
          return UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: AppColor.primaryColor),
            accountName: Text(
              state.user.fullName, // الاسم من الباكيند
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(state.user.email), // الإيميل من الباكيند
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: AppColor.primaryColor),
            ),
          );
        } else if (state is UserFailure) {
          return const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.redAccent),
            accountName: Text("خطأ في تحميل البيانات"),
            accountEmail: Text("يرجى المحاولة لاحقاً"),
            currentAccountPicture: CircleAvatar(child: Icon(Icons.error)),
          );
        } else {
          // حالة التحميل (Loading)
          return const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: AppColor.primaryColor),
            accountName: Text("جاري التحميل..."),
            accountEmail: Text("..."),
            currentAccountPicture: CircleAvatar(
              child: CircularProgressIndicator(color: AppColor.primaryColor),
            ),
          );
        }
      },
    );
  }
}
