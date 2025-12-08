// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:shakwa/Controllers/compainte/complaint_cubit.dart';
// import 'package:shakwa/Controllers/complaint_details/complaint_details_cubit.dart';
// import 'package:shakwa/Core/Constants/app_color.dart';
// import 'package:shakwa/Core/Constants/route_constant.dart';
// import 'package:shakwa/Core/Network/Api/dio_consumer.dart';
// import 'package:shakwa/Data/Repos/show_complain_repo.dart';
// import 'package:shakwa/Views/Widgets/complaints_card.dart';

// class AllComplaintsView extends StatefulWidget {
//   const AllComplaintsView({super.key});

//   @override
//   State<AllComplaintsView> createState() => _AllComplaintsViewState();
// }

// class _AllComplaintsViewState extends State<AllComplaintsView> {
//    @override
//   void initState() {
//     super.initState();
//     context.read<ComplaintCubit>().getComplaint();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: const Color(0xFFF3F5F8),
//       appBar: AppBar(
//         title: Text("الشكاوي المقدمة"),
//         centerTitle: true,
//         titleTextStyle: TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//           fontSize: 20,
//           fontFamily: "Cairo",
//         ),
//         backgroundColor: AppColor.primaryColor,

//         leading: GestureDetector(
//           onTap: () {
//             GoRouter.of(context).push(AppRouter.notiPage);
//           },
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10.0),
//             child: Icon(Icons.notifications, color: Colors.white, size: 28),
//           ),
//         ),
//       ),
//       body:BlocBuilder<ComplaintCubit, ComplaintState>(
//       builder: (context, state) {
//          if (state is ComplaintSuccess) {
//           final complaints = state.complaintModel;
//           return ListView.builder(
//             padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
//             itemCount: complaints.length,
//             itemBuilder: (context, index) {
//               return BlocProvider(
//                 create:
//                     (context) => ComplaintDetailsCubit(
//                       showComplaintRepo: ShowComplaintRepo(DioConsumer(Dio())),
//                     ),
//                 child: ComplaintCard(complaint: complaints[index]),
//               );
//             },
//           );
//         } else if (state is CompliantFailure) {
//           return Center(child: Text(state.errMsg));
//         }
//         return const Center(child: CircularProgressIndicator());
//       },
//     ),
//       floatingActionButton: Align(
//         alignment: Alignment.bottomRight,
//         child: Padding(
//           padding: EdgeInsets.only(right: 40),
//           child: FloatingActionButton(
//            onPressed: () async {
//   final result = await GoRouter.of(context).push(AppRouter.addComplaintView);

//   if (result == true) {
//     context.read<ComplaintCubit>().getComplaint();
//   }
// },
//             backgroundColor: AppColor.primaryColor,
//             shape: const CircleBorder(), // لضمان شكل دائري مثالي
//             child: const Icon(Icons.add, color: Colors.white, size: 30),
//           ),
//         ),
//       ),
//     );
//   }
// }

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
