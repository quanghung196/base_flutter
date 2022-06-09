import 'package:base/app/presentation/pages/pages.dart';
import 'package:base/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'dart:developer' as developer;

class PageDI {
  PageDI._();

  static Future<void> config(GetIt injector) async {
    try {
      injector.registerFactory<Widget>(
        () => const TestPage(),
        instanceName: RouteConstants.test,
      );
    } catch (e) {
      developer.log('Config PageDependencies failed');
    }
  }
}
