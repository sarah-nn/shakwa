import 'package:flutter/material.dart';
import 'package:shakwa/Data/Models/complaint_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ComplaintBottomRow extends StatelessWidget {
  final ComplaintModel complaint;

  const ComplaintBottomRow({super.key, required this.complaint});

  Color _statusColor(String status) {
    switch (status) {
      case 'منجزة':
        return Colors.green;
      case 'قيد المعالجة':
        return Colors.orange;
      case 'مرفوضة':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: Text(
            "${t.refNumber} : ${complaint.referenceNumber}",
            style: TextStyle(color: Colors.grey.shade700),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _statusColor(complaint.status).withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            complaint.status,
            style: TextStyle(
              color: _statusColor(complaint.status),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
