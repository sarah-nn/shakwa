// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shakwa/Controllers/complaint_details/complaint_details_cubit.dart';
// import 'package:shakwa/Core/Constants/app_color.dart';
// import 'package:shakwa/Data/Models/complaint_details_model.dart';
// import 'package:shakwa/Views/Widgets/extra_request_dialog.dart';
// import 'notes_dialog.dart';

// class ComplaintDetailsSection extends StatelessWidget {
//   final ComplaintDetailsModel details;

//   const ComplaintDetailsSection({super.key, required this.details});

//   @override
//   Widget build(BuildContext context) {
//     final List<String> imageUrls =
//         details.attachments.map((e) => e.filePath).toList();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 8),
//         const Text('الوصف:', style: TextStyle(fontWeight: FontWeight.bold)),
//         const SizedBox(height: 6),
//         Text(details.description),

//         const SizedBox(height: 12),

//         const Text(
//           'موقع الشكوى:',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 6),

//         Row(
//           children: [
//             const Icon(Icons.location_on, size: 18, color: Colors.redAccent),
//             const SizedBox(width: 6),
//             Expanded(child: Text(details.location)),
//           ],
//         ),

//         const SizedBox(height: 12),

//         // ====================== الصور =======================
//         if (imageUrls.isNotEmpty) ...[
//           const Text(
//             'المرفقات (الصور):',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),

//           _buildImagesGrid(context, imageUrls),

//           const SizedBox(height: 12),
//         ],

//         // ====================== ملاحظات الجهة ======================
//         if (details.employeeNotes.isNotEmpty)
//           Align(
//             alignment: Alignment.centerRight,
//             child: TextButton.icon(
//               onPressed: () => showNotesDialog(context, details.employeeNotes),
//               icon: const Icon(Icons.sticky_note_2, color: AppColor.primaryColor),
//               label: const Text(
//                 'عرض ملاحظات الجهة',
//                 style: TextStyle(color: AppColor.primaryColor),
//               ),
//             ),
//           ),

//         // ====================== طلبات المعلومات ======================
//         if (details.requestsAndReplies.isNotEmpty)
//           Align(
//             alignment: Alignment.centerRight,
//             child: TextButton.icon(
//              onPressed: () => showExtraRequestDialog(
//   context: context,
//   complaintId: details.id,
//   cubit: context.read<ComplaintDetailsCubit>(),
// ),

//               icon: const Icon(Icons.info_outline, color: AppColor.primaryColor),
//               label: const Text(
//                 'طلب معلومات إضافية',
//                 style: TextStyle(color: AppColor.primaryColor),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
//   Widget _buildImagesGrid(BuildContext context, List<String> images) {
//   return SizedBox(
//     height: 100,
//     child: ListView.separated(
//       scrollDirection: Axis.horizontal,
//       itemCount: images.length,
//       separatorBuilder: (_, __) => const SizedBox(width: 8),
//       itemBuilder: (context, i) {
//         final img = images[i];

//         return GestureDetector(
//           onTap: () => _openImageViewer(context, i, images),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Image.network(
//               img,
//               width: 100,
//               height: 100,
//               fit: BoxFit.cover,
//               errorBuilder: (_, err, __) => Container(
//                 width: 100,
//                 height: 100,
//                 color: Colors.grey.shade200,
//                 alignment: Alignment.center,
//                 child: Text(
//                   img.split('/').last,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.grey.shade700),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     ),
//   );
// }
// void _openImageViewer(
//   BuildContext context,
//   int startIndex,
//   List<String> images,
// ) {
//   final controller = PageController(initialPage: startIndex);
//   int current = startIndex;

//   showDialog(
//     context: context,
//     builder: (context) {
//       return StatefulBuilder(builder: (context, setState) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(14),
//           ),
//           insetPadding:
//               const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
//           child: SizedBox(
//             height: MediaQuery.of(context).size.height * 0.70,
//             child: Column(
//               children: [
//                 // Header
//                 Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const [
//                       CloseButton(),
//                       Text(
//                         "المرفقات",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(width: 40),
//                     ],
//                   ),
//                 ),

//                 // Photos
//                 Expanded(
//                   child: PageView.builder(
//                     controller: controller,
//                     itemCount: images.length,
//                     onPageChanged: (i) => setState(() => current = i),
//                     itemBuilder: (context, index) {
//                       return InteractiveViewer(
//                         child: Image.network(
//                           images[index],
//                           fit: BoxFit.contain,
//                         ),
//                       );
//                     },
//                   ),
//                 ),

//                 const SizedBox(height: 12),

//                 // Indicators
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(
//                     images.length,
//                     (i) => AnimatedContainer(
//                       duration: const Duration(milliseconds: 250),
//                       margin: const EdgeInsets.symmetric(horizontal: 4),
//                       width: current == i ? 12 : 8,
//                       height: current == i ? 12 : 8,
//                       decoration: BoxDecoration(
//                         color: current == i
//                             ? AppColor.primaryColor
//                             : Colors.grey.shade400,
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 12),
//               ],
//             ),
//           ),
//         );
//       });
//     },
//   );
// }

// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shakwa/Core/Constants/route_constant.dart';
import 'package:shakwa/Data/Models/complaint_details_model.dart';
import 'package:shakwa/Views/Widgets/complaint%20card/complaint%20details%20section/complaint_image_attachments.dart';
import 'package:shakwa/Views/Widgets/complaint%20card/complaint%20details%20section/update_button.dart';
import 'employee_notes_button.dart';
import 'extra_request_button.dart';

class ComplaintDetailsSection extends StatelessWidget {
  final ComplaintDetailsModel details;

  const ComplaintDetailsSection({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls =
        details.attachments.map((e) => e.filePath).toList();

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
        ComplaintImageAttachments(imageUrls: imageUrls),

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
