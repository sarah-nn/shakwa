import 'package:dio/dio.dart';
import 'dart:developer';

class DioLoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log("================== REQUEST ==================");
    log("URI: ${options.uri}");
    log("Method: ${options.method}");
    log("Headers: ${options.headers}");
    log("Body: ${options.data}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("================== RESPONSE ==================");
    log("URI: ${response.realUri}");
    log("Status Code: ${response.statusCode}");
    log("Data: ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log("================== ERROR ==================");
    log("URI: ${err.requestOptions.uri}");
    log("Message: ${err.message}");
    log("Response: ${err.response?.data}");
    super.onError(err, handler);
  }
}
