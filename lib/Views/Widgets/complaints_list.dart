import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa/Controllers/compainte/complaint_cubit.dart';
import 'package:shakwa/Controllers/complaint_details/complaint_details_cubit.dart';
import 'package:shakwa/Core/Network/Api/dio_consumer.dart';
import 'package:shakwa/Data/Repos/show_complain_repo.dart';
import 'package:shakwa/Views/Widgets/complaints_card.dart';

class ComplaintsList extends StatefulWidget {
  const ComplaintsList({super.key});

  @override
  State<ComplaintsList> createState() => _ComplaintsListState();
}

class _ComplaintsListState extends State<ComplaintsList> {
  @override
  void initState() {
    super.initState();
    context.read<ComplaintCubit>().getComplaint();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplaintCubit, ComplaintState>(
      builder: (context, state) {
         if (state is ComplaintSuccess) {
          final complaints = state.complaintModel;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
            itemCount: complaints.length,
            itemBuilder: (context, index) {
              return BlocProvider(
                create:
                    (context) => ComplaintDetailsCubit(
                      showComplaintRepo: ShowComplaintRepo(DioConsumer(Dio())),
                    ),
                child: ComplaintCard(complaint: complaints[index]),
              );
            },
          );
        } else if (state is CompliantFailure) {
          return Center(child: Text(state.errMsg));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
