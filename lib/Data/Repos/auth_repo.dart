import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shakwa/Core/Constants/end_points.dart';
import 'package:shakwa/Core/Network/Api/api_consumer.dart';
import 'package:shakwa/Core/Network/Errors/failure_handle.dart';
import 'package:shakwa/Core/cache_helper.dart';

class AuthRepo {
  final Api api;
  AuthRepo(this.api);

  Future<Either<Failure, String>> signUp(Map body) async {
    try {
      await api.post(EndPoints.signUp, body);
      return const Right("singup done");
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, String>> signIn(Map body) async {
    try {
      var data = await api.post(EndPoints.signIn, body);
      await CacheHelper.setSecureData(
        key: "accessToken",
        value: data['data']['accessToken'],
      );
      await CacheHelper.setSecureData(
        key: "refreshToken",
        value: data['data']['refreshToken'],
      );
      return const Right("singin done");
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, String>> verify(Map body) async {
    try {
      await api.post(EndPoints.verify, body);

      return const Right("verify done");
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
