import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'app_config.dart';
import 'core/core.dart';
import 'helpers/helpers.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await NotificationHelper.instance.registerNotification();
  await EasyLocalization.ensureInitialized();
  await AppConfig.instance.configApp(env: Env.dev);

  final startLocale = await LocaleHelper.instance.getDefaultLocale();
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    EasyLocalization(
        supportedLocales: LocaleHelper.instance.supportedLocales,
        path: LocaleConstants.localPath,
        fallbackLocale: LocaleHelper.instance.fallbackLocale,
        startLocale: startLocale,
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'App Name',
      theme: ThemeConstants.get(context),
      onGenerateRoute: RouteConfig.instance.routes,
      onGenerateInitialRoutes: (_) => [
        RouteConfig.instance.routeWithName(
          routeName: RouteConstants.test,
        ),
      ],
      builder: EasyLoading.init(),
    );
  }
}
