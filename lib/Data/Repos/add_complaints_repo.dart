import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shakwa/Core/Constants/end_points.dart';
import 'package:shakwa/Core/Network/Api/api_consumer.dart';
import 'package:shakwa/Core/Network/Errors/failure_handle.dart';
import 'package:shakwa/Data/Models/complaints_type_model.dart';
import 'package:shakwa/Data/Models/government_model.dart';

class AddComplaintsRepo {
  final Api api;
  AddComplaintsRepo(this.api);

  Future<Either<Failure, GovernmentModel>> getAllGovernment() async {
    try {
      final response = await api.get(EndPoints.allGovernment);
      final governments = GovernmentModel.fromJson(response);
      // (response['data'] as List)
      //     .map((e) => GovernmentModel.fromJson(e))
      //     .toList();
      return Right(governments);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, ComplaintTypeResponse>> getComplaintType(
    String id,
  ) async {
    try {
      final response = await api.get(EndPoints.cType + id);
      final types = ComplaintTypeResponse.fromJson(response);
      return Right(types);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
