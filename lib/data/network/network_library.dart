import 'dart:convert';

import 'package:dio/dio.dart';

class NetworkLibrary {
  NetworkLibrary();

  Dio buildStandardDio<T>(Map<String, String> headers) {
    var dio = Dio();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) {
          print('request to ${options.baseUrl}${options.path}');
          print('header $headers');
          options.headers.addAll(headers);
          return options;
        },
        onResponse: (Response response) {
          // print('${response.data.toString()}');
          if (response.data is String && response.data.isEmpty) {
            response.data = Map<String, dynamic>();
          // } else if (response.data is List) {
          //   response.data = {'list': response.data};
          } else {
            response.data = jsonDecode(response.data);
          }
          return response;
        },
      ),
    );
    return dio;
  }
}
