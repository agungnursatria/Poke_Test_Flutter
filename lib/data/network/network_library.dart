import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:test_app/env.dart';
import 'package:test_app/utility/log/dio_logger.dart';

class NetworkLibrary {
  NetworkLibrary();

  static const String TAG = 'NetworkLibrary';

  Dio buildStandardDio<T>(Map<String, String> headers) {
    var dio = Dio();
    
    dio.interceptors.add(
      InterceptorsWrapper(onRequest: (RequestOptions options) {
        options.headers.addAll(headers);
        DioLogger.onSend(TAG, options);
        return options;
      }, onResponse: (Response response) {
        if (response.data is String && response.data.isEmpty) {
          response.data = Map<String, dynamic>();
          // } else if (response.data is List) {
          //   response.data = {'list': response.data};
        } else {
          response.data = jsonDecode(response.data);
        }
        DioLogger.onSuccess(TAG, response);
        return response;
      }, onError: (DioError error) {
        DioLogger.onError(TAG, error);
        return error;
      }),
    );

    if (Env.value.alice != null) {
      dio.interceptors.add(Env.value.alice.getDioInterceptor());
    }

    return dio;
  }
}
