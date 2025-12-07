import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart'; // نحتاج لاستيراد Dio للتعرف على FormData
import 'package:shakwa/Core/Constants/end_points.dart';
import 'package:shakwa/Core/Network/Api/api_consumer.dart';
import 'package:shakwa/Core/Network/Errors/failure_handle.dart';

class SendComplaintRepo {
  final Api api; // تم تعديل الاسم ليكون ApiConsumer ليتوافق مع التسمية العامة
  SendComplaintRepo(this.api);

  // تم تعديل التوقيع لاستقبال FormData بدلاً من Map
  Future<Either<Failure, String>> sendComplaint(FormData body) async {
    try {
      // تمرير FormData مباشرة إلى دالة api.post
      await api.post(EndPoints.sendComplaint, body);

      return const Right("Complaint sent successfully");
    } on Exception catch (e) {
      if (e is DioException) {
        // استخدام ServerFailure من DioException
        return left(ServerFailure.fromDioError(e));
      }
      // في حالة أي خطأ آخر
      return left(ServerFailure(e.toString()));
    }
  }
}

// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:shakwa/Core/Constants/end_points.dart';
// import 'package:shakwa/Core/Network/Api/api_consumer.dart';
// import 'package:shakwa/Core/Network/Errors/failure_handle.dart';

// class SendComplaintRepo {
//   final Api api;
//   SendComplaintRepo(this.api);

//   Future<Either<Failure, String>> sendComplaint(Map body) async {
//     try {
//       await api.post(EndPoints.sendComplaint, body);
//       return const Right("singup done");
//     } on Exception catch (e) {
//       if (e is DioException) {
//         return left(ServerFailure.fromDioError(e));
//       }
//       return left(ServerFailure(e.toString()));
//     }
//   }
// }
