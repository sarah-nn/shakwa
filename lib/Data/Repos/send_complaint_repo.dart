import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shakwa/Core/Constants/end_points.dart';
import 'package:shakwa/Core/Network/Api/api_consumer.dart';
import 'package:shakwa/Core/Network/Errors/failure_handle.dart';

class SendComplaintRepo {
  final Api api;
  SendComplaintRepo(this.api);

  Future<Either<Failure, String>> sendComplaint(Map body) async {
    try {
      await api.post(EndPoints.sendComplaint, body);
      return const Right("singup done");
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
