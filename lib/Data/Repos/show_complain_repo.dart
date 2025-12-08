import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shakwa/Core/Constants/end_points.dart';
import 'package:shakwa/Core/Network/Api/api_consumer.dart';
import 'package:shakwa/Core/Network/Errors/failure_handle.dart';
import 'package:shakwa/Data/Models/complaint_details_model.dart';
import 'package:shakwa/Data/Models/complaint_model.dart';
import 'package:shakwa/Data/Models/pagination_model.dart';

class ShowComplaintRepo {
  final Api api;
  ShowComplaintRepo(this.api);

  Future<Either<Failure, ComplaintPaginationModel>> getComplaint({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await api.get(
        '${EndPoints.complaint}?page=$page&limit=$limit',
      );

      final data = response['data'];

      List<ComplaintModel> complaintModel = [];

      for (var item in data['data']) {
        complaintModel.add(ComplaintModel.fromJson(item));
      }
      final paginationModel = ComplaintPaginationModel(
        complaints: complaintModel,
        total: data['total'] as int,
        page: int.tryParse(data['page']) ?? 1,
        limit: int.tryParse(data['limit']) ?? 10,
      );

      return Right(paginationModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, ComplaintDetailsModel>> getCompanintDetails(
    int complaint,
  ) async {
    try {
      final response = await api.get(
        EndPoints.complaintDetails + complaint.toString(),
      );

      final ComplaintDetailsModel complaintDetailsModel =
          ComplaintDetailsModel.fromJson(response['data']);

      return Right(complaintDetailsModel);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // Future<Either<Failure, bool>> sendReply({

  Future<Either<Failure, bool>> sendReply({
    required int complaintId,
    required String text,
  }) async {
    try {
      // تجهيز البيانات التي سترسل في جسم الطلب

      // إرسال POST
      final response = await api.post(EndPoints.sendReply, {
        "complaint_id": complaintId,
        "comment_text": text,
      });
      // final response = await api.post(EndPoints.sendReply, {
      //   "complaint_id": complaintId,
      //   "comment_text": text,
      // });

      // يمكنك التحقق من الحالة
      if (response['status'] == 'success') {
        return Right(true);
      } else {
        return Left(ServerFailure(response['message'] ?? 'خطأ غير معروف'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
