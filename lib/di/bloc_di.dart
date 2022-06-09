import 'package:get_it/get_it.dart';
import 'dart:developer' as developer;

class BlocDI {
  BlocDI._();

  static Future<void> config(GetIt injector) async {
    try {
      // injector.registerFactory<AuthBloc>(() => AuthBloc(injector()));
    } catch (e) {
      developer.log('Config BlocDependencies Failed');
    }
  }
}
