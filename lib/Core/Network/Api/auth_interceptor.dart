import 'package:dio/dio.dart';
import 'package:shakwa/Core/Constants/end_points.dart';
import 'package:shakwa/Core/cache_helper.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  AuthInterceptor(this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await CacheHelper.getSecureData(key: "accessToken");

    if (accessToken != null) {
      options.headers["Authorization"] = "Bearer $accessToken";
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token Expired
      final refreshToken = await CacheHelper.getSecureData(key: "refreshToken");

      if (refreshToken != null) {
        try {
          final refreshResponse = await dio.post(
            EndPoints.refreshToken,
            data: {"refreshToken": refreshToken},
          );
          final newAccessToken = refreshResponse.data['data']["accessToken"];

          // Save new token
          await CacheHelper.setSecureData(
            key: "accessToken",
            value: newAccessToken,
          );
          await CacheHelper.setSecureData(
            key: "refreshToken",
            value: refreshToken,
          );

          // Retry original request
          err.requestOptions.headers["Authorization"] =
              "Bearer $newAccessToken";

          final cloneReq = await dio.fetch(err.requestOptions);
          return handler.resolve(cloneReq);
        } catch (e) {
          // Refresh failed → force logout
          return handler.next(err);
        }
      }
    }

    return handler.next(err);
  }
}
