// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shakwa/Controllers/complaint_details/complaint_details_cubit.dart';
// import 'package:shakwa/Core/Constants/app_color.dart';
// import 'package:shakwa/Data/Models/complaint_details_model.dart';

// void showExtraRequestDialog({
//   required BuildContext context,
//   required int complaintId,
//   required ComplaintDetailsCubit cubit,
// }) {
//   final TextEditingController replyController = TextEditingController();
//   final ScrollController scrollController = ScrollController();

//   showDialog(
//     context: context,
//     builder: (context) {
//       return Dialog(
//         backgroundColor: Colors.grey.shade100,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 14),
//           height: MediaQuery.of(context).size.height * 0.70,
//           child: Column(
//             children: [
//               // HEADER
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 14),
//                 child: Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(
//                         Icons.close,
//                         color: AppColor.primaryColor,
//                       ),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     const Expanded(
//                       child: Text(
//                         'طلب معلومات إضافية',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: AppColor.primaryColor,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 48),
//                   ],
//                 ),
//               ),

//               // الرسائل (Realtime)
//               Expanded(
//                 child: BlocBuilder<
//                   ComplaintDetailsCubit,
//                   ComplaintDetailsState
//                 >(
//                   bloc: cubit,
//                   buildWhen:
//                       (prev, curr) =>
//                           curr is ComplaintRepliesUpdated ||
//                           curr is ComplaintDetailsSuccess,
//                   builder: (context, state) {
//                     List<Comment> replies = [];

//                     if (state is ComplaintDetailsSuccess) {
//                       // أول مرة يفتح الـ dialog
//                       replies = List.from(
//                         state.complaintDetailsModel.requestsAndReplies,
//                       );
//                       cubit.currentReplies = List.from(replies);
//                     } else if (state is ComplaintRepliesUpdated) {
//                       replies = List.from(state.replies);
//                     } else {
//                       replies = List.from(cubit.currentReplies);
//                     }

//                     // Scroll تلقائي لأسفل عند وجود عناصر
//                     WidgetsBinding.instance.addPostFrameCallback((_) {
//                       if (scrollController.hasClients) {
//                         scrollController.jumpTo(
//                           scrollController.position.maxScrollExtent,
//                         );
//                       }
//                     });

//                     return ListView.builder(
//                       controller: scrollController,
//                       padding: const EdgeInsets.all(16),
//                       itemCount: replies.length,
//                       itemBuilder: (context, index) {
//                         final comment = replies[index];
//                         final bool isUser = comment.user.role == "user";

//                         return Align(
//                           alignment:
//                               isUser
//                                   ? Alignment.centerRight
//                                   : Alignment.centerLeft,
//                           child: Container(
//                             margin: const EdgeInsets.symmetric(vertical: 6),
//                             padding: const EdgeInsets.all(12),
//                             constraints: const BoxConstraints(maxWidth: 260),
//                             decoration: BoxDecoration(
//                               color:
//                                   isUser ? Colors.green.shade50 : Colors.white,
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(
//                                 color:
//                                     isUser
//                                         ? Colors.green.shade200
//                                         : Colors.grey.shade300,
//                               ),
//                             ),
//                             child: Text(comment.text),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),

//               // إدخال رسالة جديدة
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 10,
//                   vertical: 8,
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: replyController,
//                         decoration: InputDecoration(
//                           hintText: "اكتب ردك...",
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     CircleAvatar(
//                       radius: 22,
//                       backgroundColor: AppColor.primaryColor,
//                       child: IconButton(
//                         onPressed: () {
//                           final text = replyController.text.trim();
//                           if (text.isEmpty) return;

//                           // إضافة محلية فوراً
//                           cubit.addLocalReply(
//                             Comment(
//                               text: text,
//                               user: User(
//                                 role: "user",
//                                 id: complaintId,
//                                 fullName: '',
//                               ),
//                               complaintType: "reply",
//                               createdAt: DateTime.now().toString(),
//                               id: complaintId,
//                             ),
//                           );

//                           // إرسال للباك
//                           cubit.sendReply(complaintId: complaintId, text: text);

//                           replyController.clear();
//                         },
//                         icon: const Icon(Icons.send, color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
import 'package:flutter/material.dart';
import 'package:shakwa/Controllers/complaint_details/complaint_details_cubit.dart';

import 'extra_request_header.dart';
import 'extra_request_messages.dart';
import 'extra_request_input.dart';

void showExtraRequestDialog({
  required BuildContext context,
  required int complaintId,
  required ComplaintDetailsCubit cubit,
}) {
  final TextEditingController replyController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
      //  backgroundColor: Colors.grey.shade100,
       // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            children: [
              const ExtraRequestHeader(),
              Expanded(
                child: ExtraRequestMessages(
                  cubit: cubit,
                  scrollController: scrollController,
                ),
              ),
              ExtraRequestInput(
                complaintId: complaintId,
                cubit: cubit,
                controller: replyController,
              ),
            ],
          ),
        ),
      );
    },
  );
}
