import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shakwa/Core/Constants/end_points.dart';
import 'package:shakwa/Core/Network/Api/api_consumer.dart';
import 'package:shakwa/Core/Network/Errors/failure_handle.dart';

class UpdateComplaintRepo {
  final Api api;
  UpdateComplaintRepo(this.api);

  Future<Either<Failure, String>> update(FormData body, int complaintId) async {
    try {
      await api.post(EndPoints.updateComplaint + complaintId.toString(), body);
      return const Right("Update successfully done");
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
