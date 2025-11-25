import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa/Controllers/complaint_details/complaint_details_cubit.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:shakwa/Data/Models/complaint_details_model.dart';

// void showExtraRequestDialog(
//   BuildContext context,
//   List<Comment> data,
// ) {
//   final TextEditingController replyController = TextEditingController();

//   // تحويل البيانات إلى List<Map> مناسبة للعرض
//   final List<Map<String, dynamic>> replies = data.map((comment) {
//     return {
//       "text": comment.text,
//       "isRequest": comment.complaintType == "info_request", // طلب من الجهة
//       "senderRole": comment.user.role,
//       "date": comment.createdAt,
//     };
//   }).toList();

//   showDialog(
//     context: context,
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
//               height: MediaQuery.of(context).size.height * 0.70,
//               child: Column(
//                 children: [

//                   // ---------------- HEADER ---------------- //
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 14),
//                     child: Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.close, color: AppColor.primaryColor),
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

//                   // ---------------- BODY ---------------- //
//                   Expanded(
//                     child: ListView.builder(
//                       padding: const EdgeInsets.all(16),
//                       itemCount: replies.length,
//                       itemBuilder: (context, index) {
//                         final item = replies[index];
//                         final isUser = item["senderRole"] == "user";

//                         return Align(
//                           alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//                           child: Container(
//                             margin: const EdgeInsets.symmetric(vertical: 6),
//                             padding: const EdgeInsets.all(12),
//                             constraints: const BoxConstraints(maxWidth: 260),
//                             decoration: BoxDecoration(
//                               color: isUser
//                                   ? Colors.green.shade50
//                                   : Colors.white,
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(
//                                 color: isUser ? Colors.green.shade200 : Colors.grey.shade300,
//                               ),
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

//                   // ---------------- INPUT BAR ---------------- //
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade100,
//                       borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
//                     ),
//                     child: Row(
//                       children: [
//                         IconButton(
//                           onPressed: () {},
//                           icon: const Icon(Icons.attach_file),
//                         ),

//                         Expanded(
//                           child: TextField(
//                             controller: replyController,
//                             decoration: InputDecoration(
//                               hintText: "اكتب ردك...",
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

//                         CircleAvatar(
//                           radius: 22,
//                           backgroundColor: AppColor.primaryColor,
//                           child: IconButton(
//                             onPressed: () {
//                               if (replyController.text.trim().isEmpty) return;

//                               setState(() {
//                                 replies.add({
//                                   "text": replyController.text.trim(),
//                                   "isRequest": false, // رد من المستخدم
//                                   "senderRole": "user",
//                                   "date": DateTime.now().toString(),
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


void showExtraRequestDialog(
  BuildContext context,
  List<Comment> data,
  int complaintId, // معرف الشكوى لإرسال الرد
) {
  final TextEditingController replyController = TextEditingController();

  // تحويل التعليقات إلى قائمة متوافقة مع Object?
  final List<Map<String, Object?>> replies = data.map((comment) {
    return <String, Object?>{
      "text": comment.text ?? '',
      "isRequest": comment.complaintType == "info_request",
      "senderRole": comment.user.role ?? '',
      // "date": comment.createdAt ?? DateTime.now().toString(),
    };
  }).toList();

  final detailsCubit = context.read<ComplaintDetailsCubit>();

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            backgroundColor: Colors.grey.shade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              height: MediaQuery.of(context).size.height * 0.70,
              child: Column(
                children: [
                  // ---------- HEADER ---------- //
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close, color: AppColor.primaryColor),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Expanded(
                          child: Text(
                            'طلب معلومات إضافية',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),

                  // ---------- BODY (قائمة التعليقات) ---------- //
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: replies.length,
                      itemBuilder: (context, index) {
                        final item = replies[index];
                        final isUser = (item["senderRole"] as String?) == "user";

                        return Align(
                          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.all(12),
                            constraints: const BoxConstraints(maxWidth: 260),
                            decoration: BoxDecoration(
                              color: isUser ? Colors.green.shade50 : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isUser ? Colors.green.shade200 : Colors.grey.shade300,
                              ),
                            ),
                            child: Text(
                              item["text"] as String? ?? '',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // ---------- INPUT BAR (إرسال رد) ---------- //
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.attach_file),
                        ),

                        Expanded(
                          child: TextField(
                            controller: replyController,
                            decoration: InputDecoration(
                              hintText: "اكتب ردك...",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        CircleAvatar(
                          radius: 22,
                          backgroundColor: AppColor.primaryColor,
                          child: IconButton(
                            onPressed: () {
                              final text = replyController.text.trim();
                              if (text.isEmpty) return;

                              // ✅ إضافة الرد محلياً داخل الـ dialog
                              setState(() {
                                replies.add(<String, Object?>{
                                  "text": text,
                                  "isRequest": false,
                                  "senderRole": "user",
                                  "date": DateTime.now().toString(),
                                });
                              });

                              // ✅ إرسال الرد باستخدام Cubit
                              detailsCubit.sendReply(
                                complaintId: complaintId,
                                text: text,
                              );

                              replyController.clear();
                            },
                            icon: const Icon(Icons.send, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
