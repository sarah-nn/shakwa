import 'package:shakwa/Core/cache_helper.dart';

class TokenHandler {
  final CacheHelper cacheHelper;

  TokenHandler(this.cacheHelper);

  static const String parentTokenKey = "parent_token";
  static const String studentTokenKey = "student_token";

  Future<void> saveToken(String key, String token) async {
    await cacheHelper.saveData(key: key, value: token);
  }

  String? getToken(String key) {
    return cacheHelper.getDataString(key: key);
  }

  Future<void> clearToken(String key) async {
    await cacheHelper.removeData(key: key);
  }

  bool hasToken(String key) {
    return cacheHelper.getDataString(key: key) != null;
  }
}
