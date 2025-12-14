import 'dart:developer';

import 'package:dio/dio.dart';

class DioInterceptorLogger extends Interceptor {
  /// Print request [Options]
  final bool request;

  /// Print request header [Options.headers]
  final bool requestHeader;

  /// Print request data [Options.data]
  final bool requestBody;

  /// Print [Response.data]
  final bool responseBody;

  /// Print [Response.headers]
  final bool responseHeader;

  /// Print error message
  final bool error;

  /// Print compact json response
  final bool compact;

  /// Width size per logPrint
  final int maxWidth;

  DioInterceptorLogger({
    this.request = true,
    this.requestHeader = false,
    this.requestBody = false,
    this.responseHeader = false,
    this.responseBody = true,
    this.error = true,
    this.maxWidth = 90,
    this.compact = true,
  });

  String endPoint(String path) {
    if (path.contains('?')) {
      return path.split('?').first;
    } else {
      return path;
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters;
    log(
      '\x1B[32m<-------------------------- ⚡ Start Request ${endPoint(options.uri.path)} ⚡ -------------------------->\x1B[0m',
    );
    line();
    log('⭐ Base URL: ${options.baseUrl}');
    line();

    log('\x1B[35m🚀 Query Parameters: \x1B[0m');
    options.queryParameters.forEach((key, value) {
      log('> $key: ${value.toString()}');
    });
    line();

    log('\x1B[35m🔥 Headers: \x1B[0m');
    options.headers.forEach((key, value) {
      log('> $key: ${value.toString()}');
    });
    line();

    log('\x1B[35m💎 Extras: \x1B[0m');
    options.extra.forEach((key, value) {
      log('> $key: ${value.toString()}');
    });
    line();

    log('\x1B[35m✨ Body: \x1B[0m');
    final dynamic data = options.data;
    if (data != null) {
      if (data is String) {
        log(
          '\x1B[32m ${endPoint(options.uri.path)} -> BODY-RES> $data \x1B[0m',
        );
      }
      if (data is Map) {
        log(
          '\x1B[32m ${endPoint(options.uri.path)} -> BODY-RES> $data \x1B[0m',
        );
      }
      if (data is FormData) {
        final formDataMap = <String, dynamic>{}
          ..addEntries(data.fields)
          ..addEntries(data.files);

        log('!! Form data | ${data.boundary} !!');
        log(
          '\x1B[32m ${endPoint(options.uri.path)} -> BODY-RES> $formDataMap \x1B[0m',
        );
      }
    }
    line();

    log('\x1B[35m🚩 Details:\x1B[0m');
    log('> Content Type: ${options.contentType}');
    log('> Response Type: ${options.responseType.name}\n');
    log('> Follow Redirects: ${options.followRedirects}');
    log('> Receive Timeout: ${options.receiveTimeout} ms');
    log('> Send Timeout: ${options.sendTimeout} ms');
    log('> Connect Timeout: ${options.connectTimeout} ms');
    line();

    log(
      '\x1B[32m <-------------------------- ⚡ End Request ${endPoint(options.uri.path)} ⚡ -------------------------->\x1B[0m',
    );

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      log(
        '\x1B[34m<-------------------------- ⚡⚡ Start Response ${endPoint(response.requestOptions.path)} ⚡⚡ -------------------------->\x1B[0m',
      );
      line();
      log('\x1B[35m🚨 Status: \x1B[0m');
      log('> Status Code: ${response.statusCode}');
      log('> Status Message: ${response.statusMessage}');
      line();

      log('\x1B[35m✨ Body: \x1B[0m');
      log(
        '\x1B[32m ${endPoint(response.requestOptions.path)} -> BODY-RES> ${response.data} \x1B[0m',
      );
      line();

      log('\x1B[35m🔥 Headers: \x1B[0m');
      response.headers.map.forEach((key, value) {
        log('> $key: ${value.toString()}');
      });
      line();

      log('\x1B[35m💎 Extras: \x1B[0m');
      response.extra.forEach((key, value) {
        log('> $key: ${value.toString()}');
      });
      line();

      log('\x1B[35m🚩 Details: \x1B[0m');
      log('> Content Type: ${response.requestOptions.contentType}');
      log('> Response Type: ${response.requestOptions.responseType.name}\n');
      log('> Follow Redirects: ${response.requestOptions.followRedirects}');
      log('> Receive Timeout: ${response.requestOptions.receiveTimeout} ms');
      log('> Send Timeout: ${response.requestOptions.sendTimeout} ms');
      log('> Connect Timeout: ${response.requestOptions.connectTimeout} ms');
      line();

      log(
        '\x1B[34m<-------------------------- ⚡⚡ End Response ${endPoint(response.requestOptions.path)} ⚡⚡ -------------------------->\x1B[0m',
      );
    });

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      log(
        '\x1B[31m<-------------------------- ⚠⚠ Start Response ${endPoint(err.requestOptions.uri.path)}  ⚠⚠ -------------------------->\x1B[0m',
      );

      log('\x1B[35m🚨 Status: \x1B[0m');
      log('> Status Code: ${err.response?.statusCode}');
      log('> Status Message: ${err.response?.statusMessage}');
      line();

      log('\x1B[35m✨ Body: \x1B[0m');
      log(
        '\x1B[32m${(err.response != null && err.response?.data != null) ? "BODY-RES>  ${err.response!.data.toString()}" : ''} \x1B[0m',
      );
      line();

      log('\x1B[35m⚠ Error: \x1B[0m');
      log('> Type: ${err.type.name}');
      log('> error: ${err.error.toString()}');
      log('> message: ${err.message.toString()}');

      log('\x1B[35m🚩 Details: \x1B[0m');
      log('> Content Type: ${err.requestOptions.contentType}');
      log('> Response Type: ${err.requestOptions.responseType.name}\n');
      log('> Follow Redirects: ${err.requestOptions.followRedirects}');
      log('> Receive Timeout: ${err.requestOptions.receiveTimeout} ms');
      log('> Send Timeout: ${err.requestOptions.sendTimeout} ms');
      log('> Connect Timeout: ${err.requestOptions.connectTimeout} ms');
      line();

      log(
        '\x1B[31m<-------------------------- ⚠⚠ End Response ${endPoint(err.requestOptions.uri.path)}  ⚠⚠ -------------------------->\x1B[0m',
      );
    });

    super.onError(err, handler);
  }

  void line() {
    log('\n');
  }
}
