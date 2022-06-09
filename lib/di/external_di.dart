import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'dart:developer' as developer;

import '../core/core.dart';

class ExternalDI {
  ExternalDI._();

  static Future<void> config(GetIt injector) async {
    try {
      // Network config
      final appInterceptors = [AppInterceptors()];
      final apiUrl = EnvConfig.instance.apiUrl;

      final options = BaseOptions(
        baseUrl: apiUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 30 * 1000,
        receiveTimeout: 30 * 1000,
      );
      final dio = Dio(options);
      dio.interceptors.addAll(appInterceptors);
      injector.registerLazySingleton<AppClient>(
        () => AppClientImpl(dio: dio),
      );
      injector.registerLazySingleton(
        () => InternetConnectionChecker(),
      );
      injector.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(injector()),
      );
    } catch (e) {
      developer.log('Config ExternalDependencies failed');
    }
  }
}
