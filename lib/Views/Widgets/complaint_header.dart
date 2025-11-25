import 'package:flutter/material.dart';
import 'package:shakwa/Data/Models/complaint_model.dart';

class ComplaintHeader extends StatelessWidget {
  final ComplaintModel complaint;
  final bool expanded;

  const ComplaintHeader({
    super.key,
    required this.complaint,
    required this.expanded,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                complaint.complaintType.name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 6),
              Text(complaint.description, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Icon(
          expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          size: 28,
          color: Colors.grey.shade700,
        ),
      ],
    );
  }
}
