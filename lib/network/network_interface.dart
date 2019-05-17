import 'package:dio/dio.dart';

import 'config.dart';
import 'network_library.dart';
import 'network_model.dart';
class NetworkInterface{
  static const String _baseUrl = BASE_URL;
  NetworkLibrary library = NetworkLibrary();
  
  NetworkInterface();
  
  Future<NetworkModel> requestGet({
    String baseUrl = _baseUrl,
    String path,
    Map<String, dynamic> queryParameters,
  }) async {
    {
      NetworkModel model;
      try {
        model = await library
            .buildStandardDio(_buildBasicHeader())
            .get("$baseUrl$path", queryParameters: queryParameters)
            .then((jsonResponse) {
              return NetworkModel(jsonResponse.statusCode, jsonResponse.data, '');
            });
      } on DioError catch (e) {
        model = handleError(e, model);
      }
      return model;
    }
  }

  NetworkModel handleError(DioError e, NetworkModel model) {
    print('Network Error ${e.message}');
    if (e.response != null) {
      model = NetworkModel(e.response.statusCode ?? 0, Map(), e.message);
    } else model = NetworkModel(0, Map(), e.message);
    return model;
  }

  Map<String, String> _buildBasicHeader() {
    var headers = Map<String, String>();
    headers.putIfAbsent("content-type", () {
      return "application/json";
    });
    return headers;
  }
}