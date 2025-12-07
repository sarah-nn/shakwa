import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa/Controllers/complaint_details/complaint_details_cubit.dart';
import 'package:shakwa/Data/Models/complaint_model.dart';
import 'complaint_header.dart';
import 'complaint_bottom_row.dart';
import 'complaint_details_section.dart';

class ComplaintCard extends StatefulWidget {
  final ComplaintModel complaint;
  final VoidCallback? onUpdated;

  const ComplaintCard({super.key, required this.complaint, this.onUpdated});

  @override
  State<ComplaintCard> createState() => _ComplaintCardState();
}

class _ComplaintCardState extends State<ComplaintCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final detailsCubit = context.read<ComplaintDetailsCubit>();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              /// HEADER
              GestureDetector(
                onTap: () {
                  setState(() => expanded = !expanded);

                  if (expanded) {
                    detailsCubit.getComplaintDetails(
                      complaint: widget.complaint.id,
                    );
                  }
                },
                child: ComplaintHeader(
                  complaint: widget.complaint,
                  expanded: expanded,
                ),
              ),

              /// DETAILS
              if (expanded)
                BlocBuilder<ComplaintDetailsCubit, ComplaintDetailsState>(
                  builder: (context, state) {
                    if (state is ComplaintDetailsLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(12),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (state is ComplaintDetailsSuccess) {
                      return ComplaintDetailsSection(
                        details: state.complaintDetailsModel,
                      );
                    }

                    return const SizedBox();
                  },
                ),

              const SizedBox(height: 12),
              const Divider(height: 0.8),
              const SizedBox(height: 8),

              /// BOTTOM ROW
              ComplaintBottomRow(complaint: widget.complaint),
            ],
          ),
        ),
      ),
    );
  }
}
