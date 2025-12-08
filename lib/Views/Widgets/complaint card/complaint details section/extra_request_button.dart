import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa/Controllers/complaint_details/complaint_details_cubit.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:shakwa/Views/Widgets/complaint%20card/complaint%20details%20section/extra_request_dialog.dart';

class ExtraRequestButton extends StatelessWidget {
  final int complaintId;
  final bool hasRequests;

  const ExtraRequestButton({
    super.key,
    required this.complaintId,
    required this.hasRequests,
  });

  @override
  Widget build(BuildContext context) {
    if (!hasRequests) {
      return const SizedBox.shrink();
    }
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        onPressed:
            () => showExtraRequestDialog(
              context: context,
              complaintId: complaintId,
              cubit: context.read<ComplaintDetailsCubit>(),
            ),
        icon: const Icon(Icons.info_outline, color: AppColor.primaryColor),
        label: const Text(
          'طلب معلومات إضافية',
          style: TextStyle(color: AppColor.primaryColor),
        ),
      ),
    );
  }
}
