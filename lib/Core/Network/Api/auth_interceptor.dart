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
    // تحقق من أن الخطأ 401
    if (err.response?.statusCode == 401) {
      final refreshToken = await CacheHelper.getSecureData(key: "refreshToken");

      // تحقق من وجود refresh token
      if (refreshToken != null) {
        // **تجنب حلقة لانهائية**
        final isRefreshRequest = err.requestOptions.path.contains(
          EndPoints.refreshToken,
        );
        if (isRefreshRequest) {
          // فشل تحديث الـ token → logout
          return handler.next(err);
        }

        try {
          // طلب تحديث الـ token
          final refreshResponse = await dio.post(
            EndPoints.refreshToken,
            data: {"refreshToken": refreshToken},
          );

          final newAccessToken = refreshResponse.data['data']["accessToken"];

          // حفظ الـ token الجديد
          await CacheHelper.setSecureData(
            key: "accessToken",
            value: newAccessToken,
          );

          // إعادة إرسال الطلب الأصلي بالـ token الجديد
          final opts = err.requestOptions;
          opts.headers["Authorization"] = "Bearer $newAccessToken";

          final cloneReq = await dio.fetch(opts);
          return handler.resolve(cloneReq);
        } catch (e) {
          // فشل التحديث → logout
          return handler.next(err);
        }
      }
    }
    return handler.next(err);
  }
}
