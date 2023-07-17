import 'dart:developer';

import '../../core_imports.dart';

class CustomInterceptor extends InterceptorsWrapper {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log('================= ERROR =================');
    log('${err.response}', name: 'ERROR:');
    log('=============== END ERROR ===============');

    err.error = err.response!.data['message'][0];
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('================= ${options.method} =================');
    log('${options.uri}', name: 'URL:');
    log('${options.headers}', name: 'HEADER:');
    log('${options.data}', name: 'BODY:');
    log('=============== END ${options.method} ===============');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('================= RESPONSE =================');
    log('${response.data}', name: 'RESPONSE:');
    log('=============== END RESPONSE ===============');

    handler.next(response);
  }
}
