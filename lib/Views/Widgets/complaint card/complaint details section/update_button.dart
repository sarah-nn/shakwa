import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shakwa/Controllers/complaint_details/complaint_details_cubit.dart';
import 'package:shakwa/Core/Constants/route_constant.dart';
import 'package:shakwa/Data/Models/complaint_details_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateButton extends StatelessWidget {
  const UpdateButton({super.key, required this.details});

  final ComplaintDetailsModel details;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red.withOpacity(0.1), // خلفية حمراء خفيفة
        elevation: 0, // بدون ظل
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // زوايا دائرية
        ),
      ),
      onPressed: () async {
        final result = await GoRouter.of(
          context,
        ).push(AppRouter.updateComplaints, extra: details);
        if (result == true) {
          context.read<ComplaintDetailsCubit>().getComplaintDetails(
            complaint: details.id,
          );
        }
      },
      child: Text(
        t.complaintEdit,
        style: TextStyle(
          color: Colors.red, // النص باللون الأحمر
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
