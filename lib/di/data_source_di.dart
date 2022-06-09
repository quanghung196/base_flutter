import 'package:get_it/get_it.dart';
import 'dart:developer' as developer;

class DataSourceDI {
  DataSourceDI._();

  static Future<void> config(GetIt injector) async {
    try {
      // injector.registerLazySingleton<AuthenticationRemote>(
      //   () => AuthenticationRemoteImpl(injector()),
      // );
    } catch (e) {
      developer.log('Config ServiceDependencies failed');
    }
  }
}
