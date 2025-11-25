import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shakwa/Controllers/compainte/complaint_cubit.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:shakwa/Core/Constants/route_constant.dart';
import 'package:shakwa/Core/Network/Api/dio_consumer.dart';
import 'package:shakwa/Data/Repos/show_complain_repo.dart';
import 'package:shakwa/Views/Widgets/complaints_list.dart';

class AllComplaintsView extends StatelessWidget {
  const AllComplaintsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFF3F5F8),
      appBar: AppBar(
        title: Text("الشكاوي المقدمة"),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: "Cairo",
        ),
        backgroundColor: AppColor.primaryColor,

        leading: GestureDetector(
          onTap: () {
            GoRouter.of(context).push(AppRouter.notiPage);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(Icons.notifications, color: Colors.white, size: 28),
          ),
        ),
      ),
      body: BlocProvider(
        create:
            (context) => ComplaintCubit(
              showComplaintRepo: ShowComplaintRepo(DioConsumer(Dio())),
            ),
        child: ComplaintsList(),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.only(right: 40),
          child: FloatingActionButton(
            onPressed: () {
              GoRouter.of(context).push(AppRouter.addComplaintView);
            },
            backgroundColor: AppColor.primaryColor,
            shape: const CircleBorder(), // لضمان شكل دائري مثالي
            child: const Icon(Icons.add, color: Colors.white, size: 30),
          ),
        ),
      ),
    );
  }
}

// ----------------------- ComplaintCard Widget -----------------------
// class ComplaintCard extends StatefulWidget {
//   final ComplaintModel complaint;
//   final VoidCallback? onUpdated;

//   const ComplaintCard({super.key, required this.complaint, this.onUpdated});

//   @override
//   State<ComplaintCard> createState() => _ComplaintCardState();
// }

// class _ComplaintCardState extends State<ComplaintCard> {
//   bool expanded = false;

//   @override
//   Widget build(BuildContext context) {
//     final detailsCubit = context.read<ComplaintDetailsCubit>();

//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Card(
//         elevation: 3,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   setState(() => expanded = !expanded);

//                   if (expanded) {
//                     detailsCubit.getComplaintDetails(
//                       complaint: widget.complaint.id,
//                     );
//                   }
//                 },
//                 child: _buildHeader(
//                   widget.complaint,
//                   Icon(
//                     expanded
//                         ? Icons.keyboard_arrow_up
//                         : Icons.keyboard_arrow_down,
//                     color: Colors.grey.shade700,
//                     size: 28,
//                   ),
//                 ),
//               ),

//               if (expanded)
//                 BlocBuilder<ComplaintDetailsCubit, ComplaintDetailsState>(
//                   builder: (context, state) {
//                     if (state is ComplaintDetailsLoading) {
//                       return const Padding(
//                         padding: EdgeInsets.all(12),
//                         child: CircularProgressIndicator(),
//                       );
//                     }

//                     if (state is ComplaintDetailsSuccess) {
//                       return _buildDetailsSection(
//                         context,
//                         state.complaintDetailsModel,
//                       );
//                     }

//                     if (state is ComplaintDetailsFailure) {
//                       return const Padding(
//                         padding: EdgeInsets.all(12),
//                         child: Text("خطأ في تحميل التفاصيل"),
//                       );
//                     }

//                     return const SizedBox();
//                   },
//                 ),

//               const SizedBox(height: 12),
//               const Divider(height: 0.8, thickness: 0.7),
//               const SizedBox(height: 8),

//               _buildBottomRow(widget.complaint),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget _buildHeader(ComplaintModel complaint, Icon icon) {
//   return Row(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Expanded(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               complaint.complaintType.name,
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             const SizedBox(height: 6),
//             Text(complaint.description, style: const TextStyle(fontSize: 14)),
//           ],
//         ),
//       ),
//       const SizedBox(width: 8),
//       // سهم التوسيع
//       icon,
//     ],
//   );
// }

// Widget _buildDetailsSection(
//   BuildContext context,
//   ComplaintDetailsModel compDet,
// ) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       // الوصف
//       const SizedBox(height: 8),
//       const Text('الوصف:', style: TextStyle(fontWeight: FontWeight.bold)),
//       const SizedBox(height: 6),
//       Text(compDet.description),

//       const SizedBox(height: 12),

