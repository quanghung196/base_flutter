import 'package:get_it/get_it.dart';
import 'dart:developer' as developer;

class RepositoryDI {
  RepositoryDI._();

  static Future<void> config(GetIt injector) async {
    try {
      // injector.registerLazySingleton<AuthRepository>(
      //   () => AuthRepositoryImpl(injector()),
      // );
    } catch (e) {
      developer.log('Config Service Dependencies failed');
    }
  }
}
