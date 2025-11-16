import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  const Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure("انتهت مهلة الإتصال بالخادم");
      case DioExceptionType.sendTimeout:
        return ServerFailure("انتهت مهلة الإرسال إلى الخادم");
      case DioExceptionType.receiveTimeout:
        return ServerFailure("انتهت مهلة الإستلام من الخادم");
      case DioExceptionType.badCertificate:
        return ServerFailure("انتهت مهلة الإتصال بالخادم");
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response!.statusCode,
          dioError.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure("تم إلغاء الطلب إلى الخادم ");
      case DioExceptionType.connectionError:
        return ServerFailure("لا يوجد إتصال بالانترنت");
      case DioExceptionType.unknown:
        return ServerFailure("حدث خطأ غير متوقع يرجى المحاولة مرة أخرى");
      default:
        return ServerFailure('عذراً حدث خطأ يرجى المحاولة مرة أخرى');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['message']);
    } else if (statusCode == 422) {
      return ServerFailure(response['message']);
    } else if (statusCode == 500) {
      return ServerFailure("خطأ في الخادم الداخلي يرجى المحاولة مرة أخرى");
    } else {
      return ServerFailure('عذراً حدث خطأ يرجى المحاولة مرة أخرى');
    }
  }
}
