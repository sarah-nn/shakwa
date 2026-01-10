import 'package:flutter/material.dart';
import 'package:shakwa/Controllers/complaint_details/complaint_details_cubit.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:shakwa/Data/Models/complaint_details_model.dart';

class ExtraRequestInput extends StatelessWidget {
  final int complaintId;
  final ComplaintDetailsCubit cubit;
  final TextEditingController controller;

  const ExtraRequestInput({
    super.key,
    required this.complaintId,
    required this.cubit,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "اكتب ردك...",
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(12),
                //   borderSide: BorderSide.none,
                // ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 25,
            backgroundColor:Theme.of(context).colorScheme.primary,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                final text = controller.text.trim();
                if (text.isEmpty) return;

                cubit.addLocalReply(
                  Comment(
                    text: text,
                    user: User(role: "user", id: complaintId, fullName: ''),
                    complaintType: "reply",
                    createdAt: DateTime.now().toString(),
                    id: complaintId,
                  ),
                );

                cubit.sendReply(complaintId: complaintId, text: text);

                controller.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
