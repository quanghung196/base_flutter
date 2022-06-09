import 'package:base/di/di.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'core/core.dart';

class AppConfig {
  AppConfig._();

  static AppConfig get instance => AppConfig._();

  Future<void> configApp({required Env env}) async {
    await EnvConfig.instance.load(envStr: env.value);
    await DI.init();
    configUI();
  }

  void configUI() {
    EasyLoading.instance
      ..userInteractions = false
      ..dismissOnTap = false;
  }
}
