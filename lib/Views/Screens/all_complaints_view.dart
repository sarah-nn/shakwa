import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shakwa/Controllers/compainte/complaint_cubit.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:shakwa/Core/Constants/route_constant.dart';
import 'package:shakwa/Views/Widgets/complaint%20card/complaint_list_builder.dart';
import 'package:shakwa/Views/Widgets/floating_action_button_widget.dart';

class AllComplaintsView extends StatefulWidget {
  const AllComplaintsView({super.key});

  @override
  State<AllComplaintsView> createState() => _AllComplaintsViewState();
}

class _AllComplaintsViewState extends State<AllComplaintsView> {
  @override
  void initState() {
    super.initState();
    context.read<ComplaintCubit>().getComplaint();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الشكاوي المقدمة"),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: "Cairo",
        ),
        backgroundColor: AppColor.primaryColor,
        leading: GestureDetector(
          onTap: () {
            GoRouter.of(context).push(AppRouter.notiPage);
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(Icons.notifications, color: Colors.white, size: 28),
          ),
        ),
      ),
      body: const ComplaintListBuilder(),
      floatingActionButton: const FloatingActionButtonWidget(),
    );
  }
}
