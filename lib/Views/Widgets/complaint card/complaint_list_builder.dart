import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa/Controllers/compainte/complaint_cubit.dart';
import 'package:shakwa/Controllers/complaint_details/complaint_details_cubit.dart';
import 'package:shakwa/Core/Network/Api/dio_consumer.dart';
import 'package:shakwa/Data/Models/complaint_model.dart';
import 'package:shakwa/Data/Repos/show_complain_repo.dart';
import 'package:shakwa/Views/Widgets/complaint%20card/complaints_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ComplaintListBuilder extends StatefulWidget {
  const ComplaintListBuilder({super.key});

  @override
  State<ComplaintListBuilder> createState() => _ComplaintListBuilderState();
}

class _ComplaintListBuilderState extends State<ComplaintListBuilder> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ComplaintCubit>().getComplaint(isInitial: true);

    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final cubit = context.read<ComplaintCubit>();
    final state = cubit.state;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      if (state is ComplaintSuccess && state.hasMore) {
        if (cubit.state is! ComplaintPaginationLoading) {
          cubit.getComplaint();
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return BlocBuilder<ComplaintCubit, ComplaintState>(
      builder: (context, state) {
        List<ComplaintModel> complaints = [];
        bool isLoadingInitial = state is ComplaintLoading;
        bool isLoadingPagination = false;
        bool hasMore = true;

        if (state is ComplaintSuccess) {
          complaints = state.allComplaints;
          hasMore = state.hasMore;
        } else if (state is ComplaintPaginationLoading) {
          complaints = state.oldComplaints;
          isLoadingPagination = true;
        } else if (state is CompliantFailure) {
          return Center(child: Text(state.errMsg));
        }

        if (isLoadingInitial && complaints.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return complaints.isEmpty
            ? Container(child: Center(child: Text(t.noComplaint)))
            : ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
              itemCount: complaints.length + (isLoadingPagination ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == complaints.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Center(
                      child:
                          hasMore
                              ? const CircularProgressIndicator()
                              : const Text("لا يوجد شكاوى أخرى"),
                    ),
                  );
                }

                return BlocProvider(
                  create:
                      (context) => ComplaintDetailsCubit(
                        showComplaintRepo: ShowComplaintRepo(
                          DioConsumer(Dio()),
                        ),
                      ),
                  child: ComplaintCard(complaint: complaints[index]),
                );
              },
            );
      },
    );
  }
}