//       // الموقع
//       const Text('موقع الشكوى:', style: TextStyle(fontWeight: FontWeight.bold)),
//       const SizedBox(height: 6),
//       Row(
//         children: [
//           const Icon(Icons.location_on, size: 18, color: Colors.redAccent),
//           const SizedBox(width: 6),
//           Expanded(child: Text(compDet.location)),
//         ],
//       ),

      // const SizedBox(height: 12),

      // // المرفقات - الصور
      // if (widget.complaint..isNotEmpty) ...[
      //   const Text(
      //     'المرفقات (الصور):',
      //     style: TextStyle(fontWeight: FontWeight.bold),
      //   ),
      //   const SizedBox(height: 8),
      //   _buildImagesGrid(widget.complaint.images),
      //   const SizedBox(height: 10),
      // ],

//       // // المرفقات - ملفات
//       // if (widget.complaint.files.isNotEmpty) ...[
//       //   const Text(
//       //     'المرفقات (ملفات):',
//       //     style: TextStyle(fontWeight: FontWeight.bold),
//       //   ),
//       //   const SizedBox(height: 8),
//       //   _buildFilesRow(widget.complaint.files),
//       //   const SizedBox(height: 10),
//       // ],

//       // // ملاحظات الجهة (زر لعرض dialog)
      // if (compDet.employeeNotes.isNotEmpty) ...[
      //   Align(
      //     alignment: Alignment.centerRight,
      //     child: TextButton.icon(
      //       onPressed: () => _showNotesDialog(context, compDet.employeeNotes),
      //       icon: const Icon(Icons.sticky_note_2, color: AppColor.primaryColor),
      //       label: const Text(
      //         'عرض ملاحظات الجهة',
      //         style: TextStyle(color: AppColor.primaryColor),
      //       ),
      //     ),
      //   ),
      // ],

//       // طلب معلومات إضافية
      // if (widget.complaint.extraRequest != null) ...[
      //   Align(
      //     alignment: Alignment.centerRight,
      //     child: TextButton.icon(
      //       onPressed: () => _showExtraRequestDialog(context),
      //       icon: const Icon(
      //         Icons.info_outline,
      //         color: AppColor.primaryColor,
      //       ),
      //       label: const Text(
      //         'طلب معلومات إضافية',
      //         style: TextStyle(color: AppColor.primaryColor),
      //       ),
      //     ),
      //   ),
      // ],
//     ],
//   );
// }

// Widget _buildImagesGrid(List<String> images) {
//   // grid من مربعات صغيرة بجانب بعضها
//   return SizedBox(
//     height: 100,
//     child: GridView.builder(
//       scrollDirection: Axis.horizontal,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 1, // افقي: صف واحد من العناصر
//         mainAxisSpacing: 8,
//         childAspectRatio: 1,
//       ),
//       itemCount: images.length,
//       itemBuilder: (context, i) {
//         final img = images[i];
//         return GestureDetector(
//           onTap: () => _openImageViewer(i, images),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Center(
//               // محاكاة تحميل صورة من assets
//               child: Image.asset(
//                 img,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) {
//                   // لو الصورة مفقودة، نظهر placeholder مع اسم الملف
//                   return Container(
//                     color: Colors.grey.shade200,
//                     alignment: Alignment.center,
//                     child: Text(
//                       img.split('/').last,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: Colors.grey.shade700),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         );
//       },
//     ),
//   );
// }

// // Widget _buildFilesRow(List<String> files) {
// //   return SizedBox(
// //     height: 52,
// //     child: ListView.separated(
// //       scrollDirection: Axis.horizontal,
// //       itemCount: files.length,
// //       separatorBuilder: (_, __) => const SizedBox(width: 8),
// //       itemBuilder: (context, i) {
// //         final f = files[i];
// //         return GestureDetector(
// //           onTap: () => _openFileDialog(f),
// //           child: Container(
// //             padding: const EdgeInsets.symmetric(horizontal: 12),
// //             decoration: BoxDecoration(
// //               color: Colors.grey.shade200,
// //               borderRadius: BorderRadius.circular(10),
// //               border: Border.all(color: AppColor.primaryColor, width: 0.3),
// //             ),
// //             child: Row(
// //               children: [
// //                 const Icon(Icons.picture_as_pdf, color: Colors.red),
// //                 const SizedBox(width: 8),
// //                 Text(f),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     ),
// //   );
// // }

