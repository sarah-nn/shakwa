import 'dart:io';

import 'package:dio/dio.dart'; // نحتاج لاستيراد Dio للحصول على FormData و MultipartFile
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa/Data/Repos/send_complaint_repo.dart';
part 'add_complaints_state.dart';

class AddComplaintsCubit extends Cubit<AddComplaintsState> {
  AddComplaintsCubit({required this.repo}) : super(AddComplaintsInitial());

  SendComplaintRepo repo;

  // دالة إرسال الشكوى معدلة لإرسال Multipart/FormData
  sendComplaint(String location, String desc, int id, String imagePath) async {
    try {
      // 1. إنشاء MultipartFile من مسار الصورة
      final MultipartFile imageFile = await MultipartFile.fromFile(
        imagePath,
        filename: imagePath.split('/').last, // اسم الملف
      );

      // 2. تجميع البيانات النصية والملف في FormData
      final FormData formData = FormData.fromMap({
        'location': location,
        'description': desc,
        'complaintTypeId': id,
        'files': imageFile, // إرسال كائن MultipartFile
      });

      emit(AddComplaintsLoading());

      // 3. إرسال FormData إلى الـ Repository
      final result = await repo.sendComplaint(formData);

      result.fold(
        (failure) {
          emit(AddComplaintsFailed(errMessage: failure.errorMessage));
        },
        (success) {
          emit(AddComplaintsSuccess());
        },
      );
    } catch (e) {
      // التعامل مع أي خطأ قد يحدث أثناء إنشاء FormData أو الملف
      emit(AddComplaintsFailed(errMessage: e.toString()));
    }
  }
}

// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shakwa/Data/Repos/send_complaint_repo.dart';
// part 'add_complaints_state.dart';

// class AddComplaintsCubit extends Cubit<AddComplaintsState> {
//   AddComplaintsCubit({required this.repo}) : super(AddComplaintsInitial());

//   SendComplaintRepo repo;

//   // final TextEditingController location = TextEditingController();
//   // final TextEditingController desc = TextEditingController();

//   sendComplaint(String location, String desc, int id, String imagePath) async {
//     final image = File(imagePath);
//     //  await MultipartFile.fromFile(
//     //   imagePath,
//     //   filename: imagePath.split('/').last,
//     // );
//     emit(AddComplaintsLoading());
//     final result = await repo.sendComplaint({
//       'location': location,
//       'description': desc,
//       'complaintTypeId': id,
//       'files': image,
//     });
//     result.fold(
//       (failure) {
//         emit(AddComplaintsFailed(errMessage: failure.errorMessage));
//       },
//       (success) {
//         emit(AddComplaintsSuccess());
//       },
//     );
//   }
// }
