import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../models/models.dart';

abstract class AppClient {
  Future<Either<Failure, Map<String, dynamic>?>> call(
      String path, {
        required RestfulMethod method,
        Map<String, dynamic>? queryParameters,
        dynamic data,
      });
}

enum RestfulMethod { get, post, put, delete }

class AppClientImpl extends AppClient {
  final Dio? dio;

  AppClientImpl({
    this.dio,
  });

  @override
  Future<Either<Failure, Map<String, dynamic>?>> call(
      String path, {
        required RestfulMethod method,
        Map<String, dynamic>? queryParameters,
        dynamic data,
      }) async {
    if (dio == null) {
      return Left(Failure(code: 1000));
    }
    try {
      Response<dynamic>? response;
      if (method == RestfulMethod.get) {
        response = await dio?.get(path, queryParameters: queryParameters);
      } else if (method == RestfulMethod.post) {
        response = await dio?.post(path, data: data);
      } else if (method == RestfulMethod.put) {
        response = await dio?.put(path, data: data);
      } else if (method == RestfulMethod.delete) {
        response = await dio?.delete(path, data: data);
      }
      return _parseResponse(
        response,
      );
    } on DioError catch (e) {
      if (e.error is SocketException) {
        return Left(Failure(code: 2000));
      }
      if (e.type == DioErrorType.connectTimeout) {
        return Left(Failure(code: 1500));
      }
      return _parseResponse(e.response);
    } catch (error) {
      return Left(Failure(code: 500));
    }
  }

  Either<Failure, Map<String, dynamic>?> _parseResponse(
      Response<dynamic>? response,
      ) {
    if (response == null) {
      return Left(Failure(code: 500));
    }
    if (response.statusCode != 200 && response.statusCode != 201) {
      if (response.statusCode == 401) {
        // BlocProvider.of<AppBloc>(navigatorKey.currentContext!)
        //     .add(ForceLogout());
      }
      final messageCode = response.data['message_code'];
      if (messageCode is Map<String, dynamic>?) {
        return Left(
          Failure(
            code: response.statusCode,
            multiMessageCode: messageCode,
          ),
        );
      } else if (messageCode is String) {
        return Left(
          Failure(
            code: response.statusCode,
            singleMessageCode: messageCode,
          ),
        );
      } else {
        return Left(
          Failure(
            code: response.statusCode,
          ),
        );
      }
    }

    final data = response.data as Map<String, dynamic>?;
    return Right(data);
  }
}