// Widget _buildBottomRow(ComplaintModel complaint) {
//   return Row(
//     children: [
//       // الرقم المرجعي على اليمين (بسبب RTL)
//       Expanded(
//         child: Text(
//           'الرقم المرجعي: ${complaint.referenceNumber}',
//           style: TextStyle(color: Colors.grey.shade700),
//         ),
//       ),

//       // حالة الشكوى كـ capsule
//       Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//         decoration: BoxDecoration(
//           color: _statusColor(complaint.status).withOpacity(0.12),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Text(
//           complaint.status,
//           style: TextStyle(
//             color: _statusColor(complaint.status),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     ],
//   );
// }

// Color _statusColor(String status) {
//   switch (status) {
//     case 'منجزة':
//       return Colors.green;
//     case 'قيد المعالجة':
//       return Colors.orange;
//     case 'مرفوضة':
//       return Colors.red;
//     default:
//       return Colors.blueGrey;
//   }
// }

// // ---------------- Dialogs & Utilities ----------------

// // فتح عارض صور مع أزرار تنقل
// void _openImageViewer(int startIndex, List<String> images) {
//   final controller = PageController(initialPage: startIndex);
//   int current = startIndex;

//   showDialog(
//     context: context,
//     builder: (context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return Dialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(14),
//             ),
//             insetPadding: const EdgeInsets.symmetric(
//               horizontal: 12,
//               vertical: 24,
//             ),
//             child: SizedBox(
//               height: MediaQuery.of(context).size.height * 0.70,
//               child: Column(
//                 children: [
//                   // العنوان مع زر الإغلاق
//                   Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: const [
//                         CloseButton(),
//                         Text(
//                           "المرفقات",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(width: 40),
//                       ],
//                     ),
//                   ),

//                   // الصور
//                   Expanded(
//                     child: PageView.builder(
//                       controller: controller,
//                       itemCount: images.length,
//                       onPageChanged: (i) => setState(() => current = i),
//                       itemBuilder: (context, index) {
//                         return InteractiveViewer(
//                           child: Image.asset(
//                             images[index],
//                             fit: BoxFit.contain,
//                           ),
//                         );
//                       },
//                     ),
//                   ),

//                   const SizedBox(height: 12),

