import 'package:dio/dio.dart';
import 'package:test_app/data/network/config/config.dart';
import 'package:test_app/data/network/network_library.dart';
import 'package:test_app/data/network/network_model.dart';


class NetworkInterface {
  
  /*  Config => ConfigDevelopement, 
                ConfigStaging, 
                ConfigProduction, 
                ConfigTesting       */
  static const String _baseUrl = ConfigDevelopment.BASE_URL;

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
          return NetworkModel(
              code: jsonResponse.statusCode,
              response: jsonResponse.data,
              error: '');
        });
      } on DioError catch (e) {
        model = handleError(e, model);
      }
      return model;
    }
  }

  NetworkModel handleError(DioError e, NetworkModel model) {
    if (e.response != null) {
      model = NetworkModel(
          code: e.response.statusCode ?? 0,
          response: Map(),
          error: _errorMessageBasedType(e));
    } else
      model = NetworkModel(
          code: 0,
          response: Map(),
          error: _errorMessageBasedType(e));
    return model;
  }

  Map<String, String> _buildBasicHeader() {
    var headers = Map<String, String>();
    headers.putIfAbsent("content-type", () {
      return "application/json";
    });
    return headers;
  }

  String _errorMessageBasedType(Error error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
              "Received invalid status code: ${error.response.statusCode}";
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }
}
