import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shakwa/Core/Network/Api/dio_consumer.dart';
import 'package:shakwa/Core/Network/token_handle.dart';
import 'package:shakwa/Core/cache_helper.dart';

final getit = GetIt.instance;

Future<void> setUpAppService() async {
  // Initialize shared preferences or cache if needed

  getit.registerLazySingleton<CacheHelper>(() => CacheHelper());
  await getit<CacheHelper>().init();

  // تسجيل TokenHandler مع تمرير CacheHelper
  getit.registerLazySingleton<TokenHandler>(
    () => TokenHandler(getit<CacheHelper>()),
  );

  getit.registerLazySingleton<Dio>(() => Dio());
  getit.registerLazySingleton<DioConsumer>(() => DioConsumer(getit.get<Dio>()));
  final accessToken = await CacheHelper.getSecureData(key: "accessToken");
  print("final accessToken =  $accessToken");
}
