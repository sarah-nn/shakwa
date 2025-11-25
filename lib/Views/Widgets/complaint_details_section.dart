import 'package:flutter/material.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:shakwa/Data/Models/complaint_details_model.dart';
import 'package:shakwa/Views/Widgets/extra_request_dialog.dart';
import 'notes_dialog.dart';

class ComplaintDetailsSection extends StatelessWidget {
  final ComplaintDetailsModel details;

  const ComplaintDetailsSection({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const Text('الوصف:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Text(details.description),

        const SizedBox(height: 12),

        const Text(
          'موقع الشكوى:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            const Icon(Icons.location_on, size: 18, color: Colors.redAccent),
            const SizedBox(width: 6),
            Expanded(child: Text(details.location)),
          ],
        ),

        const SizedBox(height: 12),

        if (details.employeeNotes.isNotEmpty)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {
                showNotesDialog(context, details.employeeNotes);
              },
              icon: const Icon(
                Icons.sticky_note_2,
                color: AppColor.primaryColor,
              ),
              label: const Text(
                'عرض ملاحظات الجهة',
                style: TextStyle(color: AppColor.primaryColor),
              ),
            ),
          ),

        if (details.requestsAndReplies.isNotEmpty)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed:
                  () => showExtraRequestDialog(
                    context,
                    details.requestsAndReplies,
                    details.id,
                  ),

              icon: const Icon(
                Icons.info_outline,
                color: AppColor.primaryColor,
              ),
              label: const Text(
                'طلب معلومات إضافية',
                style: TextStyle(color: AppColor.primaryColor),
              ),
            ),
          ),
      ],
    );
  }
}
