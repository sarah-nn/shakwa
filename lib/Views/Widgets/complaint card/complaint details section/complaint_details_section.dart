

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shakwa/Core/Constants/route_constant.dart';
import 'package:shakwa/Data/Models/complaint_details_model.dart';
import 'package:shakwa/Views/Widgets/complaint%20card/complaint%20details%20section/complaint_file_attachment.dart';
import 'package:shakwa/Views/Widgets/complaint%20card/complaint%20details%20section/complaint_image_attachments.dart';
import 'package:shakwa/Views/Widgets/complaint%20card/complaint%20details%20section/update_button.dart';
import 'employee_notes_button.dart';
import 'extra_request_button.dart';

class ComplaintDetailsSection extends StatelessWidget {
  final ComplaintDetailsModel details;

  const ComplaintDetailsSection({super.key, required this.details});

 bool _isImage(String type) {
    return ['jpg', 'jpeg', 'png', 'webp'].contains(type.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {

 final imageAttachments =
        details.attachments.where((e) => _isImage(e.fileType)).toList();

    final fileAttachments =
        details.attachments.where((e) => !_isImage(e.fileType)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),

        // ====================== الوصف =======================
        const Text('الوصف:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Text(details.description),
        const SizedBox(height: 12),

        // ====================== الموقع =======================
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

        // ====================== المرفقات (الصور) =======================
          ComplaintImageAttachments(
            imageUrls:
                imageAttachments.map((e) => e.filePath).toList(),
          ),
        // ====================== الملفات ======================
        if (fileAttachments.isNotEmpty)
          ComplaintFileAttachments(files: fileAttachments),
             // ====================== تعديل الشكوى ======================
        UpdateButton(details: details),
        // ====================== ملاحظات الجهة ======================
        EmployeeNotesButton(employeeNotes: details.employeeNotes),

        // ====================== طلبات المعلومات ======================
        ExtraRequestButton(
          complaintId: details.id,
          hasRequests: details.requestsAndReplies.isNotEmpty,
        ),
      ],
    );
  }
}