//                   // النقاط
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List.generate(
//                       images.length,
//                       (i) => AnimatedContainer(
//                         duration: const Duration(milliseconds: 250),
//                         margin: const EdgeInsets.symmetric(horizontal: 4),
//                         width: current == i ? 12 : 8,
//                         height: current == i ? 12 : 8,
//                         decoration: BoxDecoration(
//                           color:
//                               current == i
//                                   ? AppColor.primaryColor
//                                   : Colors.grey.shade400,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 12),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     },
//   );
// }

// // فتح dialog للملفات
// // void _openFileDialog(String filename) {
// //   showDialog(
// //     context: context,
// //     builder: (context) {
// //       return Dialog(
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(12),
// //         ),
// //         child: Container(
// //           padding: const EdgeInsets.all(14),
// //           width: 320,
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   IconButton(
// //                     icon: const Icon(Icons.close),
// //                     onPressed: () => Navigator.pop(context),
// //                   ),
// //                   const Text(
// //                     'عرض الملف',
// //                     style: TextStyle(
// //                       fontWeight: FontWeight.bold,
// //                       fontSize: 16,
// //                     ),
// //                   ),
// //                   const SizedBox(width: 40),
// //                 ],
// //               ),
// //               const SizedBox(height: 8),
// //               ListTile(
// //                 leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
// //                 title: Text(filename),
// //                 subtitle: const Text('اضغط لتحميل الملف (محاكاة)'),
// //                 onTap: () {
// //                   // هنا يمكنك ربط تنزيل حقيقي
// //                   Navigator.pop(context);
// //                   ScaffoldMessenger.of(context).showSnackBar(
// //                     SnackBar(content: Text('تم تحميل $filename (محاكاة)')),
// //                   );
// //                 },
// //               ),
// //               const SizedBox(height: 8),
// //             ],
// //           ),
// //         ),
// //       );
// //     },
// //   );
// // }

// // Dialog عرض الملاحظات (View only) - يوجد أيقون إغلاق فقط
// void _showNotesDialog(BuildContext context, List<Comment> notes) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return Dialog(
//         backgroundColor: Colors.grey.shade100,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: Container(
//           padding: const EdgeInsets.all(14),
//           height: MediaQuery.of(context).size.height * 0.55,
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.close, color: AppColor.primaryColor),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                   const Expanded(
//                     child: Text(
//                       'ملاحظات الجهة',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: AppColor.primaryColor,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 48),
//                 ],
//               ),

//               const SizedBox(height: 4),

//               Expanded(
//                 child: ListView.builder(
//                   itemCount: notes.length,
//                   itemBuilder: (context, index) {
//                     return Card(
//                       elevation: 1,
//                       margin: const EdgeInsets.symmetric(vertical: 6),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "${index + 1}. ",
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 15,
//                                 color: AppColor.primaryColor,
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 notes[index].text,
//                                 style: const TextStyle(
//                                   fontSize: 15,
//                                   height: 1.4,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

// // Dialog لطلب معلومات إضافية: يعرض الطلب + حقل reply مع سهم الإرسال + أيقونة لإضافة مرفقات
// void _showExtraRequestDialog(BuildContext context) {
//   final TextEditingController replyController = TextEditingController();

//   // قائمة الردود
//   final List<Map<String, dynamic>> replies = [
//     {"text": "هذا هو الطلب الأساسي من الجهة.", "isRequest": true},
//     {"text": "مرحبا، نحتاج مزيداً من الإيضاح.", "isRequest": false},
//   ];

//   showDialog(
//     context: context,
//     // barrierDismissible: false,
//     builder: (context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return Dialog(
//             backgroundColor: Colors.grey.shade100,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 14),
//               height: MediaQuery.of(context).size.height * 0.70, // 70%
//               child: Column(
//                 children: [
//                   // ------------------ HEADER ------------------ //
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 14),
//                     child: Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(
//                             Icons.close,
//                             color: AppColor.primaryColor,
//                           ),
//                           onPressed: () => Navigator.pop(context),
//                         ),
//                         const Expanded(
//                           child: Text(
//                             'طلب معلومات إضافية',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: AppColor.primaryColor,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 48),
//                       ],
//                     ),
//                   ),
//                   // ),

//                   // const Divider(height: 1),

//                   // ------------------ BODY (Scrollable) ------------------ //
//                   Expanded(
//                     child: ListView.builder(
//                       padding: const EdgeInsets.all(16),
//                       itemCount: replies.length,
//                       itemBuilder: (context, index) {
//                         final item = replies[index];
//                         final isRequest = item["isRequest"];

//                         return Align(
//                           // alignment:
//                           //     isRequest ? Alignment.centerLeft : Alignment.centerRight,
//                           child: Container(
//                             margin: const EdgeInsets.symmetric(vertical: 6),
//                             padding: const EdgeInsets.all(12),
//                             constraints: const BoxConstraints(maxWidth: 260),
//                             decoration: BoxDecoration(
//                               color:
//                                   isRequest
//                                       ? Colors.white
//                                       : Colors.green.shade50,
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Text(
//                               item["text"],
//                               style: const TextStyle(fontSize: 14),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),

//                   // ------------------ INPUT BAR (Fixed Bottom) ------------------ //
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 10,
//                       vertical: 8,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade100,
//                       borderRadius: const BorderRadius.vertical(
//                         bottom: Radius.circular(16),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         // زر المرفقات
//                         IconButton(
//                           onPressed: () {},
//                           icon: const Icon(Icons.attach_file),
//                         ),

//                         // حقل الإدخال
//                         Expanded(
//                           child: TextField(
//                             controller: replyController,
//                             decoration: InputDecoration(
//                               hintText: "اكتب ردك...",
//                               contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 12,
//                                 vertical: 10,
//                               ),
//                               filled: true,
//                               fillColor: Colors.white,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide.none,
//                               ),
//                             ),
//                           ),
//                         ),

//                         const SizedBox(width: 8),

//                         // زر إرسال
//                         CircleAvatar(
//                           radius: 22,
//                           backgroundColor: AppColor.primaryColor,
//                           child: IconButton(
//                             onPressed: () {
//                               if (replyController.text.trim().isEmpty) return;

//                               setState(() {
//                                 replies.add({
//                                   "text": replyController.text.trim(),
//                                   "isRequest": false,
//                                 });
//                               });

//                               replyController.clear();
//                             },
//                             icon: const Icon(Icons.send, color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     },
//   );
// }
