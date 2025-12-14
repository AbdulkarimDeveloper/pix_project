import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:pixa_project/core/remote/dio_interceptor_logger.dart';
import 'package:pixa_project/utils/constants.dart';

class DioInstance {
  static final DioInstance _singleton = DioInstance._();
  static DioInstance get i => _singleton;
  DioInstance._();

  dio.Dio get instnace {
    return dio.Dio()
      ..options.baseUrl = Constants.baseUrl
      ..options.validateStatus = validateStatus
      ..options.responseType = dio.ResponseType.plain
      ..options.followRedirects = true
      ..options.connectTimeout = Constants.durationRequest
      ..options.receiveTimeout = Constants.durationRequest
      ..options.sendTimeout = Constants.durationRequest
      ..options.receiveDataWhenStatusError = true
      ..options.contentType = "application/json; charset=utf-8"
      ..interceptors.addAll([if (kDebugMode) DioInterceptorLogger()]);
  }

  bool validateStatus(int? v) {
    return true;
  }
}
