import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shakwa/Controllers/compainte/complaint_cubit.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:shakwa/Core/Constants/route_constant.dart';
import 'package:shakwa/Views/Widgets/complaint%20card/complaint_list_builder.dart';
import 'package:shakwa/Views/Widgets/custom_drawer.dart';
import 'package:shakwa/Views/Widgets/floating_action_button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: Text(t.complaintTitle),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: "Cairo",
        ),
        backgroundColor: AppColor.primaryColor,
        actions: [
          IconButton(
            onPressed: () => GoRouter.of(context).push(AppRouter.notiPage),
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const ComplaintListBuilder(),
      floatingActionButton: const FloatingActionButtonWidget(),
    );
  }
}
