abstract class Api {
  Future<Map<String, dynamic>> get(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
  });
  Future<Map<String, dynamic>> post(String endPoint, dynamic data);
}
