// import 'dart:io';

// import 'package:dio/dio.dart'; // نحتاج لاستيراد Dio للحصول على FormData و MultipartFile
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shakwa/Data/Repos/send_complaint_repo.dart';
// part 'add_complaints_state.dart';

// class AddComplaintsCubit extends Cubit<AddComplaintsState> {
//   AddComplaintsCubit({required this.repo}) : super(AddComplaintsInitial());

//   SendComplaintRepo repo;

//   // دالة إرسال الشكوى معدلة لإرسال Multipart/FormData
//   sendComplaint(String location, String desc, int id, String imagePath) async {
//     try {
//       // 1. إنشاء MultipartFile من مسار الصورة
//       final MultipartFile imageFile = await MultipartFile.fromFile(
//         imagePath,
//         filename: imagePath.split('/').last, // اسم الملف
//       );

//       // 2. تجميع البيانات النصية والملف في FormData
//       final FormData formData = FormData.fromMap({
//         'location': location,
//         'description': desc,
//         'complaintTypeId': id,
//         'files': imageFile, // إرسال كائن MultipartFile
//       });

//       emit(AddComplaintsLoading());

//       // 3. إرسال FormData إلى الـ Repository
//       final result = await repo.sendComplaint(formData);

//       result.fold(
//         (failure) {
//           emit(AddComplaintsFailed(errMessage: failure.errorMessage));
//         },
//         (success) {
//           emit(AddComplaintsSuccess());
//         },
//       );
//     } catch (e) {
//       // التعامل مع أي خطأ قد يحدث أثناء إنشاء FormData أو الملف
//       emit(AddComplaintsFailed(errMessage: e.toString()));
//     }
//   }
// }
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa/Data/Repos/send_complaint_repo.dart';
part 'add_complaints_state.dart';

class AddComplaintsCubit extends Cubit<AddComplaintsState> {
  AddComplaintsCubit({required this.repo}) : super(AddComplaintsInitial());

  SendComplaintRepo repo;

  sendComplaint(String location, String desc, int id, List<File> files) async {
    try {
      emit(AddComplaintsLoading());

      final List<MultipartFile> multipartFiles = [];

      for (var file in files) {
        multipartFiles.add(
          await MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
          ),
        );
      }

      final FormData formData = FormData.fromMap({
        'location': location,
        'description': desc,
        'complaintTypeId': id,
        'files': multipartFiles,
      });
      // اطباع الحقول
      print('--- FormData Fields ---');
      formData.fields.forEach((field) {
        print('${field.key}: ${field.value}');
      });

      // اطباع الملفات
      print('--- FormData Files ---');
      formData.files.forEach((file) {
        print('file field: ${file.key}');
        print('filename: ${file.value.filename}');
        print('contentType: ${file.value.contentType}');
        print('length: ${file.value.length}');
      });

      print('---  Files ---');
      print('*** قائمة الملفات ومساراتها: ***');
      for (var file in files) {
        // نطبع مسار الملف (path) لأنه هو المعرّف الرئيسي له
        print('اسم الملف/المسار: ${file.path}');
      }

      final result = await repo.sendComplaint(formData);

      result.fold(
        (failure) =>
            emit(AddComplaintsFailed(errMessage: failure.errorMessage)),
        (_) => emit(AddComplaintsSuccess()),
      );
    } catch (e) {
      emit(AddComplaintsFailed(errMessage: e.toString()));
    }
  }
}
