import 'package:dio/dio.dart';
import 'package:shakwa/Core/Constants/end_points.dart';
import 'package:shakwa/Core/Network/Api/api_consumer.dart';
import 'package:shakwa/Core/Network/Api/auth_interceptor.dart';
import 'package:shakwa/Core/Network/Api/dio_logger_interceptors.dart';

class DioConsumer implements Api {
  late Dio _dio;

  DioConsumer(Dio dio) {
    _dio = dio;
    _dio.options = BaseOptions(
      baseUrl: EndPoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      receiveDataWhenStatusError: true,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    _dio.interceptors.add(AuthInterceptor(dio));
    _dio.interceptors.add(DioLoggerInterceptor());
  }

  @override
  Future<Map<String, dynamic>> get(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.get(endPoint, queryParameters: queryParameters);
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> post(String endPoint, dynamic data) async {
    final response = await _dio.post(endPoint, data: data);
    return response.data;
  }
}
