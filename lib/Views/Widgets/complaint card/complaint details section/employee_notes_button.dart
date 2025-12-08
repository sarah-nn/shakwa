import 'package:flutter/material.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:shakwa/Data/Models/complaint_details_model.dart';
import 'employee_notes_dialog.dart';

class EmployeeNotesButton extends StatelessWidget {
  final List<Comment> employeeNotes;

  const EmployeeNotesButton({super.key, required this.employeeNotes});

  @override
  Widget build(BuildContext context) {
    if (employeeNotes.isEmpty) {
      return const SizedBox.shrink();
    }

    return Align(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        onPressed: () => showNotesDialog(context, employeeNotes),
        icon: const Icon(Icons.sticky_note_2, color: AppColor.primaryColor),
        label: const Text(
          'عرض ملاحظات الجهة',
          style: TextStyle(color: AppColor.primaryColor),
        ),
      ),
    );
  }
}
