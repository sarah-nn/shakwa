import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:shakwa/Core/Constants/route_constant.dart';
import 'package:shakwa/Views/Widgets/complaints_list.dart';

class AllComplaintsView extends StatelessWidget {
  const AllComplaintsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الشكاوي المقدمة"),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: "Cairo"
        ),
        backgroundColor: AppColor.primaryColor,

        leading: GestureDetector(
          onTap: () {
            GoRouter.of(context).push(AppRouter.notiPage);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(Icons.notifications, color: Colors.white, size: 28),
          ),
        ),
      ),
      body: ComplientsList(),
      backgroundColor: AppColor.secondColor,
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.only(right: 40),
          child: FloatingActionButton(
            onPressed: () {
              print('FAB pressed: Add New Complaint');
                          GoRouter.of(context).push(AppRouter.addComplaintView);

            },
            backgroundColor: AppColor.primaryColor,
            shape: const CircleBorder(), // لضمان شكل دائري مثالي
            child: const Icon(Icons.add, color: Colors.white, size: 30),
          ),
        ),
      ),
    );
  }
}
