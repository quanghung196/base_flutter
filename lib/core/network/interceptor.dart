import 'dart:convert';

import 'package:dio/dio.dart';
import 'dart:developer' as developer;

class AppInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    developer.log('---------------------------------------------------');
    developer.log(
        'REQUEST[${options.method}] => PATH:${options.baseUrl}${options.path}');

    if (options.data is Map) {
      if (options.queryParameters.isNotEmpty) {
        developer
            .log('queryParameters :\n${json.encode(options.queryParameters)}');
      }
      if (options.data != null) {
        developer.log('data:\n${json.encode(options.data)}');
      }
    }

    // options.headers['content-type'] = 'application/json';

    // if (UserInfo.isLoggedIn) {
    //   options.headers['Authorization'] = 'Bearer ${UserInfo.authObject?.token}';
    //   options.headers['x-locale'] = LocaleHelper.instance.isEnglish()
    //       ? LocaleConstants.english
    //       : LocaleConstants.japanese;
    //   developer.log('token :\n${UserInfo.authObject?.token}');
    // }
    developer.log('---------------------------------------------------');

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    developer.log('---------------------------------------------------');
    developer.log(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    if (response.data is Map) {
      developer.log('data: \n' + json.encode(response.data));
      developer.log('statusMessage: \n' + json.encode(response.statusMessage));
    }
    developer.log('---------------------------------------------------');

    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    developer.log(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    if (err.response?.data is Map) {
      developer.log(json.encode(err.response?.data));
      developer.log(json.encode(err.response?.statusMessage));
    }

    return super.onError(err, handler);
  }
}
