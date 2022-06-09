import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:page_transition/page_transition.dart';

import '../constants/constants.dart';

class RouteConfig {
  RouteConfig._();

  static RouteConfig get instance => RouteConfig._();

  PageTransition routes(RouteSettings settings) {
    return routeWithName(settings: settings);
  }

  PageTransition routeWithName({String? routeName, RouteSettings? settings}) {
    Widget widget;
    try {
      widget = GetIt.I.get<Widget>(instanceName: routeName ?? settings?.name);
    } catch (e) {
      widget = Scaffold(
        backgroundColor: ColorConstants.white,
        appBar: AppBar(
          title: const Text(''),
        ),
        // TODO: Thay đa ngôn ngữ
        body: const Center(child: Text('Page not found')),
      );
    }
    return PageTransition(
      child: widget,
      type: PageTransitionType.fade,
      settings: settings,
    );
  }
}
