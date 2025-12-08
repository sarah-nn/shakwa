import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa/Controllers/complaint_details/complaint_details_cubit.dart';
import 'package:shakwa/Data/Models/complaint_details_model.dart';

class ExtraRequestMessages extends StatelessWidget {
  final ComplaintDetailsCubit cubit;
  final ScrollController scrollController;

  const ExtraRequestMessages({
    super.key,
    required this.cubit,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplaintDetailsCubit, ComplaintDetailsState>(
      bloc: cubit,
      buildWhen:
          (prev, curr) =>
              curr is ComplaintRepliesUpdated ||
              curr is ComplaintDetailsSuccess,
      builder: (context, state) {
        List<Comment> replies = [];

        if (state is ComplaintDetailsSuccess) {
          replies = List.from(state.complaintDetailsModel.requestsAndReplies);
          cubit.currentReplies = List.from(replies);
        } else if (state is ComplaintRepliesUpdated) {
          replies = List.from(state.replies);
        } else {
          replies = List.from(cubit.currentReplies);
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          }
        });

        return ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          itemCount: replies.length,
          itemBuilder: (context, index) {
            final comment = replies[index];
            final bool isUser = comment.user.role == "user";

            return Align(
              alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(12),
                constraints: const BoxConstraints(maxWidth: 260),
                decoration: BoxDecoration(
                  color: isUser ? Colors.green.shade50 : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        isUser ? Colors.green.shade200 : Colors.grey.shade300,
                  ),
                ),
                child: Text(comment.text),
              ),
            );
          },
        );
      },
    );
  }
}
