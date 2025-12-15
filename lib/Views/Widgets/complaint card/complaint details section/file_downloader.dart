import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class FileDownloader {
  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  static Future<File?> downloadFile(String url, String fileName) async {
    try {
      final dir = await getTemporaryDirectory();
      final filePath = '${dir.path}/$fileName';
      final file = File(filePath);

      if (await file.exists()) {
        print("الملف موجود محلياً في: $filePath");
        return file;    
      }

      print("بدء تحميل الملف من الشبكة: $url");
      await _dio.download(
        url,
        filePath,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
          receiveDataWhenStatusError: true,
        ),
      );

      return File(filePath);
    } catch (e) {
      print("حدث خطأ أثناء تحميل الملف: $e");
      return null;
    }
  }
}